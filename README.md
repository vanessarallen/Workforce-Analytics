# Workforce-Analytics
OPM Workforce Analytics 

The SAS codes in this repository is used to pull data required to populate the Federal Agency Workforce Analytics Dashboard on SAS Viya. This dashboard explores federal agency workforce information and trends, such as returement and attrtion, and includes data from US Office of Personnel Management (OPM) (i.e., emplyment, separations, accessions, Federal Employee Viewpoint Survey [FEVS]), USAJobs, and Indeed. The objective of the exercises was for participants to gain actionable insights from their individual agency’s data as well as to gain exposure to multiple analytical techniques for both visualizing current/historic trends and predicting future indicators.  The dashboard includes simulated demographic information based on real demographic proportions from FedScope data and considers human capital policy changes designed to mitigate detrimental impact on agencies’ mission objectives. 

Before this dashboard will populate, the following SAS code in the repository will need to be run in SAS Studio in the Civ 4 SAS Viya environment: Workforce Analytics SAS Code to Run for Dashboard.sas
This code runs all of the programs to pull in the data for this dashboard. 

Alternatively, each of the following individual programs can be run in SAS Studio, one at a time:

1. Census.sas - This program pulls in census data on annual resident population estimates by age, sex, and race groups from the following site (https://www2.census.gov/programs-surveys/popest/datasets/2020-2021/counties/asrh/). The estimates are based on the 2010 Census and were created without incorporation or consideration of the 2020 Census results. 
3. OPM Employment.sas - This program reads in public OPM workforce characteristic employment data and adds in simulated race and gender data by Agency based on actual race and gender counts reported by OPM Fedscope. This code also creates similated performance, job satisfaction, and turnover. 
4. OPM Separations and Accessions.sas - This program reads in public OPM separations and accessions data. 
5. OPM Federal Employee Viewpoint Survey (FEVS).sas - This program reads in results from the Federal Employee Viewpoint Survey by Agency
6. USAJobs Announcements.sas - This program uses a REST API to pull in past job announcements from USAJobs

