/****************************************/
/* Example of using JSON libname engine */
/* for discovery, then with a JSON map  */
/****************************************/

filename usa temp;

/* Calling Historic JOA API empoint */
proc http 
 url="https://data.usajobs.gov/api/historicjoa"
 method= "GET"
 out=usa;
run;
 

/* Assign a JSON library to the HTTP response */
libname jobs JSON fileref=usa;

/* examine resulting tables/structure */
proc datasets lib=jobs; quit;
proc print data=jobs.alldata(obs=50); run;


/*Merging all of the datasets together to create master past USAJOBs announcements dataset*/
proc sql;
	create table past_announcements as
		select distinct a.*
		, substr(a.positionOpenDate,1,10) as open_date
		, substr(a.positionCloseDate,1,10) as close_date
		, b.hiringPath
		, c.series
		, d.positionLocationCity
		, d.positionLocationState
		, d.positionLocationCountry
	from jobs.data as a
		left join jobs.data_hiringpaths as b
		on a.ordinal_data = b.ordinal_data 
			left join jobs.data_jobcategories as c
			on a.ordinal_data = c.ordinal_data
				left join jobs.data_positionlocations as d
				on a.ordinal_data = d.ordinal_data
;
quit;


data USAJOBS_announcements;
set past_announcements;
/*converting dates from character to numeric and reformatting*/
position_opendate = input(open_date, yymmdd10.);
position_closedate = input(close_date, yymmdd10.);
format position_opendate position_closedate mmddyy10.;
position_openyear=(year(position_opendate));
position_closeyear=(year(position_closedate));
posting_open_days = position_closedate-position_opendate;

/*changing case and variable names for some variables to match
 other OPM data*/
agy=upcase(hiringdepartmentname);
agy_sub=upcase(hiringagencyname);
state=upcase(positionlocationstate);
city=upcase(positionlocationcity);
positiontitle = upcase(positiontitle);

drop open_date positionopendate close_date positionclosedate 
hiringdepartmentname hiringagencyname positionlocationstate
positionlocationcity
;
run;

/* proc casutil; */
/* load data=work.past_announcements1 casout="past_announcements"  */
/* outcaslib='Public' PROMOTE; */
/* quit; */

/*  LOADING THE USAJobs Announcements TABLE INTO MEMORY */
proc casutil ;
  /* need to drop a global scoped table */
  droptable incaslib="Public" casdata="USAJOBS_announcements" quiet;
  /* now load the table, in this we use a SAS data set */
  load data=work.USAJOBS_announcements outcaslib="Public" casout="USAJOBS_announcements" promote;
quit;

data wfa.USAJOBS_announcements;
set work.USAJOBS_announcements;
run;


	
