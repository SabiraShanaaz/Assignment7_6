DEFINE myfilter(relvar,colvar) returns x{

$x = filter $relvar by $colvar > 45;

};

a = LOAD '/home/acadgild/Desktop/data/olympix_data.csv' USING PigStorage(',') as (name:chararray, age:int, country:chararray, year:chararray,
c_date:chararray, sport:chararray, gold:int, silver:int, bronze:int, total:int);

x1 = myfilter(a,age);
dump x1;

a_filter1 = FILTER a by sport =='Archery';
athletes_grp_country = GROUP a_filter1 by country;
medal_sum = FOREACH athletes_grp_country GENERATE group AS country, SUM(a_filter1.total) as medal_count;
DUMP medal_sum;

a_filter = FILTER a by country == 'India';
grp = GROUP a_filter by year;
total_medals = FOREACH grp GENERATE group AS year, SUM(a_filter.total) as total_medal;
dump total_medals;
