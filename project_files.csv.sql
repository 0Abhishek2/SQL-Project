create database myprojects;
use myprojects;
select * from user_submissions;

-- Q.1 List all distinct users and their stats (return user_name, total_submissions, points earned)

select 
username,
count(id) as total_submissions,
sum(points) as points_earned
from user_submissions
group by username
order by username, total_submissions desc;




-- Q.2 Calculate the daily average points for each user.
-- each day
-- each user and their daily avg points

select * from 
user_submissions;

SELECT  
    DATE(submitted_at) AS day,  
    username,  
    COUNT(id) AS total_submissions,  
    sum(points) as points_earned,  
    avg(points) as daily_avg_points  
from user_submissions  
group by day, username  
order by day DESC, total_submissions DESC;

-- Q.3 Find the top 3 users with the most positive submissions for each day.
-- each day 
-- most correct subnissions

select *  from user_submissions;

 select day, username, correct_submissions  
from (
    select  
        date(submitted_at) as day,  
        username,  
        sum(case when points > 0 then 1 else 0 end) as correct_submissions  
    from user_submissions  
    group by day, username  
    order by day DESC, correct_submissions desc
    limit 3  -- gets the top 3 
) as top_users;

-- Q.4 Find the top 5 users with the highest number of incorrect submissions.

select username, 
sum(case when points <= 0 then 1 else 0 end) as incorrect_submissions
 from user_submissions
 group by username
 order by incorrect_submissions desc
 limit 5;
 
 -- Q.5 Find the top 10 performers for each week.

with weeklyRanked as (
select 
week(submitted_at) as week_number,
username,
sum(points) as total_points,
dense_rank() over (partition by week (submitted_at)
order by sum(points) desc) as rank_position
from user_submissions
group by week_number , username
)
select week_number , username , total_points
from weeklyRanked 
where rank_position <=10
order by week_number desc, total_points desc;

 