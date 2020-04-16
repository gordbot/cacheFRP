#!/bin/bash
# Shell script to capture snapshot of the CRA Forward Regulatory Plan and save 
# it in a web accesible directory for later reference
# Usage: ./cacheFRP.sh <directory> <URL>
# Gordon D. Bonnar -- 2020-04-07

# Set internal variables to arguments passed to script
# Load parameters from source file
# Config file should define:
# FRPURL - The URL to the FRP page on the internet
# DEPT - The offical short form of the department or agency name
# BASEURL - The URL from the end of the protocol to just before the filenam
# TODO: Calculate BASEURL dynamicaly

# Config file passed as argument
if [ "$#" -ne 1 ]
then
    echo "Usage: cacheFRP.sh file.conf"
    exit 1
fi
source $1

# OUTPUTDIR - Where to save fownloaded files
OUTPUTDIR="/var/www/frp.policygeek.ca/public_html"

# Prepare other variables from parameters
DOMAIN=$(echo $FRPURL|awk -F[/:] '{print $4}')
FILENAME="${FRPURL##*/}"

# Append the date to the directory using the format 
# YYYY-MM-DD
DIRECTORY="${OUTPUTDIR}/${DEPT}/$(date "+%Y-%m-%d")"


# If the directory doesnt exist
if [ ! -d "$DIRECTORY" ]; then
    # Make the local directory for the snapshot AND
    # Grab a copy of the directory recursively, staying within canada.ca domain, not following parent links
	mkdir -p $DIRECTORY && wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --domains canada.ca --no-parent -P $DIRECTORY $FRPURL 

    # When wget grabs all of the files, they are stored in the full directory structure.
    # To keep things small and easy to work with, we use FRPURL to create a $BASEURL which
    # can be used to move all the files higher in the directory.  
    BASEURL=$(echo ${FRPURL} | sed "s|https:/\(.*\)/.*|\1/|") 

    # Move the files from the deep file structure up to the main local directory
	mv "${DIRECTORY}${BASEURL}"/* "${DIRECTORY}/"

    # Remove the base domain, often but not always www.canada.ca directory
	rm -r "${DIRECTORY}/${DOMAIN}"

    # To facilitate browsing archives, rename the main page to index.html
    mv "${DIRECTORY}/${FILENAME}" "${DIRECTORY}/index.html"

    # Correct anchor references to point to current page
    sed -i "s/${FILENAME}//" "${DIRECTORY}/index.html"

    # Replace the stylesheet path with the local stylesheet store
    # TODO: Abstract or parametrize how we handle the stylesheet
    sed -i "s|href=\".*/etc/designs/canada/wet-boew/css/theme.min.css|href=\"../../styles/theme.min.css|" "${DIRECTORY}/index.html"
fi
