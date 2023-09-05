****  SAS Program to Read in Census data for Workforce Analytics demo;
**** The source data and the bulk of this SAS program come from the following location:

https://www2.census.gov/programs-surveys/popest/datasets/
-> 2020-2021/	
-> counties/ 
-> asrh/
https://www2.census.gov/programs-surveys/popest/datasets/2020-2021/counties/asrh/

;
/*Methodology -> https://www2.census.gov/programs-surveys/popest/technical-documentation/file-layouts/2010-2020/cc-est2020-alldata6.pdf */

cas casauto sessopts=(caslib=public timeout=1800 locale="en_US");
caslib _ALL_ assign;

/*Import CSV files*/
filename census temp;
proc http
 url="https://www2.census.gov/programs-surveys/popest/datasets/2020-2021/counties/asrh/cc-est2021-all.csv"
 method="GET"
 out=census;
run;

/* Tell SAS to allow "nonstandard" names */
options validvarname=any;

/*Importing Census Data*/
    data WORK.CENSUS    ;
    %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
    infile census delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
       informat SUMLEV best32. ;
       informat STATE best32. ;
       informat COUNTY best32. ;
       informat STNAME $25. ;
       informat CTYNAME $25. ;
       informat YEAR best32. ;
       informat AGEGRP best32. ;
       informat TOT_POP best32. ;
       informat TOT_MALE best32. ;
       informat TOT_FEMALE best32. ;
       informat WA_MALE best32. ;
       informat WA_FEMALE best32. ;
       informat BA_MALE best32. ;
       informat BA_FEMALE best32. ;
       informat IA_MALE best32. ;
       informat IA_FEMALE best32. ;
       informat AA_MALE best32. ;
       informat AA_FEMALE best32. ;
       informat NA_MALE best32. ;
       informat NA_FEMALE best32. ;
       informat TOM_MALE best32. ;
       informat TOM_FEMALE best32. ;
       informat WAC_MALE best32. ;
       informat WAC_FEMALE best32. ;
       informat BAC_MALE best32. ;
       informat BAC_FEMALE best32. ;
       informat IAC_MALE best32. ;
       informat IAC_FEMALE best32. ;
       informat AAC_MALE best32. ;
       informat AAC_FEMALE best32. ;
       informat NAC_MALE best32. ;
       informat NAC_FEMALE best32. ;
       informat NH_MALE best32. ;
       informat NH_FEMALE best32. ;
       informat NHWA_MALE best32. ;
       informat NHWA_FEMALE best32. ;
       informat NHBA_MALE best32. ;
       informat NHBA_FEMALE best32. ;
       informat NHIA_MALE best32. ;
       informat NHIA_FEMALE best32. ;
       informat NHAA_MALE best32. ;
       informat NHAA_FEMALE best32. ;
       informat NHNA_MALE best32. ;
       informat NHNA_FEMALE best32. ;
       informat NHTOM_MALE best32. ;
       informat NHTOM_FEMALE best32. ;
       informat NHWAC_MALE best32. ;
       informat NHWAC_FEMALE best32. ;
       informat NHBAC_MALE best32. ;
       informat NHBAC_FEMALE best32. ;
       informat NHIAC_MALE best32. ;
       informat NHIAC_FEMALE best32. ;
       informat NHAAC_MALE best32. ;
       informat NHAAC_FEMALE best32. ;
       informat NHNAC_MALE best32. ;
       informat NHNAC_FEMALE best32. ;
       informat H_MALE best32. ;
       informat H_FEMALE best32. ;
       informat HWA_MALE best32. ;
       informat HWA_FEMALE best32. ;
       informat HBA_MALE best32. ;
       informat HBA_FEMALE best32. ;
       informat HIA_MALE best32. ;
       informat HIA_FEMALE best32. ;
       informat HAA_MALE best32. ;
       informat HAA_FEMALE best32. ;
       informat HNA_MALE best32. ;
       informat HNA_FEMALE best32. ;
       informat HTOM_MALE best32. ;
       informat HTOM_FEMALE best32. ;
       informat HWAC_MALE best32. ;
       informat HWAC_FEMALE best32. ;
       informat HBAC_MALE best32. ;
       informat HBAC_FEMALE best32. ;
       informat HIAC_MALE best32. ;
       informat HIAC_FEMALE best32. ;
       informat HAAC_MALE best32. ;
       informat HAAC_FEMALE best32. ;
       informat HNAC_MALE best32. ;
       informat HNAC_FEMALE best32. ;
       format SUMLEV best12. ;
       format STATE best12. ;
       format COUNTY best12. ;
       format STNAME $25. ;
       format CTYNAME $25. ;
       format YEAR best12. ;
       format AGEGRP best12. ;
       format TOT_POP best12. ;
       format TOT_MALE best12. ;
       format TOT_FEMALE best12. ;
       format WA_MALE best12. ;
       format WA_FEMALE best12. ;
       format BA_MALE best12. ;
       format BA_FEMALE best12. ;
       format IA_MALE best12. ;
       format IA_FEMALE best12. ;
       format AA_MALE best12. ;
       format AA_FEMALE best12. ;
       format NA_MALE best12. ;
       format NA_FEMALE best12. ;
       format TOM_MALE best12. ;
       format TOM_FEMALE best12. ;
       format WAC_MALE best12. ;
       format WAC_FEMALE best12. ;
       format BAC_MALE best12. ;
       format BAC_FEMALE best12. ;
       format IAC_MALE best12. ;
       format IAC_FEMALE best12. ;
       format AAC_MALE best12. ;
       format AAC_FEMALE best12. ;
       format NAC_MALE best12. ;
       format NAC_FEMALE best12. ;
       format NH_MALE best12. ;
       format NH_FEMALE best12. ;
       format NHWA_MALE best12. ;
       format NHWA_FEMALE best12. ;
       format NHBA_MALE best12. ;
       format NHBA_FEMALE best12. ;
       format NHIA_MALE best12. ;
       format NHIA_FEMALE best12. ;
       format NHAA_MALE best12. ;
       format NHAA_FEMALE best12. ;
       format NHNA_MALE best12. ;
       format NHNA_FEMALE best12. ;
       format NHTOM_MALE best12. ;
       format NHTOM_FEMALE best12. ;
       format NHWAC_MALE best12. ;
       format NHWAC_FEMALE best12. ;
       format NHBAC_MALE best12. ;
       format NHBAC_FEMALE best12. ;
       format NHIAC_MALE best12. ;
       format NHIAC_FEMALE best12. ;
       format NHAAC_MALE best12. ;
       format NHAAC_FEMALE best12. ;
       format NHNAC_MALE best12. ;
       format NHNAC_FEMALE best12. ;
       format H_MALE best12. ;
       format H_FEMALE best12. ;
       format HWA_MALE best12. ;
       format HWA_FEMALE best12. ;
       format HBA_MALE best12. ;
       format HBA_FEMALE best12. ;
       format HIA_MALE best12. ;
       format HIA_FEMALE best12. ;
       format HAA_MALE best12. ;
       format HAA_FEMALE best12. ;
       format HNA_MALE best12. ;
       format HNA_FEMALE best12. ;
       format HTOM_MALE best12. ;
       format HTOM_FEMALE best12. ;
       format HWAC_MALE best12. ;
       format HWAC_FEMALE best12. ;
       format HBAC_MALE best12. ;
       format HBAC_FEMALE best12. ;
       format HIAC_MALE best12. ;
       format HIAC_FEMALE best12. ;
       format HAAC_MALE best12. ;
       format HAAC_FEMALE best12. ;
       format HNAC_MALE best12. ;
       format HNAC_FEMALE best12. ;
    input
                SUMLEV
                STATE
                COUNTY
                STNAME  $
                CTYNAME  $
                YEAR
                AGEGRP
                TOT_POP
                TOT_MALE
                TOT_FEMALE
                WA_MALE
                WA_FEMALE
                BA_MALE
                BA_FEMALE
                IA_MALE
                IA_FEMALE
                AA_MALE
                AA_FEMALE
                NA_MALE
                NA_FEMALE
                TOM_MALE
                TOM_FEMALE
                WAC_MALE
                WAC_FEMALE
                BAC_MALE
                BAC_FEMALE
                IAC_MALE
                IAC_FEMALE
                AAC_MALE
                AAC_FEMALE
                NAC_MALE
                NAC_FEMALE
                NH_MALE
                NH_FEMALE
                NHWA_MALE
                NHWA_FEMALE
                NHBA_MALE
                NHBA_FEMALE
                NHIA_MALE
                NHIA_FEMALE
                NHAA_MALE
                NHAA_FEMALE
                NHNA_MALE
                NHNA_FEMALE
                NHTOM_MALE
                NHTOM_FEMALE
                NHWAC_MALE
                NHWAC_FEMALE
                NHBAC_MALE
                NHBAC_FEMALE
                NHIAC_MALE
                NHIAC_FEMALE
                NHAAC_MALE
                NHAAC_FEMALE
                NHNAC_MALE
                NHNAC_FEMALE
                H_MALE
                H_FEMALE
                HWA_MALE
                HWA_FEMALE
                HBA_MALE
                HBA_FEMALE
                HIA_MALE
                HIA_FEMALE
                HAA_MALE
                HAA_FEMALE
                HNA_MALE
                HNA_FEMALE
                HTOM_MALE
                HTOM_FEMALE
                HWAC_MALE
                HWAC_FEMALE
                HBAC_MALE
                HBAC_FEMALE
                HIAC_MALE
                HIAC_FEMALE
                HAAC_MALE
                HAAC_FEMALE
                HNAC_MALE
                HNAC_FEMALE
    ;
    if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */

    run;

/*Extracting the counts for the population totals*/
data total_population;
set census;

	if year = 1 then pop_year = '4/1/2010 population estimates base';
		else if year = 2 then pop_year = '7/1/2020 population estimates base';
		else if year = 3 then pop_year = '7/1/2021 population estimate';


/*matching with OPM age level categories*/
	if agegrp = 1 or agegrp =2 or agegrp =3 or agegrp =4 then agelvl = 'Less than 20';
		else if agegrp = 5 then agelvl = '20-24';
		else if agegrp = 6 then agelvl = '25-29';
		else if agegrp = 7 then agelvl = '30-34';
		else if agegrp = 8 then agelvl = '35-39';
		else if agegrp = 9 then agelvl = '40-44';
		else if agegrp = 10 then agelvl = '45-49';
		else if agegrp = 11 then agelvl = '50-54';
		else if agegrp = 12 then agelvl = '55-59';
		else if agegrp = 13 then agelvl = '60-64';
		else if agegrp = 14 or agegrp = 15 or agegrp = 16 or agegrp = 17 or agegrp = 18 then agelvl = '65 or more';
		else if agegrp = . then agelvl = 'Unspecified';

location = upcase(stname);

where year = 3 and agegrp ge 5;
run;

/*CALCULATING TOTALS BY STATE AND RACE -  WILL BE MERGED WITH EMPLOEYMENT DATA*/

proc sql;
	create table total_pop_BY_STATE as
		select distinct location as state
			, pop_year
			, sum(tot_pop)    as total_population
			, sum(tot_male)   as total_male
			, sum(tot_female) as total_female
			, sum(ba_male) 	  as total_black_male
			, sum(ba_female)  as total_black_female
			, sum(wa_male)    as total_white_male
			, sum(wa_female)  as total_white_female
			, sum(ia_male)    as total_aian_male
			, sum(ia_female)  as total_aian_female
			, sum(aa_male)    as total_asian_male
			, sum(aa_female)  as total_asian_female
			, sum(na_male)    as total_nhopi_male
			, sum(na_female)  as total_nhopi_female
			, sum(tom_male)   as total_2ormore_male
			, sum(tom_female) as total_2ormore_female
			, sum(H_male)     as total_HISP_male
			, sum(H_female)   as total_HISP_female

			/*CALCULATING TOTAL FOR EACH RACE, REGARLESS OF GENDER*/

			, CALCULATED TOTAL_BLACK_MALE+CALCULATED TOTAL_BLACK_FEMALE as TOTAL_BLACK
			, CALCULATED TOTAL_WHITE_MALE+CALCULATED TOTAL_WHITE_FEMALE as TOTAL_WHITE
			, CALCULATED TOTAL_AIAN_MALE+CALCULATED TOTAL_AIAN_FEMALE as TOTAL_AIAN
			, CALCULATED TOTAL_ASIAN_MALE+CALCULATED TOTAL_ASIAN_FEMALE as TOTAL_ASIAN
			, CALCULATED TOTAL_NHOPI_MALE+CALCULATED TOTAL_NHOPI_FEMALE as TOTAL_NHOPI
			, CALCULATED TOTAL_2ORMORE_MALE+CALCULATED TOTAL_2ORMORE_FEMALE as TOTAL_2ORMORE
			, CALCULATED TOTAL_HISP_MALE+CALCULATED TOTAL_HISP_FEMALE as TOTAL_HISP

			/*CALCULATING PROPORTIONS FOR EACH GENDER/RACE*/

			,  CALCULATED TOTAL_MALE/ CALCULATED TOTAL_POPULATION as census_male_pct
			,  CALCULATED TOTAL_FEMALE/CALCULATED TOTAL_POPULATION as census_female_pct
/*			,  CALCULATED TOTAL_MALE/CALCULATED TOTAL_FEMALE as male2female_ratio*/
			, (CALCULATED TOTAL_BLACK_MALE+CALCULATED TOTAL_BLACK_FEMALE)/CALCULATED TOTAL_POPULATION as census_black_pct
			, (CALCULATED TOTAL_WHITE_MALE+CALCULATED TOTAL_WHITE_FEMALE)/CALCULATED TOTAL_POPULATION as census_white_pct
			, (CALCULATED TOTAL_AIAN_MALE+CALCULATED TOTAL_AIAN_FEMALE)/CALCULATED TOTAL_POPULATION as census_aian_pct
			, (CALCULATED TOTAL_ASIAN_MALE+CALCULATED TOTAL_ASIAN_FEMALE)/CALCULATED TOTAL_POPULATION as census_asian_pct
			, (CALCULATED TOTAL_NHOPI_MALE+CALCULATED TOTAL_NHOPI_FEMALE)/CALCULATED TOTAL_POPULATION as census_nhopi_pct
			, (CALCULATED TOTAL_2ORMORE_MALE+CALCULATED TOTAL_2ORMORE_FEMALE)/CALCULATED TOTAL_POPULATION as census_tom_pct
			, (CALCULATED TOTAL_HISP_MALE+CALCULATED TOTAL_HISP_FEMALE)/CALCULATED TOTAL_POPULATION as census_HISP_pct

	from total_population
	group by stname
	;
quit;

