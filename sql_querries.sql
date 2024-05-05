/* Final Project - Music & Mental Health Survey results */

/* SQL Questions*/

-- Creating the database
create database music_mental_health;

use music_mental_health;

-- Creating a table music_mental_health with the same columns as given in the csv file.
DROP TABLE IF EXISTS music_mental_health;

CREATE TABLE `music_mental_health` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `age` int,
  `primary_streaming_service` text,
  `hours_per_day` float,
  `while_working` text,
  `instrumentalist` text,
  `composer` text,
  `fav_genre` text,
  `exploratory` text,
  `foreign_languages` text,
  `bpm` float,
  `freq_classical` text,
  `freq_country` text,
  `freq_edm` text,
  `freq_folk` text,
  `freq_gospel` text,
  `freq_hip_hop` text,
  `freq_jazz` text,
  `freq_k_pop` text,
  `freq_latin` text,
  `freq_lofi` text,
  `freq_metal` text,
  `freq_pop` text,
  `freq_r&b` text,
  `freq_rap` text,
  `freq_rock` text,
  `freq_video_game_music` text,
  `anxiety` float,
  `depression` float,
  `insomnia` float,
  `ocd` float,
  `music_effects` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* Importing the data from the csv file into the table. 
To not modify the original data, if you want you can create a copy of the csv file as well. 
Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk:*/
SHOW VARIABLES LIKE 'local_infile'; -- This query would show you the status of the variable ‘local_infile’. If it is off, use the next command, otherwise you should be good to go

SET GLOBAL local_infile = 1;

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.2/Uploads/survey_results_cleaned - copy.csv"
INTO TABLE music_mental_health
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(age, primary_streaming_service, hours_per_day, while_working, instrumentalist, composer, fav_genre, exploratory, foreign_languages, bpm, freq_classical, freq_country, freq_edm, 
freq_folk, freq_gospel, freq_hip_hop, freq_jazz, freq_k_pop, freq_latin, freq_lofi, freq_metal, freq_pop, `freq_r&b`, freq_rap, freq_rock, freq_video_game_music, anxiety, depression, 
insomnia, ocd, music_effects)
;

-- Checking the new table
select * from music_mental_health;

/* Querries */

/* 1. How many respondents does our dataset contain? */
select count(*) as respondents_count from music_mental_health;

/* 2. What is the average age of our respondents? */
select round(avg(age), 0) as avg_age from music_mental_health;

/* 2.1 ADDITIONAL: How old is the youngest respondent? */
select min(age) as min_age from music_mental_health;

/* 2.2  ADDITIONAL: How old is the oldest respondent? */
select max(age) as max_age from music_mental_health;

/* 3. How many of our respondents play instruments VS How many don't play an instrument? */
select 
   sum(case when instrumentalist = 'Yes' Then 1 Else 0 end) as count_instrumentalist,
   sum(case when instrumentalist = 'No' Then 1 Else 0 end) as count_non_instrumentalist
from music_mental_health;

/* 4. How many of our respondents compose VS How many don't compose? */
select 
   sum(case when composer = 'Yes' Then 1 Else 0 end) as count_composer,
   sum(case when composer = 'No' Then 1 Else 0 end) as count_non_composer
from music_mental_health;

/* 5. How many of our respondets explore new artists/genres VS How many don't explore? */
select 
   sum(case when exploratory = 'Yes' Then 1 Else 0 end) as count_explorer,
   sum(case when exploratory = 'No' Then 1 Else 0 end) as count_non_explorer
from music_mental_health;

/* 6. What is the average score of anxiety, depression, insomnia and OCD? */
select round(avg(anxiety), 0) as avg_anxiety_score, round(avg(depression), 0) as avg_depression_score,
		round(avg(insomnia), 0) as avg_insomnia_score, round(avg(ocd), 0) as avg_ocd_score
from music_mental_health;

/* 6.1 ADDITIONAL: What is the highest score for each mental health issue answered? */
select max(anxiety) as max_anxiety_score, max(depression) as max_depression_score,
		max(insomnia) as max_insomnia_score, max(ocd) as max_ocd_score
from music_mental_health;

/* 6.2 ADDITIONAL: What is the lowest score for each mental health issue answered? */
select min(anxiety) as min_anxiety_score, min(depression) as min_depression_score,
		min(insomnia) as min_insomnia_score, min(ocd) as min_ocd_score
from music_mental_health;

/* 7. How many respondents have severe anxiety (7-10), are highly depressed (7-10), often suffer from insomnia (7-10) and are higly affected by OCD (7-10)? 
Note: Include a column for each quantification.*/
select 
   sum(case when anxiety >= 7 and anxiety <= 10 Then 1 Else 0 end) as count_highly_anxious,
   sum(case when depression >= 7 and depression <= 10 Then 1 Else 0 end) as count_highly_depressed,
   sum(case when insomnia >= 7 and insomnia <= 10 Then 1 Else 0 end) as count_high_insomnia,
   sum(case when ocd >= 7 and ocd <= 10 Then 1 Else 0 end) as count_high_ocd
from music_mental_health;

/* 7.1 ADDITIONAL: How many respondents experienced all the mentioned mental health issue (>= 3)? */
select count(*) as count_affected_respondents from music_mental_health
where anxiety >= 3 and depression >= 3 and insomnia >= 3 and ocd >= 3;

/* 8. How many respondents are musicians (play an instrument or compose) and have severe anxiety (7-10) VS non musicians who have severe anxiety? */
select
	sum(case when (instrumentalist = 'Yes' or composer = 'Yes') and (anxiety >= 7 and anxiety <= 10) Then 1 Else 0 end) as count_anxious_musician,
	sum(case when (instrumentalist = 'No' or composer = 'No') and (anxiety >= 7 and anxiety <= 10) Then 1 Else 0 end) as count_anxious_non_musician
from music_mental_health;

/* 9. How many respondents are musicians (play an instrument or compose) and are higly depressed (7-10) VS non musicians who are highly depressed? */
select
	sum(case when (instrumentalist = 'Yes' or composer = 'Yes') and (depression >= 7 and depression <= 10) Then 1 Else 0 end) as count_depressed_musician,
	sum(case when (instrumentalist = 'No' or composer = 'No') and (depression >= 7 and depression <= 10) Then 1 Else 0 end) as count_depressed_non_musician
from music_mental_health;

/* 10. How many respondents are musicians (play an instrument or compose) suffer often from insomnia (7-10) VS non musicians who suffer often from insomnia? */
select
	sum(case when (instrumentalist = 'Yes' or composer = 'Yes') and (insomnia >= 7 and insomnia <= 10) Then 1 Else 0 end) as count_insomnia_musician,
	sum(case when (instrumentalist = 'No' or composer = 'No') and (insomnia >= 7 and insomnia <= 10) Then 1 Else 0 end) as count_insomnia_non_musician
from music_mental_health;

/* 11. How many respondents are musicians (play an instrument or compose) and are higly affected by OCD (7-10) VS non musicians who are higly affected by OCD? */
select
	sum(case when (instrumentalist = 'Yes' or composer = 'Yes') and (ocd >= 7 and ocd <= 10) Then 1 Else 0 end) as count_ocd_musician,
	sum(case when (instrumentalist = 'No' or composer = 'No') and (ocd >= 7 and ocd <= 10) Then 1 Else 0 end) as count_ocd_non_musician
from music_mental_health;

/* 12. How many respondents who explore new music have severe anxiety (7-10) VS non explorers who have severe anxiety? */
select
	sum(case when exploratory = 'Yes' and (anxiety >= 7 and anxiety <= 10) Then 1 Else 0 end) as count_anxious_explorer,
	sum(case when exploratory = 'No' and (anxiety >= 7 and anxiety <= 10) Then 1 Else 0 end) as count_anxious_non_explorer
from music_mental_health;

/* 13. How many respondents who explore new music are higly depressed (7-10) VS non explorers who are highly depressed? */
select
	sum(case when exploratory = 'Yes' and (depression >= 7 and depression <= 10) Then 1 Else 0 end) as count_depressed_explorer,
	sum(case when exploratory = 'No' and (depression >= 7 and depression <= 10) Then 1 Else 0 end) as count_depressed_non_explorer
from music_mental_health;

/* 14. How many respondents who explore new music suffer often from insomnia (7-10) VS non explorers who suffer often from insomnia? */
select
	sum(case when exploratory = 'Yes' and (insomnia >= 7 and insomnia <= 10) Then 1 Else 0 end) as count_insomnia_explorer,
	sum(case when exploratory = 'No' and (insomnia >= 7 and insomnia <= 10) Then 1 Else 0 end) as count_insomnia_non_explorer
from music_mental_health;

/* 15. How many respondents who explore new music are higly affected by OCD (7-10) VS non explorers who are higly affected by OCD? */
select
	sum(case when exploratory = 'Yes' and (ocd >= 7 and ocd <= 10) Then 1 Else 0 end) as count_ocd_explorer,
	sum(case when exploratory = 'No' and (ocd >= 7 and ocd <= 10) Then 1 Else 0 end) as count_ocd_non_explorer
from music_mental_health;

/* 16. Write a querry that includes: 
- How many respondents who play an instrument have answered that music has improve their mental health
- How many respondents who play an instrument have answered that music has no effects or worsen their mental health
- How many respondents that don't play an instrument have answered that music has improve their mental health
- How many respondents that don't play an instrument have answered that music has no effects or worsen their mental health */
select
	sum(case when instrumentalist = 'Yes' and music_effects like '%Improve%' Then 1 Else 0 end) as count_instrumentalist_improve,
    sum(case when instrumentalist = 'Yes' and (music_effects like '%No effect%' or music_effects like '%Worsen%') Then 1 Else 0 end) as count_instrumentalist_worsen,
    sum(case when instrumentalist = 'No' and music_effects like '%Improve%' Then 1 Else 0 end) as count_non_instrumentalist_improve,
    sum(case when instrumentalist = 'No' and (music_effects like '%No effect%' or music_effects like '%Worsen%') Then 1 Else 0 end) as count_non_instrumentalist_worsen
from music_mental_health;

/* 17. Write a querry that includes:
- How many respondents who compose have answered that music has improve their mental health
- How many respondents who compose have answered that music has no effects or worsen their mental health
- How many respondents that don't compose have answered that music has improve their mental health
- How many respondents that don't compose have answered that music has no effects or worsen their mental health */
select
	sum(case when composer = 'Yes' and music_effects like '%Improve%' Then 1 Else 0 end) as count_composer_improve,
    sum(case when composer = 'Yes' and (music_effects like '%No effect%' or music_effects like '%Worsen%') Then 1 Else 0 end) as count_composer_worsen,
    sum(case when composer = 'No' and music_effects like '%Improve%' Then 1 Else 0 end) as count_non_composer_improve,
    sum(case when composer = 'No' and (music_effects like '%No effect%' or music_effects like '%Worsen%') Then 1 Else 0 end) as count_non_composer_worsen
from music_mental_health;

/* 18. Write a querry that includes:
- How many respondents who explore new music have answered that music has improve their mental health
- How many respondents who explore new music have answered that music has no effects or worsen their mental health
- How many respondents that don't explore new music have answered that music has improve their mental health
- How many respondents that don't explore new music have answered that music has no effects or worsen their mental health */
select
	sum(case when exploratory = 'Yes' and music_effects like '%Improve%' Then 1 Else 0 end) as count_explorer_improve,
    sum(case when exploratory = 'Yes' and (music_effects like '%No effect%' or music_effects like '%Worsen%') Then 1 Else 0 end) as count_explorer_worsen,
    sum(case when exploratory = 'No' and music_effects like '%Improve%' Then 1 Else 0 end) as count_non_explorer_improve,
    sum(case when exploratory = 'No' and (music_effects like '%No effect%' or music_effects like '%Worsen%') Then 1 Else 0 end) as count_non_explorer_worsen
from music_mental_health;

/* 19. Which favorite music genre has the highest number of respondents who suffer from severe anxiety VS the lowest?*/

-- First step: count respondents per fav_genre that suffer from severe anxiety 
select fav_genre, count(*) as count_respondents_highly_anxious
from music_mental_health
where anxiety between 7 and 10
group by fav_genre
order by count_respondents_highly_anxious desc;

-- Second step: select only the first and last rows from the previous querry
with ranked_genres as (
  select
    fav_genre,
    count(*) as count_respondents_highly_anxious,
    rank() over (order by count(*) desc) as max_rank,
    rank() over (order by count(*) asc) as min_rank
  from music_mental_health
  where anxiety between 7 and 10
  group by fav_genre
)
select fav_genre, count_respondents_highly_anxious
from ranked_genres
where max_rank = 1 or min_rank = 1;

/* 20. Which favorite music genre has the highest number of respondents who are highly depressed VS the lowest?*/

-- First step: count respondents per fav_genre that are highly depressed
select fav_genre, count(*) as count_respondents_highly_depressed
from music_mental_health
where depression between 7 and 10
group by fav_genre
order by count_respondents_highly_depressed desc;

-- Second step: select only the first and last rows from the previous querry
with ranked_genres as (
  select
    fav_genre,
    count(*) as count_respondents_highly_depressed,
    rank() over (order by count(*) desc) as max_rank,
    rank() over (order by count(*) asc) as min_rank
  from music_mental_health
  where depression between 7 and 10
  group by fav_genre
)
select fav_genre, count_respondents_highly_depressed
from ranked_genres
where max_rank = 1 or min_rank = 1;

/* 21. Which favorite music genre has the highest number of respondents who suffer frequently from insomnia VS the lowest?*/

-- First step: count respondents per fav_genre who suffer frequently from insomnia
select fav_genre, count(*) as count_respondents_high_insomnia
from music_mental_health
where insomnia between 7 and 10
group by fav_genre
order by count_respondents_high_insomnia desc;

-- Second step: select only the first and last rows from the previous querry
with ranked_genres as (
  select
    fav_genre,
    count(*) as count_respondents_high_insomnia,
    rank() over (order by count(*) desc) as max_rank,
    rank() over (order by count(*) asc) as min_rank
  from music_mental_health
  where insomnia between 7 and 10
  group by fav_genre
)
select fav_genre, count_respondents_high_insomnia
from ranked_genres
where max_rank = 1 or min_rank = 1;


/* 22. Which favorite music genre has the highest number of respondents who suffer frequently from OCD VS the lowest?*/

-- First step: count respondents per fav_genre who suffer frequently from insomnia
select fav_genre, count(*) as count_respondents_high_ocd
from music_mental_health
where ocd between 7 and 10
group by fav_genre
order by count_respondents_high_ocd desc;

-- Second step: select only the first and last rows from the previous querry
with ranked_genres as (
  select
    fav_genre,
    count(*) as count_respondents_high_ocd,
    rank() over (order by count(*) desc) as max_rank,
    rank() over (order by count(*) asc) as min_rank
  from music_mental_health
  where ocd between 7 and 10
  group by fav_genre
)
select fav_genre, count_respondents_high_ocd
from ranked_genres
where max_rank = 1 or min_rank = 1;


/* 23. Which frequently (Very Frequently or Sometimes) listen to music genre has the highest number of respondents who suffer from severe anxiety VS the lowest?*/
    
-- First step: Convert to Row-wise Data
select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end) as count_anxious
from music_mental_health
union all
select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end) 
from music_mental_health
union all 
select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
from music_mental_health;

-- Second step: Find Max and Min
(select genre, count_anxious
from (
    select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end) as count_anxious
	from music_mental_health
	union all
	select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end) 
	from music_mental_health
	union all 
	select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
) as counts
order by count_anxious DESC
limit 1)
union all
(select genre, count_anxious
FROM (
    select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end) as count_anxious
	from music_mental_health
	union all
	select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end) 
	from music_mental_health
	union all 
	select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and anxiety between 7 and 10 then 1 else 0 end)
	from music_mental_health
) as counts
order by count_anxious ASC
limit 1);

/*24. Which frequently (Very Frequently or Sometimes) listen to music genre has the highest number of respondents who are highly depressed VS the lowest?*/

-- First step: Convert to Row-wise Data
select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end) as count_depressed
from music_mental_health
union all
select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end) 
from music_mental_health
union all 
select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
from music_mental_health;

-- Second step: Find Max and Min
(select genre, count_depressed
from (
    select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end) as count_depressed
	from music_mental_health
	union all
	select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end) 
	from music_mental_health
	union all 
	select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
) as counts
order by count_depressed DESC
limit 1)
union all
(select genre, count_depressed
FROM (
    select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end) as count_depressed
	from music_mental_health
	union all
	select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end) 
	from music_mental_health
	union all 
	select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and depression between 7 and 10 then 1 else 0 end)
	from music_mental_health
) as counts
order by count_depressed ASC
limit 1);

/* 25. Which frequently (Very Frequently or Sometimes) listen to music genre has the highest number of respondents who suffer frequently from insomnia VS the lowest?*/

-- First step: Convert to Row-wise Data
select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end) as count_insomnia
from music_mental_health
union all
select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end) 
from music_mental_health
union all 
select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
from music_mental_health;

-- Second step: Find Max and Min
(select genre, count_insomnia
from (
    select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end) as count_insomnia
	from music_mental_health
	union all
	select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end) 
	from music_mental_health
	union all 
	select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
) as counts
order by count_insomnia DESC
limit 1)
union all
(select genre, count_insomnia
FROM (
    select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end) as count_insomnia
	from music_mental_health
	union all
	select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end) 
	from music_mental_health
	union all 
	select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and insomnia between 7 and 10 then 1 else 0 end)
	from music_mental_health
) as counts
order by count_insomnia ASC
limit 1);

/* 26. Which Which frequently (Very Frequently or Sometimes) listen to music genre has the highest number of respondents who suffer frequently from OCD VS the lowest?*/

-- First step: Convert to Row-wise Data
select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end) as count_ocd
from music_mental_health
union all
select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end) 
from music_mental_health
union all 
select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all
select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health
union all 
select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
from music_mental_health;

-- Second step: Find Max and Min
(select genre, count_ocd
from (
    select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end) as count_ocd
	from music_mental_health
	union all
	select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end) 
	from music_mental_health
	union all 
	select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
) as counts
order by count_ocd DESC
limit 1)
union all
(select genre, count_ocd
FROM (
    select 'Classical' as genre, sum(case when freq_classical like "%Very Frequently%" or freq_classical like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end) as count_ocd
	from music_mental_health
	union all
	select 'Country' as genre, sum(case when freq_country like "%Very Frequently%" or freq_country like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'EDM' as genre, sum(case when freq_edm like "%Very Frequently%" or freq_edm like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end) 
	from music_mental_health
	union all 
	select 'Folk', sum(case when freq_folk like "%Very Frequently%" or freq_folk like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select  'Gospel', sum(case when freq_gospel like "%Very Frequently%" or freq_gospel like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Hip-Hop', sum(case when freq_hip_hop like "%Very Frequently%" or freq_hip_hop like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Jazz', sum(case when freq_jazz like "%Very Frequently%" or freq_jazz like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'K-Pop', sum(case when freq_k_pop like "%Very Frequently%" or freq_k_pop like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Latin', sum(case when freq_latin like "%Very Frequently%" or freq_latin like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Lofi', sum(case when freq_lofi like "%Very Frequently%" or freq_lofi like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Metal', sum(case when freq_metal like "%Very Frequently%" or freq_metal like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Pop', sum(case when freq_pop like "%Very Frequently%" or freq_pop like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'R&B', sum(case when `freq_r&b` like "%Very Frequently%" or `freq_r&b` like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rap', sum(case when freq_rap like "%Very Frequently%" or freq_rap like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all
	select 'Rock', sum(case when freq_rock like "%Very Frequently%" or freq_rock like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
	union all 
	select 'Video Game Music', sum(case when freq_video_game_music like "%Very Frequently%" or freq_video_game_music like "%Sometimes%" and ocd between 7 and 10 then 1 else 0 end)
	from music_mental_health
) as counts
order by count_ocd ASC
limit 1);