#!/bin/bash
# Backup snapshots of Government of Canada Forward Regulatory Plans.
# Usage: cacheFRP.sh  
# Gordon D. Bonnar -- 2020-04-07

# Set internal variables to arguments passed to script
# Load parameters from source file
# FILE should be a CSV of the format: DEPT, FRPURL where::
#   DEPT - The offical short form of the department or agency name
#   FRPURL - The URL to the FRP page on the internet

# OUTPUTDIR is the base directory where you want the cached 
# FRP files to be saved. Replaced if -outputdir flag is used
# Set default inputs and outputs
OUTPUTDIR="/var/www/frp.policygeek.ca/public_html"

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -o | --outputdir )
    shift; OUTPUTDIR=$1
    ;;
  -f | --file )
    shift; FILE=$1
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

# For each line of the file, set the DEPT and FRPURL parameters
while IFS=, read -r dept url
do
    #Set variables from input  file
    DEPT=$dept
    FRPURL=$url

    # Given a URL, get the domain
    DOMAIN=$(echo $FRPURL|awk -F[/:] '{print $4}')
    
    # Grabs the file name from the end of the URL and adds html if not there
    # to replicate wget behaviour
    FILENAME="${FRPURL##*/}"
    PATTERN="\.[Hh][Tt][Mm][Ll]?$"
    if [[ ! $FILENAME =~ $PATTERN ]]; then
	FILENAME=${FILENAME}'.html'
    fi

    # Append the date to the directory using the format 
    # YYYY-MM-DD
    DIRECTORY="${OUTPUTDIR}/${DEPT}/$(date "+%Y-%m-%d")"

    # If the directory doesnt exist
    if [ ! -d "$DIRECTORY" ]; then
        # Make the local directory for the snapshot and grab a 
        # copy of the directory recursively, staying 
        # within canada.ca domain, not following parent links
        mkdir -p $DIRECTORY && wget -q --domains $DOMAIN --no-check-certificate --recursive -l 1 --page-requisites --html-extension --convert-links --no-parent -P $DIRECTORY $FRPURL 

        # wget grabs files and original source directory structure.
        # We define BASEURL as the FRPURL minus the filename
        BASEURL=$(echo ${FRPURL} | sed -E "s|https?:/(.*)/.*|\1/|")

        # We can now use BASEURL to allow use to move all of
        # of the downloaded files up to the new DIRECTORY
        mv ${DIRECTORY}${BASEURL}* ${DIRECTORY}/
        rm -r "${DIRECTORY}/${DOMAIN}"

        # To facilitate browsing archives, rename the main page to index.html
        
        mv "${DIRECTORY}/${FILENAME}" "${DIRECTORY}/index.html"

        # Correct anchor references in FILENAME to point to index page
        sed -i "s/${FILENAME}//" "${DIRECTORY}/index.html"

        # Replace the stylesheet path with the local stylesheet store
        sed -i "s|href=\".*/theme.min.css|href=\"../../styles/theme.min.css|" "${DIRECTORY}/index.html"
        
    fi
done < $FILE
