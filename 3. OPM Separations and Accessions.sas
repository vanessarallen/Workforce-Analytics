****  SAS Program to Read in DATA.gov FedScope Employment Cube RAW Data Sets for general public consumption;
****  The source data and the bulk of this SAS program come from https://www.opm.gov/data/Index.aspx?tag=FedScope;

  ****  Program Imports Separations and Accessions data;
  ****    - SEPDATA_FY2020-2024 AND ACCDATA_FY2020-2024 table and 3 Dimension Translations tables (DTtables);
  ****
  ****  NOTE:
  ****    - Change PATH1 and PATH2 Statements below to directory path Raw Data sets are in;	
  ****    - Change %LET Statement for SEPDATA and ACCDATA to correct FYs (e.g. SEPDATA_FY2020-2024.txt);
  ****;
 

%LET PATH1 = https://www.opm.gov/data/datasets/Files/652/b911dde6-b7a6-4825-9471-c64f82138545.zip;  * Separations zip file;
%LET PATH2 = https://www.opm.gov/data/datasets/Files/649/f62874c3-802f-4e49-a473-e177b8f2adaa.zip;  * Accessions zip file;
%LET FYS = 2020-2024;

************************************************
************************************************
************************************************
  *** IMPORTING SEPDATA FROM WEB ZIP FILE ***;
************************************************
************************************************
************************************************;

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
filename SEPDATA zip "&ziploc";
 
/* Read the "members" (files) from the ZIP file */
data contents(keep=memname);
 length memname $200;
 fid=dopen("SEPDATA");
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


DATA SEPDATA0;
INFILE SEPDATA(SEPDATA_FY&FYS..TXT) firstobs=2 dlm=',' dsd missover;
INFORMAT	AGYSUB		$4.;
INFORMAT	SEP			$2.;
INFORMAT	EFDATE		$6.;
INFORMAT	AGELVL		$1.;
INFORMAT	EDLVL		$2.;
INFORMAT	GSEGRD		$2.;
INFORMAT	LOSLVL		$1.;
INFORMAT	LOC			$2.;
INFORMAT	OCC			$4.;
INFORMAT	PATCO		$1.;
INFORMAT	PPGRD		$5.;
INFORMAT	SALLVL		$1.;
INFORMAT	STEMOCC		$4.;
INFORMAT	TOA			$2.;
INFORMAT	WORKSCH		$1.;
INFORMAT	WORKSTAT	$1.;
INFORMAT 	COUNT 	    $1.;
INFORMAT 	SALARY 		DOLLAR8.;
INFORMAT 	LOS 		4.1;
FORMAT		AGYSUB		$4.;
FORMAT		SEP			$2.;
FORMAT		EFDATE		$6.;
FORMAT		AGELVL		$1.;
FORMAT		EDLVL		$2.;
FORMAT		GSEGRD		$2.;
FORMAT		LOC			$2.;
FORMAT		LOSLVL		$1.;
FORMAT		OCC			$4.;
FORMAT		PATCO		$1.;
FORMAT		PPGRD		$5.;
FORMAT		SALLVL		$1.;
FORMAT	    STEMOCC		$4.;
FORMAT		TOA			$2.;
FORMAT		WORKSCH		$1.;
FORMAT		WORKSTAT	$1.;
FORMAT 	 	COUNT 	$1.;
FORMAT   	SALARY 		DOLLAR8.;
FORMAT   	LOS 		4.1;
INPUT
AGYSUB
SEP
EFDATE
AGELVL
EDLVL
GSEGRD
LOSLVL
LOC
OCC
PATCO
PPGRD
SALLVL
STEMOCC
TOA
WORKSCH
WORKSTAT
COUNT 	
SALARY 		
LOS;
RUN;
** End SEPDATA table processing;


*** Read In Separations Table;
* define the STATUS text file extract via FILENAME statement;
filename SEPDATA zip "&ziploc" member="DTefdate.txt";
    data dtefdate    ;
	INFILE SEPDATA firstobs=2 dlm=',' dsd missover;
	input 
		FY 		: $1.
		FYT 	: $7.
		QTR 	: $1.
		QTRT 	: $12.
		EFDATE 	: $6.
		EFDATET : $8.;
    run;


filename SEPDATA zip "&ziploc" member="DTsep.txt";
    data dtsep    ;
	INFILE SEPDATA firstobs=2 dlm=',' dsd missover;
	input 
		SEP 	: $2.
		SEPT 	: $34.;
    run;


************************************************
************************************************
************************************************
  *** IMPORTING ACCDATA FROM WEB ZIP FILE ***;
************************************************
************************************************
************************************************;

/* Download the ZIP file from the Internet*/
proc http
 method='GET'
 url="&PATH2"
 out=download;
run;

/* Assign a fileref wth the ZIP method */
filename ACCDATA zip "&ziploc";
 
/* Read the "members" (files) from the ZIP file */
data contents(keep=memname);
 length memname $200;
 fid=dopen("ACCDATA");
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


DATA ACCDATA0;
INFILE ACCDATA(ACCDATA_FY&FYS..TXT) firstobs=2 dlm=',' dsd missover;         
 *** Read In ACCDATA table;
 * define the DYNAMICS text file extract via FILENAME statements;
         INFORMAT	AGYSUB		$4.;
         INFORMAT	ACC			$2.;
         INFORMAT	EFDATE		$6.;
         INFORMAT	AGELVL		$1.;
/*Added*/ INFORMAT  EDLVL       $2.;
         INFORMAT	GSEGRD		$2.;
         INFORMAT	LOSLVL		$1.;
         INFORMAT	LOC			$2.;
         INFORMAT	OCC			$4.;
         INFORMAT	PATCO		$1.;
         INFORMAT	PPGRD		$5.;
         INFORMAT	SALLVL		$1.;
/*Added*/INFORMAT	STEMOCC		$4.;
         INFORMAT	TOA			$2.;
         INFORMAT	WORKSCH		$1.;
         INFORMAT 	WORKSTAT 	$1.; /*changed from EMPLOYMENT*/
/*Added*/ INFORMAT  COUNT       $1.;
         INFORMAT 	SALARY 		DOLLAR8.;
         INFORMAT 	LOS 		4.1;
         FORMAT		AGYSUB		$4.;
         FORMAT		ACC			$2.;
         FORMAT		EFDATE		$6.;
         FORMAT		AGELVL		$1.;
/*Added*/ FORMAT    EDLVL       $2.;
         FORMAT		GSEGRD		$2.;
         FORMAT		LOC			$2.;
         FORMAT		LOSLVL		$1.;
         FORMAT		OCC			$4.;
         FORMAT		PATCO		$1.;
         FORMAT		PPGRD		$5.;
         FORMAT		SALLVL		$1.;
/*Added*/FORMAT	    STEMOCC		$4.;
         FORMAT		TOA			$2.;
         FORMAT		WORKSCH		$1.;
         FORMAT 	WORKSTAT 	$1.; /*changed from EMPLOYMENT*/
/*Added*/ FORMAT    COUNT       $1.;
         FORMAT   	SALARY 		DOLLAR8.;
         FORMAT   	LOS 		4.1;
         INPUT
         AGYSUB
         ACC
         EFDATE
         AGELVL
/*Added*/ EDLVL     
         GSEGRD
         LOSLVL
         LOC
         OCC
         PATCO
         PPGRD
         SALLVL
		 STEMOCC
         TOA
         WORKSCH
         WORKSTAT /*changed from EMPLOYMENT*/
		 COUNT	
         SALARY 		
         LOS;
         RUN;


filename ACCDATA zip "&ziploc" member="DTacc.txt";
    data dtacc    ;
	INFILE ACCDATA firstobs=2 dlm=',' dsd missover;
	input 
		ACC 	: $2.
		ACCT 	: $46.;
    run;


************************************************
************************************************
************************************************
*** COMBINING SEPARATIONS AND ACCESSIONS DATA **;
************************************************
************************************************
************************************************;

data sep_acc0;
set sepdata0 accdata0;
run;


/* Macro to MERGE all OPM Files with FACTDATA*/
%macro SEP_ACC (ds1, ds2, var, finalds);

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
%mend SEP_ACC;

%sep_acc (ds1=DTagy,     ds2=SEP_ACC0,  var=agysub, 	finalds=SEP_ACC1);
%sep_acc (ds1=DTACC,     ds2=SEP_ACC1,  var=ACC, 		finalds=SEP_ACC2);
%sep_acc (ds1=DTLOC,     ds2=SEP_ACC2,  var=LOC, 		finalds=SEP_ACC3);
%sep_acc (ds1=DTAGELVL,  ds2=SEP_ACC3,  var=AGELVL, 	finalds=SEP_ACC4);
%sep_acc (ds1=DTEDLVL,   ds2=SEP_ACC4,  var=EDLVL, 		finalds=SEP_ACC5);
%sep_acc (ds1=DTLOSLVL,  ds2=SEP_ACC5,  var=LOSLVL, 	finalds=SEP_ACC6);
%sep_acc (ds1=DTPATCO,   ds2=SEP_ACC6,  var=PATCO, 		finalds=SEP_ACC7);
%sep_acc (ds1=DTSEP,     ds2=SEP_ACC7,  var=SEP, 		finalds=SEP_ACC8);
%sep_acc (ds1=DTPPGRD,   ds2=SEP_ACC8,  var=PPGRD, 		finalds=SEP_ACC9);
%sep_acc (ds1=DTSALLVL,  ds2=SEP_ACC9,  var=SALLVL, 	finalds=SEP_ACC10);
%sep_acc (ds1=DTSTEMOCC, ds2=SEP_ACC10, var=STEMOCC, 	finalds=SEP_ACC11);
%sep_acc (ds1=DTEFDATE,  ds2=SEP_ACC11, var=EFDATE, 	finalds=SEP_ACC12);
%sep_acc (ds1=DTTOA,     ds2=SEP_ACC12, var=TOA, 		finalds=SEP_ACC13);
%sep_acc (ds1=DTWRKSCH,  ds2=SEP_ACC13, var=WORKSCH, 	finalds=SEP_ACC14);
%sep_acc (ds1=DTWKSTAT,  ds2=SEP_ACC14, var=WORKSTAT, 	finalds=SEP_ACC15);
%sep_acc (ds1=DTOCC,     ds2=SEP_ACC15, var=OCC, 		finalds=SEP_ACC16);


data sep_acc17;
set sep_acc16;
ACC2 		= ACCT;****;
SEP2 		= SEPT; ****;
AGY2 		= substr(AGYT, 4);
AGYSUB2 	= substr(AGYSUBT, 6);
agelvl2 	= AGELVLT;
edlvl2 		= SUBSTR(EDLVLT,4);
EDLVLTYP2 	= EDLVLTYPT;
EFDATE2 	= EFDATEt;***;
LOC2 		= SUBSTR(LOCT,4);
loctyp2		= loctypt;
loslvl2 	= LOSLVLT;
occ2 		= substr(OCCT,6);
OCCFAM2 	= substr(OCCFAMT,6);
occtyp2 	= occtypt;
patco2 		= PATCOT;
PPTYP2		= PPTYPT;
PPGROUP2	= PPGROUPT;
sallvl2 	= SALLVLT;
STEMAGG2	= STEMAGGT;
STEMOCC2	= SUBSTR(STEMOCCT,6);
STEMTYP2	= STEMTYPT;
TOATYP2 	= TOATYPT;
toa2 		= substr(TOAT,4);
worksch2 	= substr(WORKSCHT,5);
workstat2 	= WORKSTATT;
agytyp2 	= AGYTYPT;
payplan2 	= SUBSTR(payplant,4);
WSTYP2		= WSTYPT;

if loctyp=1 then STATE = loc2;
if loctyp=3 then FOREIGN_COUNTRY=loc2;

WHERE SEP NE '' OR ACC NE '';

date=input(efdate2, anydtdte8.);

format date MMYYS.;

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
ACC ACCT
PPTYP PPTYPT
PPGROUP PPGROUPT
sallvl  SALLVLT
STEMAGG STEMAGGT
STEMOCC STEMOCCT
STEMTYP STEMTYPT
SEP SEPT
TOATYP TOATYPT
toa TOAT
worksch WORKSCHT
workstat WORKSTATT
agytyp AGYTYPT
EFDATE EFDATET
payplan payplant
WSTYP WSTYPT;


RUN;



DATA OPM_SEPARATIONS_ACCESSIONS;
SET SEP_ACC17;
ACC 		= ACC2;
SEP 		= SEP2; 
AGY 		= AGY2;
AGYSUB 		= AGYSUB2;
agelvl 		= AGELVL2;
edlvl 		= EDLVL2;
EDLVLTYP	= EDLVLTYP2;
EFDATE  	= EFDATE2;
loctyp 		= loctyp2;
LOC 		= LOC2;
loslvl 		= LOSLVL2;
occ 		= OCC2;
OCCFAM 		= OCCFAM2;
occtyp 		= occtyp2;
patco 		= PATCO2;
PPTYP		= PPTYP2;
PPGROUP		= PPGROUP2;
sallvl 		= SALLVL2;
STEMAGG		= STEMAGG2;
STEMOCC		= STEMOCC2;
STEMTYP		= STEMTYP2;
TOATYP 		= TOATYP2;
toa 		= TOA2;
worksch 	= WORKSCH2;
workstat 	= WORKSTAT2;
agytyp 		= AGYTYP2;
payplan 	= payplan2;
WSTYP		= WSTYP2;

DROP 
AGY2 LOC2
ACC2 SEP2
EFDATE2
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
PPTYP2 
PPGROUP2 
sallvl2  
STEMAGG2
STEMOCC2 
STEMTYP2 
TOATYP2 
toa2 
worksch2
workstat2
agytyp2 
payplan2 
WSTYP2; 

;
label 
	agysub = 'Sub-Agency'
	agy = 'Agency'
  	agytyp = 'Agency Type'
	loc = 'Location'
	agelvl = 'Age Level'
	edlvl = 'Education Level'
	gsegrd = 'GSE Grade'
	loslvl = 'LOS Level'
 	occ = 'Occupation'
 	sallvl = 'Salary Level'
 	stemocc = 'STEM Occupation'
 	toa = 'Type of Appt'
 	worksch = 'Work Schedule'
 	workstat = 'Work Status'
 	salary = 'Salary'
 	los = 'Length of Service'
	foreign_country = 'Foreign Country'
	LOCTYP = 'Location Type'
	occfam = 'Occupation Family'
	occtyp = 'Occupation Type'
	patco = 'Occupation Category'
	pptyp = 'Pay Plan Type'
	ppgroup = 'Pay Plan Group'
	stemagg = 'STEM Occupation Aggregate'
	toatyp = 'Type of Appointment Type'
	payplan = 'Pay Plan'
	wstyp = 'Work Schedule Type'
	ppgrd = 'Pay Plan and Grade'
	SEP = 'Separation Type'
	ACC = 'Accession Type'
	EFDATE = 'Effective Date'
	date = 'Effective Date'
;


run;


/*Deleting sep and acc datasets*/
proc delete library=work data = sep_acc1-sep_acc17; run;

/*  LOADING THE SEPARATIONS AND ACCESSIONS TABLE INTO MEMORY */
proc casutil ;
  /* need to drop a global scoped table */
  droptable incaslib="Public" casdata="OPM_SEPARATIONS_ACCESSIONS" quiet;
  /* now load the table, in this we use a SAS data set */
  load data=work.OPM_SEPARATIONS_ACCESSIONS outcaslib="Public" casout="OPM_SEPARATIONS_ACCESSIONS" promote;
quit;

data wfa.OPM_SEPARATIONS_ACCESSIONS;
set work.OPM_SEPARATIONS_ACCESSIONS;
run;
