****  SAS Program to Read in Federal Employee Viewpoint Survey data;
****  The source data and the bulk of this SAS program come from https://www.opm.gov/fevs/public-data-file/;

  ****  Program Creates a temporary SAS data set for data analysis;
  ****
  ****  NOTE:
  ****    - Change %LET Statement for FEVS to correct FEVS year (e.g. FEVS2022_PDRF_CSV.txt);
  ****    - Make sure PATH4 Statement still points to the directory path the Raw Data set is in;
  ****;


%LET YR = 2022;
%LET PATH4 = https://www.opm.gov/fevs/public-data-file/&YR./FEVS&YR._PRDF_CSV.zip;  * STATUS Raw Data delimited text files;


/* detect proper delim for UNIX vs. Windows */
%let delim=%sysfunc(ifc(%eval(&sysscp. = WIN),\,/));
 
/* create a name for our downloaded ZIP */
%let ziploc = %sysfunc(getoption(work))&delim.datafile.zip;
filename download "&ziploc";
 
/* Download the ZIP file from the Internet*/
proc http
 method='GET'
 url="&PATH4"
 out=download;
run;

/* Assign a fileref wth the ZIP method */
filename fevs zip "&ziploc";
 
/* Read the "members" (files) from the ZIP file */
data contents(keep=memname);
 length memname $200;
 fid=dopen("fevs");
 if fid=0 then
  stop;
 memcount=dnum(fid);
 do i=1 to memcount;
  memname=dread(fid,i);
  output;
 end;
 rc=dclose(fid);
run;
 
/* create a report of the ZIP contents */
title "Files in the ZIP file";
proc print data=contents noobs N;
run;


    data WORK.FEVS    ;
length race $34 hisp $3 DISABILITY $3 AGEGRP $11 SUPERVISOR $30 FEDTEN $20 SEX $6 MILITARY_SERVICE $26 LEAVING_GOVT $47;
   INFILE fevs(&YR._OPM_FEVS_PRDF.csv) firstobs=2 dlm=',' dsd missover;       
informat RandomID best32. ;
       informat agency $2. ;
       informat Q1 $1. ;
       informat Q2 $1. ;
       informat Q3 $1. ;
       informat Q4 $1. ;
       informat Q5 $1. ;
       informat Q6 $1. ;
       informat Q7 $1. ;
       informat Q8 $1. ;
       informat Q9 $1. ;
       informat Q10 $1. ;
       informat Q11 $1. ;
       informat Q12 $1. ;
       informat Q13 $1. ;
       informat Q14 $1. ;
       informat Q15_1 $1. ;
       informat Q15_2 $1. ;
       informat Q15_3 $1. ;
       informat Q15_4 $1. ;
       informat Q15_5 $1. ;
       informat Q15_6 $1. ;
       informat Q16 $1. ;
       informat Q17 $1. ;
       informat Q18 $1. ;
       informat Q19 $1. ;
       informat Q20 $1. ;
       informat Q21 $1. ;
       informat Q22 $1. ;
       informat Q23 $1. ;
       informat Q24 $1. ;
       informat Q25 $1. ;
       informat Q26 $1. ;
       informat Q27 $1. ;
       informat Q28 $1. ;
       informat Q29 $1. ;
       informat Q30 $1. ;
       informat Q31 $1. ;
       informat Q32 $1. ;
       informat Q33 $1. ;
       informat Q34 $1. ;
       informat Q35 $1. ;
       informat Q36 $1. ;
       informat Q37 $1. ;
       informat Q38 $1. ;
       informat Q39 $1. ;
       informat Q40 $1. ;
       informat Q41 $1. ;
       informat Q42 $1. ;
       informat Q43 $1. ;
       informat Q44 $1. ;
       informat Q45 $1. ;
       informat Q46 $1. ;
       informat Q47 $1. ;
       informat Q48 $1. ;
       informat Q49 $1. ;
       informat Q50 $1. ;
       informat Q51 $1. ;
       informat Q52 $1. ;
       informat Q53 $1. ;
       informat Q54 $1. ;
       informat Q55 $1. ;
       informat Q56 $1. ;
       informat Q57 $1. ;
       informat Q58 $1. ;
       informat Q59 $1. ;
       informat Q60 $1. ;
       informat Q61 $1. ;
       informat Q62 $1. ;
       informat Q63 $1. ;
       informat Q64 $1. ;
       informat Q65 $1. ;
       informat Q66 $1. ;
       informat Q67 $1. ;
       informat Q68 $1. ;
       informat Q69 $1. ;
       informat Q70 $1. ;
       informat Q71 $1. ;
       informat Q72 $1. ;
       informat Q73 $1. ;
       informat Q74 $1. ;
       informat Q75 $1. ;
       informat Q76 $1. ;
       informat Q77 $1. ;
       informat Q78 $1. ;
       informat Q79 $1. ;
       informat Q80 $1. ;
       informat Q81 $1. ;
       informat Q82 $1. ;
       informat Q83 $1. ;
       informat Q84 $1. ;
       informat Q85 $1. ;
       informat Q86 $1. ;
       informat Q87 $1. ;
       informat Q88 $1. ;
       informat Q89 $1. ;
       informat Q90 $1. ;
       informat Q91 $1. ;
       informat Q92 $1. ;
       informat Q93 $1. ;
       informat Q94 $1. ;
       informat Q95 $1. ;
       informat Q96 $1. ;
       informat Q97 $1. ;
       informat Q98 $1. ;
       informat Q99 $1. ;
       informat DRNO $1. ;
       informat DHISP $1. ;
       informat DDIS $1. ;
       informat DAGEGRP $1. ;
       informat DSUPER $1. ;
       informat DFEDTEN $1. ;
       informat DSEX $1. ;
       informat DMIL $1. ;
       informat DLEAVING $1. ;
       informat POSTWT best32. ;
       format RandomID best12. ;
       format agency $2. ;
       format Q1 $1. ;
       format Q2 $1. ;
       format Q3 $1. ;
       format Q4 $1. ;
       format Q5 $1. ;
       format Q6 $1. ;
       format Q7 $1. ;
       format Q8 $1. ;
       format Q9 $1. ;
       format Q10 $1. ;
       format Q11 $1. ;
       format Q12 $1.;
       format Q13 $1. ;
       format Q14 $1. ;
       format Q15_1 $1. ;
       format Q15_2 $1. ;
       format Q15_3 $1. ;
       format Q15_4 $1. ;
       format Q15_5 $1. ;
       format Q15_6 $1. ;
       format Q16 $1. ;
       format Q17 $1. ;
       format Q18 $1. ;
       format Q19 $1. ;
       format Q20 $1. ;
       format Q21 $1. ;
       format Q22 $1. ;
       format Q23 $1. ;
       format Q24 $1. ;
       format Q25 $1. ;
       format Q26 $1. ;
       format Q27 $1. ;
       format Q28 $1. ;
       format Q29 $1. ;
       format Q30 $1. ;
       format Q31 $1. ;
       format Q32 $1. ;
       format Q33 $1. ;
       format Q34 $1. ;
       format Q35 $1. ;
       format Q36 $1. ;
       format Q37 $1. ;
       format Q38 $1. ;
       format Q39 $1. ;
       format Q40 $1. ;
       format Q41 $1. ;
       format Q42 $1. ;
       format Q43 $1. ;
       format Q44 $1. ;
       format Q45 $1. ;
       format Q46 $1. ;
       format Q47 $1. ;
       format Q48 $1. ;
       format Q49 $1. ;
       format Q50 $1. ;
       format Q51 $1. ;
       format Q52 $1. ;
       format Q53 $1. ;
       format Q54 $1. ;
       format Q55 $1. ;
       format Q56 $1. ;
       format Q57 $1. ;
       format Q58 $1. ;
       format Q59 $1. ;
       format Q60 $1. ;
       format Q61 $1. ;
       format Q62 $1. ;
       format Q63 $1. ;
       format Q64 $1. ;
       format Q65 $1. ;
       format Q66 $1. ;
       format Q67 $1. ;
       format Q68 $1. ;
       format Q69 $1. ;
       format Q70 $1. ;
       format Q71 $1. ;
       format Q72 $1. ;
       format Q73 $1. ;
       format Q74 $1. ;
       format Q75 $1. ;
       format Q76 $1. ;
       format Q77 $1. ;
       format Q78 $1. ;
       format Q79 $1. ;
       format Q80 $1. ;
       format Q81 $1. ;
       format Q82 $1. ;
       format Q83 $1. ;
       format Q84 $1. ;
       format Q85 $1. ;
       format Q86 $1. ;
       format Q87 $1. ;
       format Q88 $1. ;
       format Q89 $1. ;
       format Q90 $1. ;
       format Q91 $1. ;
       format Q92 $1. ;
       format Q93 $1. ;
       format Q94 $1. ;
       format Q95 $1. ;
       format Q96 $1. ;
       format Q97 $1. ;
       format Q98 $1. ;
       format Q99 $1. ;
       format DRNO $1. ;
       format DHISP $1. ;
       format DDIS $1. ;
       format DAGEGRP $1. ;
       format DSUPER $1. ;
       format DFEDTEN $1. ;
       format DSEX $1. ;
       format DMIL $1. ;
       format DLEAVING $1. ;
       format POSTWT best12. ;
    input
                RandomID
                agency  $
 				Q1	$
                Q2	$
                Q3	$
                Q4	$
                Q5	$
                Q6	$
                Q7	$
                Q8 	$
                Q9	$
                Q10	$
                Q11	$
                Q12 $
                Q13	$
                Q14	$
                Q15_1	$
                Q15_2	$
                Q15_3	$
                Q15_4	$
                Q15_5	$
                Q15_6	$
                Q16  	$
                Q17  	$
                Q18	$
                Q19	$
                Q20	$
                Q21	$
                Q22	$
                Q23 $
                Q24	$
                Q25	$
                Q26	$
                Q27	$
                Q28	$
                Q29	$
                Q30	$
                Q31	$
                Q32	$
                Q33	$
                Q34	$
                Q35	$
                Q36	$
                Q37	$
                Q38	$
                Q39	$
                Q40	$
                Q41	$
                Q42	$
                Q43	$
                Q44 $
                Q45 $
                Q46 $
                Q47	$
                Q48	$
                Q49	$
                Q50	$
                Q51	$
                Q52	$
                Q53	$
                Q54 $
                Q55	$
                Q56	$
                Q57	$
                Q58	$
                Q59 $
                Q60	$
                Q61 $
                Q62	$
                Q63 $
                Q64 $
                Q65	$
                Q66	$
                Q67	$
                Q68	$
                Q69	$
                Q70	$
                Q71	$
                Q72	$
                Q73	$
                Q74	$
                Q75	$
                Q76	$
                Q77	$
                Q78	$
                Q79	$
                Q80	$
                Q81	$
                Q82 $
                Q83 $
                Q84 $
                Q85	$
                Q86	$
                Q87	$
                Q88	$
                Q89	$
                Q90	$
                Q91	$
                Q92	$
                Q93	$
                Q94 $
                Q95	$
                Q96	$
                Q97	$
                Q98	$
                Q99	$
                DRNO  $
                DHISP  $
                DDIS  $
                DAGEGRP  $
                DSUPER  $
                DFEDTEN  $
                DSEX  $
                DMIL  $
                DLEAVING  $
                POSTWT
    ;

agy=agency;


if DRNO = 'A' then race	='Black or African American' ;
else if DRNO = 'B' then race	='White' ;
else if DRNO = 'C' then race	='Asian' ;
else if DRNO = 'D' then race	='Other Groups Collapsed for Privacy';

if DHISP = 'A'	then HISP = 'Yes' ;
ELSE if DHISP = 'B'	THEN HISP = 'No' ;

if DDIS = 'A'	then DISABILITY = 'Yes' ;
ELSE if DDIS = 'B'	THEN DISABILITY = 'No' ;

IF DAGEGRP = 'A'	THEN AGEGRP = 'Under 40' ;
ELSE IF DAGEGRP = 'B'	THEN AGEGRP = '40 or Older' ;

IF DSUPER = 'A'	THEN SUPERVISOR ='Non-Supervisor/Team Leader' ;
ELSE IF DSUPER = 'B'	THEN SUPERVISOR = 'Supervisor/Manager/Executive' ;

IF DFEDTEN = 'A' THEN FEDTEN =	'Ten years or fewer';
ELSE IF DFEDTEN ='B' THEN FEDTEN =	'Eleven to 20 years';
ELSE IF DFEDTEN = 'C' THEN FEDTEN =	'More than 20 years';

IF DSEX = 'A' THEN SEX=	'Male';
ELSE IF DSEX = 'B' THEN SEX =	'Female';

IF DMIL = 'A' THEN MILITARY_SERVICE =	'Military Service';
ELSE IF DMIL = 'B' THEN MILITARY_SERVICE=	'No Prior Military Service';

IF DLEAVING = 'A'	THEN LEAVING_GOVT = 'No' ;
ELSE IF DLEAVING = 'B'	THEN LEAVING_GOVT ='Yes, other' ;
ELSE IF DLEAVING = 'C'	THEN LEAVING_GOVT ='Yes, to take another job within the Federal Government' ;
ELSE IF DLEAVING = 'D'	THEN LEAVING_GOVT ='Yes, to take another job outside the Federal Government' ;

   array change _character_;
        do over change;
            if change in ('X','Y','6') then change=''; /*REMOVING TO NOT AFFECT AVERAGE CALCULATION*/
        end;

drop Q15_1 Q15_2 Q15_3 Q15_4 Q15_5 Q15_6 DRNO DDIS DHISP DAGEGRP DSUPER DFEDTEN DSEX DMIL DLEAVING;

run;

DATA FEVS2;
SET FEVS ;
	ARRAY _char (99) Q1-Q99;
	ARRAY _num (99) _Q1 - _Q99;
	DO i=1  to 99;
	_num{i} = input(_char{i}, 8.);
	END;


DROP Q1-Q99 q15 ;
RUN;


/*Adding Agency Name to FEVS data*/
proc sort data=fevs2;
	by agy;
run;

proc sort data=Dtagy;
	by agy;
run;

data fevs3;
length Q90 $75 Q91 $100 Q92 $3 Q93 $70 Q95 $100;
retain agy2;
	merge fevs2 dtagy (keep= agy agyt agytypt);
	by agy;
AGY2 = substr(AGYT, 4);
if agy = 'XX' then agy2 = 'ALL OTHER AGENCIES';

if _Q90 = 1	then Q90 = '100% of my work time';
else if _Q90 = 2	then Q90 = 'At least 50% but less than 100%';
else if _Q90 = 3	then Q90 = 'Less than 50%';
else if _Q90 = 4	then Q90 = 'I am not currently required to be physically present at my agency worksite';


if _Q91 = 1	then Q91 = 'Teleworks frequently or has a remote work agreement';
else if _Q91 = 2	then Q91 = 'Teleworks infrequently; ranging from as-needed up to two days a week';
else if _Q91 = 3	then Q91 = 'Does not telework; required to be on site, has technical issues, or did not receive approval';
else if _Q91 = 4	then Q91 = 'Chooses not to telework';


if _Q92 = 1	then Q92 = 'Yes';
else if _Q92 = 2	then Q92 = 'No';

if _Q93 = 1	then Q93 = 'No';
else if _Q93 = 2	then Q93 = 'Yes, to retire';
else if _Q93 = 3	then Q93 = 'Yes, to take another job within my Agency';
else if _Q93 = 4	then Q93 = 'Yes, to take another job within the Federal Government';
else if _Q93 = 5	then Q93 = 'Yes, to take another job outside the Federal Government';
else if _Q93 = .	then Q93 = 'Yes, other';

if _Q95 = 1	then Q95 = 'All employees in my work unit are physically present on the worksite';
else if _Q95 = 2	then Q95 = 'Some employees are physically present on the worksite and others telework or work remotely';
else if _Q95 = 3	then Q95 = 'No employees in my work unit are physically present on the worksite, we all work remotely';
else if _Q95 = 4	then Q95 = 'Other';

DROP AGENCY AGY _Q90 _Q91 _Q92 _Q93 _Q95;


run;



data opm_fevs;
RETAIN AGY AGYTYP;
set fevs3;
	WHERE RANDOMID NE .;
	AGY=AGY2;
	agytyp=agytypT;

_Q90 = Q90;
_Q91 = Q91; 
_Q92 = Q92; 
_Q93 = Q93; 
_Q95 = Q95;

LABEL 
	AGY = 'Agency'
	agytyp 	= 'Agency Type'
	POSTWT='Weighting Variable'
_Q1 = "I am given a real opportunity to improve my skills in my organization. "
_Q2 = "I feel encouraged to come up with new and better ways of doing things. "
_Q3 = "My work gives me a feeling of personal accomplishment. "
_Q4 = "I know what is expected of me on the job. "
_Q5 = "My workload is reasonable. "
_Q6 = "My talents are used well in the workplace. "
_Q7 = "I know how my work relates to the agency's goals. "
_Q8 = "I can disclose a suspected violation of any law, rule or regulation without fear of reprisal. "
_Q9 = "I have enough information to do my job well. "
_Q10 = "I receive the training I need to do my job well. "
_Q11 = "I am held accountable for the quality of work I produce. "
_Q12 = "Continually changing work priorities make it hard for me to produce high quality work. "
_Q13 = "I have a clear idea of how well I am doing my job. "
_Q14 = "The people I work with cooperate to get the job done. "
_Q14 = "In my work unit poor performers usually: "
_Q16 = "In my work unit, differences in performance are recognized in a meaningful way. "
_Q17 = "Employees in my work unit share job knowledge. "
_Q18 = "My work unit has the job-relevant knowledge and skills necessary to accomplish organizational goals. "
_Q19 = "Employees in my work unit meet the needs of our customers. "
_Q20 = "Employees in my work unit contribute positively to my agency's performance. "
_Q21 = "Employees in my work unit produce high-quality work. "
_Q22 = "Employees in my work unit adapt to changing priorities. "
_Q23 = "New hires in my work unit (i.e. hired in the past year) have the right skills to do their jobs. "
_Q24 = "I can influence decisions in my work unit. "
_Q25 = "I know what my work unit’s goals are. "
_Q26 = "My work unit commits resources to develop new ideas (e.g., budget, staff, time, expert support). "
_Q27 = "My work unit successfully manages disruptions to our work. "
_Q28 = "Employees in my work unit consistently look for new ways to improve how they do their work. "
_Q29 = "Employees in my work unit incorporate new ideas into their work. "
_Q30 = "Employees in my work unit approach change as an opportunity. "
_Q31 = "Employees in my work unit consider customer needs a top priority. "
_Q32 = "Employees in my work unit consistently look for ways to improve customer service. "
_Q33 = "Employees in my work unit support my need to balance my work and personal responsibilities. "
_Q34 = "Employees in my work unit are typically under too much pressure to meet work goals. "
_Q35 = "Employees are recognized for providing high quality products and services. "
_Q36 = "Employees are protected from health and safety hazards on the job. "
_Q37 = "My organization is successful at accomplishing its mission. "
_Q38 = "I have a good understanding of my organization’s priorities. "
_Q39 = "My organization effectively adapts to changing government priorities. "
_Q40 = "My organization has prepared me for potential physical security threats. "
_Q41 = "My organization has prepared me for potential cybersecurity threats. "
_Q42 = "In my organization, arbitrary action, personal favoritism and/or political coercion are not tolerated. "
_Q43 = "I recommend my organization as a good place to work. "
_Q44 = "I believe the results of this survey will be used to make my agency a better place to work. "
_Q45 = "My supervisor is committed to a workforce representative of all segments of society. "
_Q46 = "Supervisors in my work unit support employee development. "
_Q47 = "My supervisor supports my need to balance work and other life issues. "
_Q48 = "My supervisor listens to what I have to say. "
_Q49 = "My supervisor treats me with respect. "
_Q50 = "I have trust and confidence in my supervisor. "
_Q51 = "My supervisor holds me accountable for achieving results. "
_Q52 = "Overall, how good a job do you feel is being done by your immediate supervisor? "
_Q53 = "My supervisor provides me with constructive suggestions to improve my job performance. "
_Q54 = "My supervisor provides me with performance feedback throughout the year. "
_Q55 = "In my organization, senior leaders generate high levels of motivation and commitment in the workforce. "
_Q56 = "My organization's senior leaders maintain high standards of honesty and integrity. "
_Q57 = "Managers communicate the goals of the organization. "
_Q58 = "Managers promote communication among different work units (for example, about projects, goals, needed resources). "
_Q59 = "Overall, how good a job do you feel is being done by the manager directly above your immediate supervisor? "
_Q60 = "I have a high level of respect for my organization's senior leaders. "
_Q61 = "Senior leaders demonstrate support for Work-Life programs. "
_Q62 = "Management encourages innovation. "
_Q63 = "Management makes effective changes to address challenges facing our organization. "
_Q64 = "Management involves employees in decisions that affect their work. "
_Q65 = "How satisfied are you with your involvement in decisions that affect your work? "
_Q66 = "How satisfied are you with the information you receive from management on what's going on in your organization? "
_Q67 = "How satisfied are you with the recognition you receive for doing a good job? "
_Q68 = "Considering everything, how satisfied are you with your job? "
_Q69 = "Considering everything, how satisfied are you with your pay? "
_Q70 = "Considering everything, how satisfied are you with your organization? "
_Q71 = "My organization’s management practices promote diversity (e.g., outreach, recruitment, promotion opportunities). "
_Q72 = "My supervisor demonstrates a commitment to workforce diversity (e.g., recruitment, promotion opportunities, development). "
_Q73 = "I have similar access to advancement opportunities (e.g., promotion, career development, training) as others in my work unit. "
_Q74 = "My supervisor provides opportunities fairly to all employees in my work unit (e.g., promotions, work assignments). "
_Q75 = "In my work unit, excellent work is similarly recognized for all employees (e.g., awards, acknowledgements). "
_Q76 = "Employees in my work unit treat me as a valued member of the team. "
_Q77 = "Employees in my work unit make me feel I belong. "
_Q78 = "Employees in my work unit care about me as a person. "
_Q79 = "I am comfortable expressing opinions that are different from other employees in my work unit. "
_Q80 = "In my work unit, people’s differences are respected. "
_Q81 = "I can be successful in my organization being myself. "
_Q82 = "I can easily make a request of my organization to meet my accessibility needs. "
_Q83 = "My organization responds to my accessibility needs in a timely manner. "
_Q84 = "My organization meets my accessibility needs. "
_Q85 = "My job inspires me. "
_Q86 = "The work I do gives me a sense of accomplishment. "
_Q87 = "I feel a strong personal attachment to my organization. "
_Q88 = "I identify with the mission of my organization. "
_Q89 = "It is important to me that my work contribute to the common good. "
_Q90 = "What percentage of your work time are you currently required to be physically present at your agency worksite (including headquarters, bureau, field offices, etc.)? "
_Q91 = "Please select the response that BEST describes your current remote work or teleworking schedule. "
_Q92 = "Did you have an approved remote work agreement before the 2020 COVID-19 pandemic? "
_Q93 = "Based on your work unit’s current telework or remote work options, are you considering leaving your organization, and if so, why? "
_Q94 = "My agency’s re-entry arrangements are fair in accounting for employees’ diverse needs and situations. "
_Q95 = "Please select the response that BEST describes how employees in your work unit currently report to work: "
_Q96 = "My organization’s senior leaders support policies and procedures to protect employee health and safety. "
_Q97 = "My organization’s senior leaders provide effective communications about what to expect with the return to the physical worksite. "
_Q98 = "My supervisor supports my efforts to stay healthy and safe while working. "
_Q99 = "My supervisor creates an environment where I can voice my concerns about staying healthy and safe. "
RACE ="Racial category" 
HISP= "Hispanic, Latino, or Spanish Origin"
DISABILITY= "Disability"
AGEGRP= 'Age group'
SUPERVISOR= 'Supervisory status'
FEDTEN= 'Time with Federal Government' 
SEX= 'Sex'
MILITARY_SERVICE= 'Military service status'
LEAVING_GOVT= 'Considering leaving within year'
;
;
DROP AGY2 AGYT agytypT Q90 Q91 Q92 Q93 Q95;
run;

/*  LOADING THE FEVS TABLE INTO MEMORY */
proc casutil ;
  /* need to drop a global scoped table */
  droptable incaslib="Public" casdata="OPM_FEVS" quiet;
  /* now load the table, in this we use a SAS data set */
  load data=work.OPM_FEVS outcaslib="Public" casout="OPM_FEVS" promote;
quit;

data wfa.OPM_FEVS;
set work.OPM_FEVS;
run;


