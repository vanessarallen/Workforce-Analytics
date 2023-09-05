****  SAS Program to Read in DATA.gov FedScope Employment Cube RAW Data Sets for general public consumption;
****  The source data and the bulk of this SAS program come from:
 https://www.opm.gov/data/Index.aspx?tag=FedScope

Data Updates mid-month every February, May, August, and December.

  ****  Program Creates 18 temporary SAS data sets for data analysis;
  ****    - FACTDATA_MMMYYYY table and 17 Dimension Translations tables (DTtables);
  ****
  ****  NOTE:
  ****    - Change PATH1 Statement below to directory path Raw Data sets are in;	
  ****    - Change %LET Statement for FACTDATA to correct FACTDATA month (e.g. FACTDATA_DEC2022.txt);
  ****;

%LET PATH1 = https://www.opm.gov/data/datasets/Files/679/4e9c7654-2623-4521-9975-d5ecec8b968e.zip;  * STATUS Raw Data delimited text files;
%LET MONYR = DEC2022;

/* detect proper delim for UNIX vs. Windows */
%let delim=%sysfunc(ifc(%eval(&sysscp. = WIN),\,/));
 
/* create a name for our downloaded ZIP */
%let ziploc = %sysfunc(getoption(work))&delim.datafile.zip;
filename download "&ziploc";
 
/* Download the ZIP file from the Internet*/
proc http
 method='GET'
 url="&PATH1"
 out=download;
run;

/* Assign a fileref wth the ZIP method */
filename inzip zip "&ziploc";
 
/* Read the "members" (files) from the ZIP file */
data contents(keep=memname);
 length memname $200;
 fid=dopen("inzip");
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


DATA FACTDATA0;
INFILE inzip(FACTDATA_&MONYR..TXT) firstobs=2 dlm=',' dsd missover;
INFORMAT	AGYSUB		$4.;
INFORMAT	LOC			$2.;
INFORMAT	AGELVL		$1.;
INFORMAT	EDLVL		$2.;
INFORMAT	GSEGRD		$2.;
INFORMAT	LOSLVL		$1.;
INFORMAT	OCC			$4.;
INFORMAT	PATCO		$1.;
INFORMAT	PP			$2.;
INFORMAT	PPGRD		$5.;
INFORMAT	SALLVL		$1.;
INFORMAT	STEMOCC		$4.;
INFORMAT	SUPERVIS	$1.;
INFORMAT	TOA			$2.;
INFORMAT	WORKSCH		$1.;
INFORMAT	WORKSTAT	$1.;
INFORMAT	DATECODE	$6.; /*INFORMAT	DATECODE	$6.;*/
INFORMAT 	EMPLOYMENT 	1.;
INFORMAT 	SALARY 		DOLLAR8.;
INFORMAT 	LOS 		4.1;
FORMAT		AGYSUB		$4.;  
FORMAT		LOC			$2.;
FORMAT		AGELVL		$1.; 
FORMAT		EDLVL		$2.;
FORMAT		GSEGRD		$2.;
FORMAT		LOSLVL		$1.;
FORMAT		OCC			$4.;
FORMAT		PATCO		$1.;
FORMAT		PP			$2.;
FORMAT		PPGRD		$5.;
FORMAT		SALLVL		$1.;
FORMAT		STEMOCC		$4.;
FORMAT		SUPERVIS	$1.;
FORMAT		TOA			$2.; 
FORMAT		WORKSCH		$1.;
FORMAT		WORKSTAT	$1.;
FORMAT		DATECODE	$6.; 
FORMAT 	 	EMPLOYMENT 	1.;
FORMAT   	SALARY 		DOLLAR8.;
FORMAT   	LOS 		4.1;
INPUT
AGYSUB
LOC
AGELVL
EDLVL
GSEGRD
LOSLVL
OCC
PATCO
PP
PPGRD
SALLVL
STEMOCC
SUPERVIS
TOA
WORKSCH
WORKSTAT
DATECODE
EMPLOYMENT 	
SALARY 		
LOS;
RUN;
** End FACTDATA table processing;


*** Read In Agency Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
/* Assign a filename wth the ZIP method */
filename inzip zip "&ziploc" member="DTagy.txt";
DATA DTagy;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT
AGYTYP 	: $1.
AGYTYPT : $52.
AGY 	: $2.
AGYT 	: $78.
AGYSUB 	: $4.
AGYSUBT : $114.;
RUN;
** End Agency Dimension Translation Table processing;

*** Read In Location Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTloc.txt";
DATA DTloc;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
LOCTYP 		: $1.
LOCTYPT 	: $17.
LOC			: $2.
LOCT		: $47.;
RUN;
** End Location Dimension Translation Table processing;

*** Read In Age Level Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTagelvl.txt";
DATA DTagelvl;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
AGELVL 	: $1.
AGELVLT : $12.;
RUN;
** End Age Level Translation Table processing;

*** Read In Education Level Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTedlvl.txt";
DATA DTedlvl;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
EDLVLTYP	: $2.
EDLVLTYPT 	: $27.
EDLVL		: $2.
EDLVLT		: $83.;
RUN;
** End Education Level Dimension Translation Table processing;

*** Read In GSEGRD Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTgsegrd.txt";
DATA DTgsegrd;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT GSEGRD : $2.;
RUN;
** End GSEGRD Dimension Translation Table processing;

*** Read In Length of Service Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTloslvl.txt";
DATA DTloslvl;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
LOSLVL 	: $1.
LOSLVLT : $16.;
RUN;
** End Length of Service Dimension Translation Table processing;

*** Read In Occupation Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTocc.txt";
DATA DTocc;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
OCCTYP 	: $1.
OCCTYPT : $12.
OCCFAM 	: $2.
OCCFAMT : $45.
OCC 	: $4.
OCCT 	: $83.;
RUN;
** End Occupation Dimension Translation Table processing;

*** Read In PATCO Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTpatco.txt";
DATA DTpatco;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
PATCO 	: $1.
PATCOT 	: $18.;
RUN;
** End PATCO Dimension Translation Table processing;

*** Read In SES & Senior Level Pay Plans Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTpp.txt";
DATA DTpp;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
PP_AGG 		: $1.
PP_AGGT 	: $21.
PP 			: $2.
PPT			: $33.;
RUN;
** End SES & Senior Level Pay Plans Dimension Translation Table processing;

*** Read In Pay Plan & Grade Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTppgrd.txt";
DATA DTppgrd;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
PPTYP 		: $1.
PPTYPT 		: $57.
PPGROUP 	: $2.
PPGROUPT	: $36.
PAYPLAN 	: $2.
PAYPLANT 	: $113.
PPGRD 		: $5.;
RUN;
** End Pay Plan & Grade Dimension Translation Table processing;

*** Read In Salary Level Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTsallvl.txt";
DATA DTsallvl;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
SALLVL 	: $1.
SALLVLT : $19.;
RUN;
** End Salary Level Dimension Translation Table processing;

*** Read In STEM Occupation Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTstemocc.txt";
DATA DTstemocc;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
STEMAGG		: $1.
STEMAGGT	: $21.
STEMTYP		: $2.
STEMTYPT	: $23.
STEMOCC		: $4.
STEMOCCT	: $65.;
RUN;
** End STEM Occupation Dimension Translation Table processing;

*** Read In Supervisory Status Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTsuper.txt";
DATA DTsuper;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT
SUPERTYP	: $1.
SUPERTYPT	: $14.
SUPERVIS	: $1.
SUPERVIST	: $28.;
RUN;
** End Supervisory Status Dimension Translation Table processing;

*** Read In Type of Appointment Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTtoa.txt";
DATA DTtoa;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT
TOATYP 	: $1.
TOATYPT : $13.
TOA 	: $2.
TOAT 	: $50.;
RUN;
** End Type of Appointment Dimension Translation Table processing;

*** Read In Work Schedule Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTwrksch.txt";
DATA DTwrksch;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT
WSTYP 	  : $1.
WSTYPT 	  : $13.
WORKSCH   : $1.
WORKSCHT  : $36.;
RUN;
** End Work Schedule Dimension Translation Table processing;

*** Read In Work Status Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTwkstat.txt";
DATA DTwkstat;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
WORKSTAT	: $1.
WORKSTATT	: $32.;
RUN;
** End Work Status Dimension Translation Table processing;

*** Read In Date Dimension Translation Table;
* define the STATUS text file extract via FILENAME statement;
filename inzip zip "&ziploc" member="DTdate.txt";
DATA DTdate;
INFILE inzip firstobs=2 dlm=',' dsd missover;
INPUT 
DATECODE	: $6.
DATECODET	: $8.;
RUN;
** End Date Dimension Translation Table processing;
**** END OF PROGRAM TO READ IN DATA.gov FEDSCOPE EMPLOYMENT CUBE RAW DATA SETS, ****;
**** CREATING 17 TEMPORARY DATA SETS FOR DATA ANALYSIS ****;


/* Macro to MERGE all OPM Files with FACTDATA*/
%macro opm_emp (ds1, ds2, var, finalds);

proc sort data=&ds1.;
	by &var.;
run;

proc sort data=&ds2.;
	by &var.;
run;

data &finalds.;
	merge &ds2. &ds1.;
	by &var.;
run;
%mend opm_emp;

%opm_emp (ds1=DTagy,     ds2=FACTDATA0,  var=agysub, 	finalds=FACTDATA1);
%opm_emp (ds1=DTOCC,     ds2=FACTDATA1,  var=OCC, 		finalds=FACTDATA2);
%opm_emp (ds1=DTLOC,     ds2=FACTDATA2,  var=LOC, 		finalds=FACTDATA3);
%opm_emp (ds1=DTAGELVL,  ds2=FACTDATA3,  var=AGELVL, 	finalds=FACTDATA4);
%opm_emp (ds1=DTEDLVL,   ds2=FACTDATA4,  var=EDLVL, 	finalds=FACTDATA5);
%opm_emp (ds1=DTLOSLVL,  ds2=FACTDATA5,  var=LOSLVL, 	finalds=FACTDATA6);
%opm_emp (ds1=DTPATCO,   ds2=FACTDATA6,  var=PATCO, 	finalds=FACTDATA7);
%opm_emp (ds1=DTPP,      ds2=FACTDATA7,  var=PP, 		finalds=FACTDATA8);
%opm_emp (ds1=DTPPGRD,   ds2=FACTDATA8,  var=PPGRD, 	finalds=FACTDATA9);
%opm_emp (ds1=DTSALLVL,  ds2=FACTDATA9,  var=SALLVL, 	finalds=FACTDATA10);
%opm_emp (ds1=DTSTEMOCC, ds2=FACTDATA10, var=STEMOCC, 	finalds=FACTDATA11);
%opm_emp (ds1=DTSUPER,   ds2=FACTDATA11, var=SUPERVIS, 	finalds=FACTDATA12);
%opm_emp (ds1=DTTOA,     ds2=FACTDATA12, var=TOA, 		finalds=FACTDATA13);
%opm_emp (ds1=DTWRKSCH,  ds2=FACTDATA13, var=WORKSCH, 	finalds=FACTDATA14);
%opm_emp (ds1=DTWKSTAT,  ds2=FACTDATA14, var=WORKSTAT, 	finalds=FACTDATA15);
%opm_emp (ds1=DTDATE,    ds2=FACTDATA15, var=DATECODE, 	finalds=FACTDATA16);



/* Clean up labels and formats */
data factdata17;
set factdata16;
	Year 		= substr(datecode, 1, 4);
	Month 		= substr(datecode, 5, 2);
	Period 		= mdy(month, 1, year);
	AGY2 		= substr(AGYT, 4);
	AGYSUB2 	= substr(AGYSUBT, 6);
	AGYTYPE		= AGYTYPT;
	AGY			= AGYABBREV;
	AGYSUB		= AGYSUBABBREV;
	agelvl2 	= AGELVLT;
	edlvl2 		= SUBSTR(EDLVLT,4);
	EDLVLTYP2 	= EDLVLTYPT;
	LOC2 		= SUBSTR(LOCT,4);
	loctyp2		= loctypt;
	loslvl2 	= LOSLVLT;
	occ2 		= substr(OCCT,6);
	OCCFAM2 	= substr(OCCFAMT,6);
	occtyp2 	= occtypt;
	patco2 		= PATCOT;
	pp2 		= PPT;
	PP_AGG2		= PP_AGGT;
	PPTYP2		= PPTYPT;
	PPGROUP2	= PPGROUPT;
	sallvl2 	= SALLVLT;
	STEMAGG2	= STEMAGGT;
	STEMOCC2	= SUBSTR(STEMOCCT,6);
	STEMTYP2	= STEMTYPT;
	supervis2 	= substr(SUPERVIST,3);
	TOATYP2 	= TOATYPT;
	toa2 		= substr(TOAT,4);
	worksch2 	= substr(WORKSCHT,5);
	workstat2 	= WORKSTATT;
	agytyp2 	= AGYTYPT;
	datecode2 	= datecodet;
	payplan2 	= SUBSTR(payplant,4);
	SUPERTYP2	= SUPERTYPT;
	WSTYP2		= WSTYPT;

if loctyp=1 then STATE = loc2;
if loctyp=3 then FOREIGN_COUNTRY=loc2;

WHERE AGYSUB NE '';

	drop AGY AGYT
	AGYSUB AGYSUBT
	agelvl AGELVLT
	edlvl EDLVLT
	EDLVLTYP EDLVLTYPT
	LOC LOCT
	loctyp loctypt
	loslvl LOSLVLT
	occ OCCT
	OCCFAM OCCFAMT
	occtyp occtypt
	patco PATCOT
	pp PPT
	PP_AGG PP_AGGT
	PPTYP PPTYPT
	PPGROUP PPGROUPT
	sallvl  SALLVLT
	STEMAGG STEMAGGT
	STEMOCC STEMOCCT
	STEMTYP STEMTYPT
	supervis SUPERVIST
	TOATYP TOATYPT
	toa TOAT
	worksch WORKSCHT
	workstat WORKSTATT
	agytyp AGYTYPT
	datecode datecodet
	payplan payplant
	SUPERTYP SUPERTYPT
	WSTYP WSTYPT;
RUN;


/* Clean up labels and formats */
DATA opm_factdata;
SET factdata17;
AGY 		= AGY2;
AGYSUB 		= AGYSUB2;
agelvl 		= AGELVL2;
edlvl 		= EDLVL2;
EDLVLTYP	= EDLVLTYP2;
loctyp 		= loctyp2;
LOC 		= LOC2;
loslvl 		= LOSLVL2;
occ 		= OCC2;
OCCFAM 		= OCCFAM2;
occtyp 		= occtyp2;
patco 		= PATCO2;
pp 			= PP2;
PP_AGG		= PP_AGG2;
PPTYP		= PPTYP2;
PPGROUP		= PPGROUP2;
sallvl 		= SALLVL2;
STEMAGG		= STEMAGG2;
STEMOCC		= STEMOCC2;
STEMTYP		= STEMTYP2;
supervis 	= SUPERVIS2;
TOATYP 		= TOATYP2;
toa 		= TOA2;
worksch 	= WORKSCH2;
workstat 	= WORKSTAT2;
agytyp 		= AGYTYP2;
datecode 	= datecode2;
payplan 	= payplan2;
SUPERTYP	= SUPERTYP2;
WSTYP		= WSTYP2;

DROP 
AGY2 LOC2
AGYSUB2 
agelvl2
edlvl2 
EDLVLTYP2 
loctyp2 
loslvl2 
occ2 
OCCFAM2 
occtyp2 
patco2 
pp2 
PP_AGG2 
PPTYP2 
PPGROUP2 
sallvl2  
STEMAGG2
STEMOCC2 
STEMTYP2 
supervis2
TOATYP2 
toa2 
worksch2
workstat2
agytyp2 
datecode2 
payplan2 
SUPERTYP2 
WSTYP2; 

;
label 
	agysub 			= 'Sub-Agency'
	agy 			= 'Agency'
  	agytyp 			= 'Agency Type'
	loc 			= 'Location'
	agelvl 			= 'Age Level'
	edlvl 			= 'Education Level'
	gsegrd 			= 'GSE Grade'
	loslvl 			= 'LOS Level'
 	occ 			= 'Occupation'
 	sallvl 			= 'Salary Level'
 	stemocc 		= 'STEM Occupation'
 	supervis 		= 'Supervisory Status'
	supertyp 		= 'Supervisory Status Type'
 	toa 			= 'Type of Appt'
 	worksch 		= 'Work Schedule'
 	workstat 		= 'Work Status'
 	salary 			= 'Salary'
 	los 			= 'Length of Service'
	foreign_country = 'Foreign Country'
	LOCTYP 			= 'Location Type'
	occfam 			= 'Occupation Family'
	occtyp 			= 'Occupation Type'
	patco 			= 'Occupation Category'
	pp 				= 'Pay Plan Secondary'
	pp_agg 			= 'Pay Plan Aggregate'
	pptyp 			= 'Pay Plan Type'
	ppgroup 		= 'Pay Plan Group'
	stemagg 		= 'STEM Occupation Aggregate'
	toatyp 			= 'Type of Appointment Type'
	datecode 		= 'Date'
	payplan 		= 'Pay Plan'
	wstyp 			= 'Work Schedule Type'
	ppgrd 			= 'Pay Plan and Grade'
;

run;


/*Deleting factdata datasets*/
proc delete library=work data = factdata1-factdata17; run;


/*creating simulated salary, performance, and job satisfaction data*/
%macro RandBetween(min, max);
   (&min + floor((1+&max-&min)*rand("uniform")))
%mend;

data opm_factdata_enhanced;
set OPM_factdata;


/*  COMMENTING THESE OUT TO TEST REMOVING ALTOGHER */
array cyber_codes[2] $2 _temporary_ ('10', '11');
array binary_ind[2] $1 _temporary_ ('0','1');
array binary_ind_num[2] _temporary_ (0,1);
array training_hour_list[4] _temporary_ (0,8,16,24);
array reasons_list[6] $15 _temporary_ ('Retired',  'Higher Salary', 'Hated manager', 'Moving', 'Fired', 'Other');


/* generate baseline data that might be useful in predicting attrition */

   avg_training_hours=int(rand('normal', 40, 10));
   avg_job_satisfaction = int(rand('uniform', 1, 5));
   salary_delta = rand('normal', .1, .05); /* intended to represent the difference between govt pay and typical private sector pay */
   comp_private_sector_salary = salary*(1+salary_delta);
   fully_loaded_cost = salary*1.31;
   performance_rating = int(rand('normal', 3,.65));
   if performance_rating >5 then performance_rating=5;
   if performance_rating<1 then performance_rating=1;
   local_unemp_rate=rand('normal', 0.05, 0.015);
   if los >20 then retirement_eligible = 1; else retirement_eligible =0;
   if agelvl = '65 or more' then retirement_eligible = 1; else retirement_eligible =0;
   if agelvl in ('55-59', '60-64', '65 or more') then age_over_55 = '1'; else age_over_55 = '0';

/* Award Logic */
avg_num_awards_year = int(rand('normal', 1.5, .5)) ; /* Num of awards can be 0-2ish per year */
career_num_awards = avg_num_awards_year*int(los) ; /* multiply that by length of service */
avg_award_dollars = int(rand('uniform', 1, 100)) *100; /*award dollars should be in $100 increments */
award_flex_sched = binary_ind_num[rantbl(0, .7, .3)]; /* specifies the chances of getting a particular type of award */
award_telework = binary_ind_num[rantbl(0, .7, .3)]; /* specifies the chances of getting a particular type of award */
award_compressed_sched = binary_ind_num[rantbl(0, .5, .5)]; /* specifies the chances of getting a particular type of award */

wigi_past_12_mos = %RandBetween(0, 2); /* Num of within grade increases in the past 12 months */
if los>2 then wigi_past_24_mos = wigi_past_12_mos+%RandBetween(0,2); else wigi_past_24_mos = wigi_past_12_mos; /* Num of within grade increases in the past 24 months */
wigi_during_career = int(rand('normal', 1.5,.5)) * int(los); /* Num of within grade increases in career */

/* Turnover probability logic */
	turnover_prob= rand('normal', 0.05, 0.02); /* Set baseline probabilities for everyone */
	if occ='2210' then turnover_prob = %RandBetween(.1, .2);

	if agelvl IN ('Less than 20', '20-24', '25-29', '30-34') then
		do;
			turnover_prob = %RandBetween(.07, .18);
			if salary_delta > 0.1 then turnover_prob = turnover_prob * 3; 
			if avg_training_hours < 35 then turnover_prob = turnover_prob *3;
			if award_flex_sched = '1' then turnover_prob = turnover_prob * 0.5; 
		end;
   if salary_delta >0.15 and performance_rating >= 4 then /* High performers who are underpaid */
   	turnover_prob = turnover_prob *3 ; 
	if agelvl IN ('Less than 20', '20-24', '25-29') and salary_delta >0.1 then /*Young'ins lookin to make a move */
	
	if retirement_eligible =1 then turnover_prob=turnover_prob *3;
	if avg_job_satisfaction <=2 then turnover_prob = turnover_prob * 2;
	if local_unemp_rate <0.04 then turnover_prob = turnover_prob *1.2;
	if local_unemp_rate <0.03 then turnover_prob = turnover_prob *1.5;
	if local_unemp_rate >0.07 then turnover_prob = turnover_prob *0.5;

	if performance_rating <=2 then manager_complaints= int(rand('uniform', 0, 5));
		else manager_complaints = 0;
	if avg_num_awards_year >2 then turnover_prob = turnover_prob *0.5;
	if wigi_past_24_mos >2 then turnover_prob = turnover_prob *0.5;
	if avg_training_hours >40 then turnover_prob = turnover_prob *0.5;

	if turnover_prob >1 then turnover_prob=0.76;
	if turnover_prob <0 then turnover_prob=0.01;

	if turnover_prob > 0.10 then churn_propensity = 'High Churn'; else churn_propensity = 'Low Churn';

ID=_n_; *CREATING TO MERGE SIMULATED DATA BACK TO MASTER;

label
   	avg_training_hours = 'Average Training Hours'
	avg_job_satisfaction = 'Average Job Satisfaction'
	turnover_prob = 'Turnover Probability'
	salary_delta = 'Salary Delta from Private Sector'
	performance_rating = 'Performance Rating'
	avg_num_awards_year = 'Awards - Average Num / Year'
	avg_award_dollars = 'Awards - Average Value'
	award_compressed_sched = 'Work Status - Compressed Schedule'
	career_num_awards = 'Awards - Total Received'
	award_flex_sched = 'Work Status - Flex Schedule'
	award_telework = 'Work Status - Telework'
	wigi_during_career = 'Within Grade Increases - Total Received'
	wigi_past_12_mos = 'Within Grade Increases - Past 12 Months'
	wigi_past_24_mos = 'Within Grade Increases - Past 24 Months'
	retirement_eligible = 'Retirement Eligible'
	employment ='Num Employees'
	manager_complaints= 'Manager Complaints'
	comp_private_sector_salary='Comparable Private Sector Salary'
	fully_loaded_cost='Fully Loaded Cost'
	local_unemp_rate= 'Local Unemployment Rate'
	age_over_55='Age Over 55 Ind'
	churn_propensity = 'Historic Churn Propensity'
	
;

 format 
	comp_private_sector_salary fully_loaded_cost avg_award_dollars dollar10.
	turnover_prob salary_delta local_unemp_rate comma4.3
;

 output; 

/* end;  end position loop */

run;

/*creating datasets for each agency, which will each have race variables randomly assigned based on agency race proportions from OPM data*/
DATA AGY_CSOSA	AGY_DHS	AGY_DOC	AGY_DOE	AGY_DOI	AGY_DOJ	AGY_DOL	AGY_DOT	AGY_ED AGY_EEOC AGY_EPA	AGY_FCC	/*AGY_FERC*/ AGY_FTC AGY_GSA AGY_HHS AGY_HUD AGY_NARA 
AGY_NCUA AGY_NLRB AGY_NRC AGY_NSF AGY_OMB AGY_OPM AGY_PBGC AGY_RRB AGY_SBA AGY_SSA AGY_State AGY_USAGM AGY_USAID AGY_USDA AGY_USDT /*AGY_USACE*/ AGY_AF
AGY_Army AGY_Navy /*AGY_MarineCorps*/ AGY_VA AGY_DOD AGY_FDIC AGY_FRS AGY_GPO AGY_NASA AGY_SI AGY_OTHER;
set opm_factdata_enhanced;

    IF 		(AGY = 'COURT SERVICES AND OFFENDER SUPERVISION AGENCY FOR THE DISTRICT OF COLUMBIA') 	THEN OUTPUT AGY_CSOSA;
    ELSE IF (AGY = 'DEPARTMENT OF HOMELAND SECURITY' )												THEN OUTPUT AGY_DHS;
	ELSE IF (AGY = 'DEPARTMENT OF COMMERCE' )														THEN OUTPUT AGY_DOC;
	ELSE IF (AGY = 'DEPARTMENT OF ENERGY' )															THEN OUTPUT AGY_DOE;
	ELSE IF (AGY = 'DEPARTMENT OF THE INTERIOR') 													THEN OUTPUT AGY_DOI;
	ELSE IF (AGY = 'DEPARTMENT OF JUSTICE' 	)														THEN OUTPUT AGY_DOJ;
	ELSE IF (AGY = 'DEPARTMENT OF LABOR' )															THEN OUTPUT AGY_DOL;
	ELSE IF (AGY = 'DEPARTMENT OF TRANSPORTATION' )													THEN OUTPUT AGY_DOT;
	ELSE IF (AGY = 'DEPARTMENT OF EDUCATION' )														THEN OUTPUT AGY_ED;
	ELSE IF (AGY = 'EQUAL EMPLOYMENT OPPORTUNITY COMMISSION') 										THEN OUTPUT AGY_EEOC;
	ELSE IF (AGY = 'ENVIRONMENTAL PROTECTION AGENCY' )												THEN OUTPUT AGY_EPA;
	ELSE IF (AGY = 'FEDERAL COMMUNICATIONS COMMISSION' )											THEN OUTPUT AGY_FCC;
	*ELSE IF (AGY = 'DEPARTMENT OF ENERGY' AND AGYSUB ='FEDERAL ENERGY REGULATORY COMMISION') 		THEN OUTPUT AGY_FERC; /*SUB-AGENCY*/ 
	ELSE IF (AGY = 'FEDERAL TRADE COMMISSION' 	)													THEN OUTPUT AGY_FTC;
	ELSE IF (AGY = 'GENERAL SERVICES ADMINISTRATION' )												THEN OUTPUT AGY_GSA;
	ELSE IF (AGY = 'DEPARTMENT OF HEALTH AND HUMAN SERVICES' 	)									THEN OUTPUT AGY_HHS;
	ELSE IF (AGY = 'DEPARTMENT OF HOUSING AND URBAN DEVELOPMENT' )									THEN OUTPUT AGY_HUD;
	ELSE IF (AGY = 'NATIONAL ARCHIVES AND RECORDS ADMINISTRATION' )									THEN OUTPUT AGY_NARA;
	ELSE IF (AGY = 'NATIONAL CREDIT UNION ADMINISTRATION' )											THEN OUTPUT AGY_NCUA;
	ELSE IF (AGY = 'NATIONAL LABOR RELATIONS BOARD' 	)											THEN OUTPUT AGY_NLRB;
	ELSE IF (AGY = 'NUCLEAR REGULATORY COMMISSION' )												THEN OUTPUT AGY_NRC;
	ELSE IF (AGY = 'NATIONAL SCIENCE FOUNDATION' )													THEN OUTPUT AGY_NSF;
	ELSE IF (AGY = 'OFFICE OF MANAGEMENT AND BUDGET' )												THEN OUTPUT AGY_OMB;
	ELSE IF (AGY = 'OFFICE OF PERSONNEL MANAGEMENT') 												THEN OUTPUT AGY_OPM;
	ELSE IF (AGY = 'PENSION BENEFIT GUARANTY CORPORATION' )											THEN OUTPUT AGY_PBGC;
	ELSE IF (AGY = 'RAILROAD RETIREMENT BOARD' )													THEN OUTPUT AGY_RRB;
	ELSE IF (AGY = 'SMALL BUSINESS ADMINISTRATION' )												THEN OUTPUT AGY_SBA;
	ELSE IF (AGY = 'SOCIAL SECURITY ADMINISTRATION') 												THEN OUTPUT AGY_SSA;
	ELSE IF (AGY = 'DEPARTMENT OF STATE' 	)														THEN OUTPUT AGY_State;
	ELSE IF (AGY = 'U.S. AGENCY FOR GLOBAL MEDIA' )													THEN OUTPUT AGY_USAGM;
	ELSE IF (AGY = 'U.S. AGENCY FOR INTERNATIONAL DEVELOPMENT' 	)									THEN OUTPUT AGY_USAID;
	ELSE IF (AGY = 'DEPARTMENT OF AGRICULTURE')														THEN OUTPUT AGY_USDA;
	ELSE IF (AGY = 'DEPARTMENT OF THE TREASURY' )													THEN OUTPUT AGY_USDT;
	*ELSE IF (AGY = 'DEPARTMENT OF THE ARMY' AND AGYSUB = 'U.S. ARMY COPRS OF ENGINEERS') 			THEN OUTPUT AGY_USACE;  /*SUB-AGENCY*/ 
	ELSE IF (AGY = 'DEPARTMENT OF THE AIR FORCE' )													THEN OUTPUT AGY_AF; 
	ELSE IF (AGY = 'DEPARTMENT OF THE ARMY' )														THEN OUTPUT AGY_Army; 
	ELSE IF (AGY = 'DEPARTMENT OF THE NAVY' )														THEN OUTPUT AGY_Navy; 
	ELSE IF (AGY = 'DEPARTMENT OF VETERANS AFFAIRS' )												THEN OUTPUT AGY_VA; 
	ELSE IF (AGY = 'DEPARTMENT OF DEFENSE' )														THEN OUTPUT AGY_DOD;
	ELSE IF (AGY = 'FEDERAL DEPOSIT INSURANCE CORPORATION' )										THEN OUTPUT AGY_FDIC;
	ELSE IF (AGY = 'FEDERAL RESERVE SYSTEM' )														THEN OUTPUT AGY_FRS;
	ELSE IF (AGY = 'GOVERNMENT PRINTING OFFICE' )													THEN OUTPUT AGY_GPO;
	ELSE IF (AGY = 'NATIONAL AERONAUTICS AND SPACE ADMINISTRATION' )								THEN OUTPUT AGY_NASA;
	ELSE IF (AGY = 'SMITHSONIAN INSTITUTION' )														THEN OUTPUT AGY_SI;
	*ELSE IF (AGY = 'DEPARTMENT OF THE NAVY' AND AGYSUB = 'U.S. MARINE CORPS') 						THEN OUTPUT AGY_MarineCorps; /*SUB-AGENCY*/ 
	ELSE OUTPUT agy_OTHER; 

RUN;

/*formats for simulated demographics*/
proc format;
	value race
		1="American Indian/Alaska Native"	
		2="Asian"	
		3="Black/African American"	
		4="Native Hawaiin/Other Pacific Islander"	
		5="White"	
		6="Two or more races"
	;

	value gender
		0="Male"
		1="Female"
	;

	value YN
		0="No"
		1="Yes"
	;
run;
		
/*creating macro to randomly assign race based on race proportions by agency from opm*/
/*Race/Ethnicity Source: https://www.fedscope.opm.gov/ibmcognos/bi/v1/disp?b_action=powerPlayService&m_encoding=UTF-8&BZ=1AAABmcxRP3142oWOT2uDQBDFv8yOaQ8Ns09NzcHD6q5EaDWNuRdjNkGaaFEp9NsXFfonl77HwPDm%7EWCcIl8W_3xnUh32Q9vZVN8RUKtArh4ZK_MnxnMDFSVRHHiSleLIDTxDwL0zskbt4s1W7TchIanaZrDNQEhO7eVoO%7EIj8rgpr5ZcvdiW1Vt5tv2rrj9s19fD54J8TUje58Pf9neJwA8E1ray14PtCAwGRtTRRbyM8ywz8T7Ns0w9m%7EAfzIlewhOzkMwsJQshWPgswGK0EOpsm2pkCUcCq8uFeP3UVuVQt81NLAgBwWWClYQDYT0H8icQkwjuWP8lOXna5memmV_Y9QVgm2gC*/
/*Gender Source: https://www.fedscope.opm.gov/ibmcognos/bi/v1/disp?b_action=powerPlayService&m_encoding=UTF-8&BZ=1AAABnMsb2_t42oVOQW6DMBD8jJe0h0brxWnhwMGxjYLUQhq4V4Q4UVSwI8Ilv6_AQ9peMqOVRrMz0gRlsSyrYmcynVwH39tMPwHRmWulpBFoMA7FK_dRGEVKCvkWYyTSWADRczB2jdypzVZWmwQobbwbrBuA0qNvD7aH1RoEurqzEOrFtm6_65O9fpnu0vpbZ92wgJUGSi%7Ez52%7E8ngLCFyDUtrHd3vZASEg0dgNdqqUq8tyoKivyXH6Y5FEvWH8mR0TGEZFzZIwhWyEjZCMZkyfrmhsQAh2AULYtYPzum3o4e%7EfPZkARUIhAlgPtgeLZ4HeDTQAKx%7Egv8ImTmsdMN0_Y8QPrrGkW*/

%macro demogs (agy, female, hispanic, aian, asian, black, nhopi, white, TWOormore);

proc sql;
	select count(*) into :totalpopulation from AGY_&agy.;
quit;

%let N&agy. = &totalpopulation;
DATA FIN_AGY_&agy.;
SET AGY_&agy.;
Gender = rand('Bernoulli',&female.); /*Generates a 0 or 1 with a probability of a 1 equal to .6*/
Hispanic = rand('Bernoulli',&hispanic.); 

drop i; 
array prob[6] _temporary_ (&aian.,&asian.,&black.,&nhopi.,&white.,&TWOormore.); 
call streaminit(54321); 
/*do i = 1 to &&N&agy.;*/
do i = 1 to 1;
   Race = rand("Table", of prob[*]);
   output; 
end;

format gender gender. hispanic yn.; 


RUN;


/*PROC FREQ DATA = FIN_AGY_&agy.; TABLE RACE; RUN;*/

%mend demogs;

*NOTE: OPM INCLUDES HISPANIC/LATINO AS RACE, WHILE CENSUS DOES NOT. FOR THIS REPORT, WE ARE REMAINING CONSISTENT WITH CENSUS. THE PROPORTIONS OF THE 6 RACES (I.E., AIAN, ASIAN, 
BLACK, NHOPI, WHITE, AND 2 OR MORE) WERE CALCULATED BY DIVIDING THE RESPECTIVE RACE COUNT BY OF THE SUM OF THOSE 6 RACES. THE PROPORTION OF HISPANIC/LATINO WAS CALCULATED BY DIVIDING 
THE COUNT OF HISPANIC/LATINO BY THE TOTAL AGENCY POPULATION;

%demogs (agy=	CSOSA	, female =	0.644	, hispanic =	0.058	, aian = 	0.000	,  asian = 	0.039	, black =	0.839	, nhopi=	0.000	, white=	0.111	, twoormore= 	0.011	);
%demogs (agy=	DHS		, female =	0.359	, hispanic =	0.223	, aian = 	0.008	,  asian = 	0.070	, black =	0.218	, nhopi=	0.007	, white=	0.668	, twoormore= 	0.029	);
%demogs (agy=	DOC		, female =	0.451	, hispanic =	0.065	, aian = 	0.005	,  asian = 	0.135	, black =	0.175	, nhopi=	0.002	, white=	0.662	, twoormore= 	0.021	);
%demogs (agy=	DOE		, female =	0.373	, hispanic =	0.081	, aian = 	0.011	,  asian = 	0.066	, black =	0.118	, nhopi=	0.002	, white=	0.779	, twoormore= 	0.024	);
%demogs (agy=	DOI		, female =	0.420	, hispanic =	0.066	, aian = 	0.129	,  asian = 	0.027	, black =	0.053	, nhopi=	0.006	, white=	0.759	, twoormore= 	0.026	);
%demogs (agy=	DOJ		, female =	0.408	, hispanic =	0.109	, aian = 	0.006	,  asian = 	0.043	, black =	0.172	, nhopi=	0.002	, white=	0.757	, twoormore= 	0.020	);
%demogs (agy=	DOL		, female =	0.494	, hispanic =	0.119	, aian = 	0.006	,  asian = 	0.084	, black =	0.256	, nhopi=	0.002	, white=	0.632	, twoormore= 	0.020	);
%demogs (agy=	DOT		, female =	0.265	, hispanic =	0.094	, aian = 	0.009	,  asian = 	0.062	, black =	0.138	, nhopi=	0.004	, white=	0.759	, twoormore= 	0.028	);
%demogs (agy=	ED		, female =	0.628	, hispanic =	0.074	, aian = 	0.008	,  asian = 	0.074	, black =	0.401	, nhopi=	0.001	, white=	0.496	, twoormore= 	0.020	);
%demogs (agy=	EEOC	, female =	0.629	, hispanic =	0.166	, aian = 	0.005	,  asian = 	0.064	, black =	0.436	, nhopi=	0.000	, white=	0.458	, twoormore= 	0.037	);
%demogs (agy=	EPA		, female =	0.530	, hispanic =	0.074	, aian = 	0.007	,  asian = 	0.083	, black =	0.177	, nhopi=	0.001	, white=	0.705	, twoormore= 	0.027	);
%demogs (agy=	FCC		, female =	0.483	, hispanic =	0.041	, aian = 	0.003	,  asian = 	0.100	, black =	0.268	, nhopi=	0.000	, white=	0.617	, twoormore= 	0.012	);
%demogs (agy=	FTC		, female =	0.497	, hispanic =	0.050	, aian = 	0.000	,  asian = 	0.101	, black =	0.171	, nhopi=	0.000	, white=	0.703	, twoormore= 	0.026	);
%demogs (agy=	GSA		, female =	0.464	, hispanic =	0.075	, aian = 	0.004	,  asian = 	0.074	, black =	0.277	, nhopi=	0.003	, white=	0.613	, twoormore= 	0.031	);
%demogs (agy=	HHS		, female =	0.624	, hispanic =	0.047	, aian = 	0.121	,  asian = 	0.137	, black =	0.209	, nhopi=	0.002	, white=	0.514	, twoormore= 	0.017	);
%demogs (agy=	HUD		, female =	0.584	, hispanic =	0.089	, aian = 	0.010	,  asian = 	0.071	, black =	0.401	, nhopi=	0.002	, white=	0.491	, twoormore= 	0.026	);
%demogs (agy=	NARA	, female =	0.515	, hispanic =	0.038	, aian = 	0.004	,  asian = 	0.031	, black =	0.294	, nhopi=	0.002	, white=	0.643	, twoormore= 	0.026	);
%demogs (agy=	NCUA	, female =	0.439	, hispanic =	0.068	, aian = 	0.005	,  asian = 	0.075	, black =	0.168	, nhopi=	0.000	, white=	0.732	, twoormore= 	0.021	);
%demogs (agy=	NLRB	, female =	0.626	, hispanic =	0.118	, aian = 	0.005	,  asian = 	0.068	, black =	0.264	, nhopi=	0.000	, white=	0.643	, twoormore= 	0.020	);
%demogs (agy=	NRC		, female =	0.404	, hispanic =	0.085	, aian = 	0.005	,  asian = 	0.113	, black =	0.177	, nhopi=	0.000	, white=	0.683	, twoormore= 	0.023	);
%demogs (agy=	NSF		, female =	0.614	, hispanic =	0.054	, aian = 	0.003	,  asian = 	0.094	, black =	0.297	, nhopi=	0.000	, white=	0.582	, twoormore= 	0.025	);
%demogs (agy=	OMB		, female =	0.563	, hispanic =	0.039	, aian = 	0.009	,  asian = 	0.108	, black =	0.105	, nhopi=	0.000	, white=	0.756	, twoormore= 	0.022	);
%demogs (agy=	OPM		, female =	0.639	, hispanic =	0.047	, aian = 	0.004	,  asian = 	0.050	, black =	0.317	, nhopi=	0.000	, white=	0.603	, twoormore= 	0.027	);
%demogs (agy=	PBGC	, female =	0.569	, hispanic =	0.047	, aian = 	0.000	,  asian = 	0.136	, black =	0.428	, nhopi=	0.000	, white=	0.417	, twoormore= 	0.020	);
%demogs (agy=	RRB		, female =	0.542	, hispanic =	0.100	, aian = 	0.000	,  asian = 	0.057	, black =	0.419	, nhopi=	0.000	, white=	0.508	, twoormore= 	0.016	);
%demogs (agy=	SBA		, female =	0.581	, hispanic =	0.189	, aian = 	0.012	,  asian = 	0.075	, black =	0.408	, nhopi=	0.003	, white=	0.475	, twoormore= 	0.028	);
%demogs (agy=	SSA		, female =	0.649	, hispanic =	0.158	, aian = 	0.012	,  asian = 	0.086	, black =	0.360	, nhopi=	0.005	, white=	0.520	, twoormore= 	0.017	);
%demogs (agy=	STATE	, female =	0.531	, hispanic =	0.074	, aian = 	0.004	,  asian = 	0.083	, black =	0.240	, nhopi=	0.002	, white=	0.646	, twoormore= 	0.025	);
%demogs (agy=	USAGM	, female =	0.408	, hispanic =	0.076	, aian = 	0.004	,  asian = 	0.229	, black =	0.266	, nhopi=	0.000	, white=	0.495	, twoormore= 	0.006	);
%demogs (agy=	USAID	, female =	0.568	, hispanic =	0.069	, aian = 	0.002	,  asian = 	0.099	, black =	0.221	, nhopi=	0.001	, white=	0.646	, twoormore= 	0.031	);
%demogs (agy=	USDA	, female =	0.444	, hispanic =	0.103	, aian = 	0.017	,  asian = 	0.039	, black =	0.140	, nhopi=	0.004	, white=	0.775	, twoormore= 	0.025	);
%demogs (agy=	USDT	, female =	0.616	, hispanic =	0.142	, aian = 	0.006	,  asian = 	0.076	, black =	0.332	, nhopi=	0.002	, white=	0.567	, twoormore= 	0.017	);
%demogs (agy=	AF		, female =	0.281	, hispanic =	0.089	, aian = 	0.010	,  asian = 	0.043	, black =	0.134	, nhopi=	0.008	, white=	0.774	, twoormore= 	0.032	);
%demogs (agy=	ARMY	, female =	0.302	, hispanic =	0.083	, aian = 	0.008	,  asian = 	0.040	, black =	0.160	, nhopi=	0.007	, white=	0.760	, twoormore= 	0.025	);
%demogs (agy=	NAVY	, female =	0.263	, hispanic =	0.069	, aian = 	0.008	,  asian = 	0.098	, black =	0.139	, nhopi=	0.018	, white=	0.698	, twoormore= 	0.039	);
%demogs (agy=	VA		, female =	0.628	, hispanic =	0.072	, aian = 	0.014	,  asian = 	0.095	, black =	0.267	, nhopi=	0.005	, white=	0.606	, twoormore= 	0.013	);
%demogs (agy=	DOD		, female =	0.534	, hispanic =	0.084	, aian = 	0.007	,  asian = 	0.074	, black =	0.221	, nhopi=	0.009	, white=	0.658	, twoormore= 	0.031	);
%demogs (agy=	FDIC	, female =	0.437	, hispanic =	0.052	, aian = 	0.006	,  asian = 	0.089	, black =	0.183	, nhopi=	0.001	, white=	0.699	, twoormore= 	0.022	);
%demogs (agy=	FRS		, female =	0.504	, hispanic =	0.071	, aian = 	0.005	,  asian = 	0.099	, black =	0.243	, nhopi=	0.000	, white=	0.619	, twoormore= 	0.034	);
%demogs (agy=	GPO		, female =	0.380	, hispanic =	0.016	, aian = 	0.008	,  asian = 	0.048	, black =	0.480	, nhopi=	0.000	, white=	0.455	, twoormore= 	0.009	);
%demogs (agy=	NASA	, female =	0.357	, hispanic =	0.088	, aian = 	0.005	,  asian = 	0.086	, black =	0.118	, nhopi=	0.001	, white=	0.768	, twoormore= 	0.022	);
%demogs (agy=	SI		, female =	0.464	, hispanic =	0.054	, aian = 	0.013	,  asian = 	0.042	, black =	0.416	, nhopi=	0.001	, white=	0.508	, twoormore= 	0.020	);
%demogs (agy=	OTHER   , female =  0.453	, hispanic =	0.099	, aian = 	0.018	,  asian = 	0.075	, black =	0.205	, nhopi=	0.006	, white=	0.672	, twoormore= 	0.024	);


/*QC*/
/* PROC FREQ DATA = FIN_AGY_CSOSA; TABLE GENDER hispanic race; RUN; */
/* PROC FREQ DATA = FIN_AGY_HUD; TABLE GENDER hispanic race; RUN; */
/* PROC FREQ DATA = FIN_AGY_SSA; TABLE GENDER hispanic race; RUN; */
/* PROC FREQ DATA = FIN_AGY_OTHER; TABLE GENDER hispanic race; RUN; */

/*STACKING ALL AGENCY DATA WITH DEMOGS*/
DATA STACKED_EMPLOYMENT;
SET FIN:;
RUN;

/*Deleting agency specific datasets*/
proc datasets nolist lib=work;
 delete agy_: ; 
 quit;

 proc datasets nolist lib=work;
 delete fin_agy_: ; 
 quit;


/*GETTING COUNTS FOR RACE BY AGENCY/STATE*/
proc sql;
	create table opm_race_counts as
		select distinct agy
		, state
		, race
		, count(*) as total_race
	
	from STACKED_EMPLOYMENT
	group by agy, state, race
	;
quit;

/*GETTING COUNTS FOR GENDER BY AGENCY/STATE*/
proc sql;
	create table opm_GENDER_counts as
		select distinct agy
		, state
		, GENDER
		, count(*) as total_gender
	
	from STACKED_EMPLOYMENT
	group by agy, state, GENDER
	;
quit;

/*GETTING COUNTS FOR HISP BY AGENCY/STATE*/
proc sql;
	create table opm_HISP_counts as
		select distinct agy
		, state
		, HISPANIC
		, count(*) as total_hisp
	
	from STACKED_EMPLOYMENT
	group by agy, state, HISPANIC
	;
quit;


/*GETTING COUNTS FOR AGENCY/STATE*/
proc sql;
	create table opm_agy_by_state_counts as
		select distinct agy
		, state
		, count(*) as total_by_agy_state
	
	from STACKED_EMPLOYMENT
	group by agy, state
	;
quit;

/*Merging the total agency population and demographic counts to calculae the percentage of simulated demographics by agency population*/
data opm_RACE_pcts;
merge opm_race_counts opm_agy_by_state_counts;
by agy  state;
opm_race_pct = total_race/total_by_agy_state;
run;

data opm_GENDER_pcts;
merge OPM_GENDER_COUNTS  opm_agy_by_state_counts;
by agy  state;
opm_GENDER_pct = total_gender/total_by_agy_state;
run;

data opm_HISP_pcts;
merge  OPM_HISP_COUNTS opm_agy_by_state_counts;
by agy  state;
opm_HISP_pct = total_hisp/total_by_agy_state;
run;

/*transposing race by agency and state so percentages can be merged back with opm factdata*/
proc transpose data=opm_race_pcts out=RACE_finalpercent prefix=race_;
	id race;
	by agy state;
	var opm_race_pct;
run;

/*transposing race by agency and state so totals can be merged back with opm factdata and used to calcualte p-value*/
proc transpose data=opm_race_pcts out=RACE_finalcount prefix=race2_;
	id race;
	by agy state;
	var total_race;
run;

/*transposing gender by agency and state so percentages can be merged back with opm factdata*/
proc transpose data=opm_GENDER_pcts out=GENDER_finalpercent prefix=gender_;
	id GENDER;
	by agy state;
	var opm_GENDER_pct;
run;

/*transposing gender by agency and state so counts can be merged back with opm factdata and used to calculate p-value*/
proc transpose data=opm_GENDER_pcts out=GENDER_finalcount prefix=gender2_;
	id GENDER;
	by agy state;
	var total_gender;
run;

/*transposing hispanic origin by agency and state so percentages can be merged back with opm factdata*/
proc transpose data=opm_HISP_pcts out=HISP_finalpercent prefix=HISP_;
	id HISPANIC;
	by agy state;
	var opm_HISP_pct;
run;


DATA opm_finalpercent;
length _name_ $50;
MERGE RACE_finalpercent GENDER_FINALPERCENT GENDER_FINALCOUNT HISP_FINALPERCENT RACE_finalcount;
BY AGY STATE;

/*renaming after specific demographic*/
OPM_MALE_PCT = gender_MALE;
OPM_FEMALE_PCT = gender_FEMALE;
OPM_HISP_PCT = HISP_YES;
OPM_BLACK_PCT = race_3;
OPM_WHITE_PCT = race_5;
OPM_ASIAN_PCT = race_2;
OPM_AIAN_PCT = race_1;
OPM_NHOPI_PCT = race_6;
OPM_TOM_PCT = race_4;

OPM_MALE = gender2_MALE;
OPM_FEMALE = gender2_FEMALE;
OPM_BLACK = race2_3;
OPM_WHITE = race2_5;
OPM_ASIAN = race2_2;
OPM_AIAN = race2_1;
OPM_NHOPI = race2_6;
OPM_TOM = race2_4;


   array change _numeric_;
        do over change;
            if change=. then change=0;
        end;

DROP race_1 race_2 race_3 race_4 race_5 race_6 race2_1 race2_2 race2_3 race2_4 race2_5 race2_6 HISP_NO HISP_YES gender_MALE gender_FEMALE gender2_MALE gender2_FEMALE _NAME_;
RUN;


*SORTING DATA TO PREPARE FOR MERGE;
PROC SORT DATA = STACKED_EMPLOYMENT;
BY AGY STATE ;
RUN;



/*MERGE OPM AND CENSUS PROPORTIONS WITH MASTER EMPLOYMENT (STACKED) DATA*/
DATA opm_finalpercent2;
length race_formatted $40 gender_formatted $6;
MERGE STACKED_EMPLOYMENT opm_finalpercent;
BY AGY STATE;

if race =			1 then race_formatted = "American Indian/Alaska Native";	
else if race =		2 then race_formatted = "Asian"	;
else if race =		3 then race_formatted = "Black/African American"	;
else if race =		4 then race_formatted = "Native Hawaiian/Other Pacific Islander"	;
else if race =		5 then race_formatted = "White"	;
else if race =		6 then race_formatted = "Two or more races";
 
if gender = 0 then gender_formatted = "Male";
else if gender = 1 then gender_formatted = "Female";


RUN;


PROC SORT DATA = opm_finalpercent2;
BY STATE ;
RUN;


/*MERGE OPM FACTDATA WITH CENSUS DATA TO CREATE FINAL OPM EMPLOYMENT DATASET WITH P-VALUES FOR RACE AND GENDER*/
DATA opm_finalpercent3;
MERGE opm_finalpercent2 TOTAL_POP_BY_STATE;
BY STATE;

/*calculating p-value using expected and observed race*/
opm_race_total=sum(opm_asian,opm_black,opm_white,opm_aian,opm_nhopi);
	expected_asian = opm_race_total*census_asian_pct;
	expected_black = opm_race_total*census_black_pct;
	expected_white = opm_race_total*census_white_pct;
	expected_aian =  opm_race_total*census_aian_pct;
	expected_nhopi = opm_race_total*census_nhopi_pct;


	race_test_statistic = sum(((opm_asian-expected_asian)**2)/expected_asian,
					((opm_black-expected_black)**2)/expected_black,
					((opm_nhopi-expected_nhopi)**2)/expected_nhopi,
					((opm_aian-expected_aian)**2)/expected_aian,
					((opm_white-expected_white)**2)/expected_white);
	race_p_value = CDF('CHISQUARE', race_test_statistic, 16);

/*calculating p-value using expected and observed gender*/
OPM_gender_total=sum(OPM_male,OPM_female);
	expected_male = OPM_gender_total*census_male_pct;
	expected_female = OPM_gender_total*census_female_pct;


	gender_test_statistic = sum(((opm_male-expected_male)**2)/expected_male,
					((opm_female-expected_female)**2)/expected_female);
	gender_p_value = CDF('CHISQUARE', gender_test_statistic, 1);

drop opm_black opm_white opm_asian opm_aian opm_nhopi opm_tom total_: expected: race_test_statistic gender_test_statistic opm_race_total opm_gender_total opm_male opm_female AGYABBREV AGYSUBABBREV;
where state not in ('','SUPPRESSED (SEE DATA DEFINITIONS)');

RUN;

proc sort nodupkey data = opm_finalpercent3 out = opm_finalpercent4;
by agy state;
run;

/* proc sql; */
/* 	create table opm_employment as */
/* 		select a.*, b.race_p_value, b.gender_p_value */
/* 	from opm_finalpercent2 as a */
/* 		left join opm_finalpercent4 as b */
/* 		on a.state=b.state and a.agy=b.agy */
/* 	; */
/* quit; */

proc sort data = opm_finalpercent2 ;
by agy state;
run;

DATA opm_employment;
MERGE opm_finalpercent2 opm_finalpercent4;
BY agy STATE;

/*  LOADING THE OPM EMPLOYMENT TABLE INTO MEMORY */
proc casutil ;
  /* need to drop a global scoped table */
  droptable incaslib="Public" casdata="OPM_EMPLOYMENT" quiet;
  /* now load the table, in this we use a SAS data set */
  load data=work.OPM_EMPLOYMENT outcaslib="Public" casout="OPM_EMPLOYMENT" promote;
quit;

/*** create LIBNAME connection to ADLS2 file share ***/
libname wfa "/mnt/viya-share/myazurevol/data/WorkforceAnalytics/SAS Datasets" ;

data wfa.opm_employment;
set work.opm_employment;
run;



















