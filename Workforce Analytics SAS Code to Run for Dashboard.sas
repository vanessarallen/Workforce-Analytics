/* WORKFORCE ANALYTICS SAS CODE */
/*  */
/* THIS CODE WILL RUN ALL CODES NEEDED FOR THE WORKFORCE ANALYTICS DASHBAORD */

filename myfldr filesrvc folderPath = '/Public/Workforce Analytics/Content Development/';
%include myfldr ('1. Census.sas') / source2;
%include myfldr ('2. OPM Employment.sas') / source2;
%include myfldr ('3. OPM Separations and Accessions.sas') / source2;
%include myfldr ('4. OPM Federal Employee Viewpoint Survey (FEVS).sas') / source2;
%include myfldr ('5. USAJobs Announcements.sas') / source2;