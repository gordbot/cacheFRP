#!/bin/bash
# Shell script to capture snapshot of the CRA Forward Regulatory Plan and save 
# it in a web accesible directory for later reference
# Gordon D. Bonnar -- 2020-04-07

# Set the directory for the snapshot to today's date
DIRECTORY="/var/www/frp.policygeek.ca/public_html/historical/$(date "+%Y-%m-%d")"

# If the directory doesn't exist
if [ ! -d "$DIRECTORY" ]; then
    # Make the local directory for the snapshot AND
    # Grab a copy of the directory recursively, staying within canada.ca domain, not following parent links
	mkdir $DIRECTORY && wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows --domains canada.ca --no-parent -P $DIRECTORY https://www.canada.ca/en/revenue-agency/programs/about-canada-revenue-agency-cra/acts-regulations/forward-regulatory-plan/current-initiatives/regulatory-initiatives.html

    # Move the files from the deep file file structure up to the main directory
	mv "${DIRECTORY}/www.canada.ca/en/revenue-agency/programs/about-canada-revenue-agency-cra/acts-regulations/forward-regulatory-plan/current-initiatives/"/* "${DIRECTORY}/"

    # Remove the www.canada.ca directory
	rm -r "${DIRECTORY}/www.canada.ca"

    # To facilitate browsing archives, rename the main page to index.html
    mv "${DIRECTORY}/regulatory-initiatives.html" "${DIRECTORY}/index.html"

    # Correct anchor references to point to current page
    sed -i "s/regulatory-initiatives.html//" "${DIRECTORY}/index.html"

    # Replace the stylesheet path with the local stylesheet store
    sed -i "s/..\/..\/..\/..\/..\/..\/..\/etc\/designs\/canada\/wet-boew\/css\/theme.min.css/\/styles\/theme.min.css/" "${DIRECTORY}/index.html"
fi
