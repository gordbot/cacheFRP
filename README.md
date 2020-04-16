# CacheFRP
Downloads the Forward Regulatory Plans of the Canada Revenue Ageny and stores a local version.

## Description
The Government of Canada's [Cabinet Directive](https://www.canada.ca/en/treasury-board-secretariat/services/federal-regulatory-management/guidelines-tools/cabinet-directive-regulation.html) on Regulation outlines a series of mandatory public postings about upcoming regulatory initiatives in the form of a Forward Regulatory Plan (FRP).  The [*Policy on Transparency and Accountability*](https://www.canada.ca/en/treasury-board-secretariat/services/federal-regulatory-management/guidelines-tools/policy-regulatory-transparency-accountability.html) requires that FRP postings be updated annually on April 1.  Updates may also occur during the year.  Departments and Agencies are not required to keep historical copies of previous FRPS.  This tool allows interested parties to easily take snapshots of the current state of federal FRPs.


## Dependencies
The script requires the use of:
* bash
* wget
* sed
* awk

## Installing
Todo

#### Change dynamic directory for storing snapshots
You can change `$(date "+%Y-%m-%d")` to reflect the sub-directory to store the actual FRP snapshots.  The default will create a directory of the format YYYY-MM-DD in your base directory.

## Usage
To capture a snapshot of the current Forward Regulatory Plans, run:
`./cacheFRP` dept.conf
Where dept.conf is the configuration file for the requested department or agency.

## Config files
Config files are currently just shell script format files which assign department specific variables.  Here is the CRA.conf
CRA.conf
```Bash
FRPURL="https://www.canada.ca/en/revenue-agency/programs/about-canada-revenue-agency-cra/acts-regulations/forward-regulatory-plan/current-initiatives/regulatory-initiatives.html"
DEPT="CRA"
BASEURL="/www.canada.ca/en/revenue-agency/programs/about-canada-revenue-agency-cra/acts-regulations/forward-regulatory-plan/current-initiatives/"
```
## Contributing
This is a quick script I put together to help me capture changes in the CRA Forward Regulatory Plans.  The whole of the Government of Canada is required to publish these plans at least annually.  I would be interested in abstracting the process and applying it to the government-wide plans, with the hopes of making a historical record of all Foreward Regulatory Plans.

If you have any interest in government, government reporting, screen scraping, database, or front-end development, I'd love to hear from you.  You can reach me here or at gordonbonnar@gmail.com.

## Feedback
Contributions, pull requests, and new issues are definitely welcome.

## Licensing
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
