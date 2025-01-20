--Netflix project
drop table if exists netflix;
create table netflix
(
	show_id	varchar(7),
	type varchar(12),	
	title	varchar(150),
	director varchar(220),	
	casts	varchar(900),
	country	varchar(150),
	date_added	varchar(50),
	release_year	int,
	rating	varchar(10),
	duration	varchar(15),
	listed_in varchar(100),
	description varchar(250)
);


select* from netflix

select count(*)
as total_content 
from netflix


select distinct type
from netflix

--15 busniness problems

--1.count the number of movies and tv shows
select * from netflix


select 
	type,
	count(*) AS TOTAL_NO_CONTENT
from netflix
group by type

--2.FIND THE MOST COMMON RATING FOR MOVIES AND TV SHOWS

select * from netflix

SELECT TYPE,RATING,COUNT(*)
FROM NETFLIX

GROUP BY 1,2
ORDER BY COUNT(*) DESC


--3.LIST ALL MOVIES RELEASED IN A SPECIFIC YEAR
select * from netflix


SELECT title,release_year
FROM NETFLIX
WHERE RELEASE_YEAR=2021 AND TYPE ='Movie'


--4.find top 5 countries with the most content on netflix
select * from netflix

select 
	unnest(string_to_array(country,','))as new_country,
	count(show_id) as content_total
from netflix
group by new_country
order by count(show_id) desc
limit 5


--5.identify the longest movie

select 	
	DURATION 
from 
	netflix
where 
	type='Movie' AND
	DURATION IS NOT NULL
order by 
	duration 
DESC 
LIMIT 1

--6.FIND CONTENT ADDED IN LAST FIVE YEARS

SELECT *FROM NETFLIX
WHERE TO_DATE(DATE_ADDED,'MONTH DD,YYYY')>=CURRENT_DATE-INTERVAL'5 YEARS'


--7.FIND ALL MOVIES /TV SHOWS BY DIRECTOR 'RAJIV CHILAKA'

SELECT
	TITLE,
	director 
FROM 
	NETFLIX
WHERE 
	DIRECTOR ilike '%Rajiv Chilaka%'
	

--8.list all tv show with more than 5 seasons


select 
	TITLE, 
	SPLIT_PART(DURATION,' ',1) AS SEASON
from netflix 
where 
	type='TV Show' 
	AND
	SPLIT_PART(DURATION,' ',1)::NUMERIC>5


--9.COUNT NUMBER OF CONTENT ITEMS IN EACH GENRE

SELECT UNNEST(STRING_TO_ARRAY(LISTED_IN,','))AS GENRE ,
COUNT(SHOW_ID)
FROM NETFLIX
GROUP BY 1
ORDER BY 2 DESC


--10.FIND EACH YEAR AND THE AVERAGE NUMBERS OF CONTENT RELEASE BY INDIA ON NETFLIX.
--RETURN TOP 5 YEAR WITH HIGHEST AVG CONTENT RELEASE-


SELECT
	EXTRACT(YEAR FROM TO_DATE(DATE_ADDED,'MONTH DD,YYYY')) AS YEAR,
	COUNT(*)as yearly_count,
	count(*)::numeric/(select count(*) from netflix where country='India')::numeric * 100 as avg_content 
FROM NETFLIX
WHERE COUNTRY='India'
GROUP BY 1

--11.list all movies that are documentaries

select * from netflix
where listed_in ilike '%documentaries%'

--12.find all content without a director


select* from netflix where director is null

--13.find how many movies actor salman khan appraed in last 10 years

select * from netflix
where casts ilike '%salman khan%' and release_year>extract(year from current_date)-10

--14.find top 10 actors who appeared in the highest number of movies produced in india

select unnest(string_to_array(casts,','))as actor_name,count(*) TOTAL MOVIES
from netflix
where type='Movie'
and country ilike 'india'
group by 1
ORDER BY 2 DESC
LIMIT 10


--15.CATEGORIZE THE CONTENT BASED ON THE PRESENCE OF THE KEYWORD'KILL' AND 'VIOLENCE'
--IN THE DESCRIPTION FIELd.LABEL CONTENTS CONTAINING THERSE KEYWORDs AS BAD AND ALL OTHER CONTENT AS GOOD .
--COUNT HOW MANY ITEMS FALL INTO EACH CATEGORY


SELECT 

	case 
	when 
		description ilike '%kill%' or
		description ilike '%VIOLENCE%' THEN 'BAD_CONTENT'
		ELSE 'GOOD_CONTENT'
	END  as category,count(*)
FROM NETFLIX

group by category



