# CacheFRP
Downloads the public Forward Regulatory Plans of the departments and agencies of the Government of Canada and stores a local version.

## Description
The Government of Canada's [Cabinet Directive](https://www.canada.ca/en/treasury-board-secretariat/services/federal-regulatory-management/guidelines-tools/cabinet-directive-regulation.html) on Regulation outlines a series of mandatory public postings about upcoming regulatory initiatives in the form of a Forward Regulatory Plan (FRP).  The [*Policy on Transparency and Accountability*](https://www.canada.ca/en/treasury-board-secretariat/services/federal-regulatory-management/guidelines-tools/policy-regulatory-transparency-accountability.html) requires that FRP postings be updated annually on April 1.  Updates may also occur during the year.  Departments and Agencies are not required to keep historical copies of previous FRPS.  This tool allows interested parties to easily take snapshots of the current state of federal FRPs.


## Dependencies
The script requires the use of:
* bash
* wget
* sed
* awk

## Usage
To capture a snapshot of all current departmental Forward Regulatory Plans, run:
`cachefrp.sh frpurls.csv`

Where frpurls.csv is a CSV of the form:

`Dept, url_to_FRP_index`

So, the line for the CRA would read:

` CRA,https://www.canada.ca/en/revenue-agency/programs/about-canada-revenue-agency-cra/acts-regulations/forward-regulatory-plan/current-initiatives/regulatory-initiatives.html`

#### Change dynamic directory for storing snapshots
You can change `$(date "+%Y-%m-%d")` to reflect the sub-directory to store the actual FRP snapshots.  The default will create a directory of the format YYYY-MM-DD in your base directory

## Contributing
This is a quick script I put together to help me capture changes in the Government's Forward Regulatory Plans.  All departments and agencies of the Government of Canada are required to publish these plans at least annually.  I wrote this script in the hopes of making a historical record of all Forward Regulatory Plans as the policies require that it be updated, but do not require that it be archived. 

If you have any interest in government, government reporting, screen scraping, database, or front-end development, I'd love to hear from you.  You can reach me here or at gordonbonnar@gmail.com.

## Feedback
Contributions, pull requests, and new issues are definitely welcome.

## Licensing
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
