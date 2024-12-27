use movies;

select * from critics_rating;

select id, if(critics_rating > 6, "Good", "Bad") as "Score" from critics_rating; 

select id, 
case
when critics_rating > 8 then "Good"
when critics_rating > 6 then "decent"
else "Bad"
end as Score from critics_rating;

use movies;

-- Filter movies by score
create view vwmoviesscore
as
select
t.title as 'Title', 
case
    when t.release_year > 2000 then "21st Century"
    else "20th Century"
end as 'Released',
d.dic_name as 'Direcor', cr.critics_rating,
case
    when cr.critics_rating >=9 then 'Amazing'
    when cr.critics_rating >7 and cr.critics_rating <9 then 'Good'
    when cr.critics_rating >5 and cr.critics_rating <=7 then 'Decent'
    else 'Bad'
end as 'Review'
from title t 
join director d on t.director_id = d.id
join critics_rating cr on t.id = cr.title_id
order by 1 desc;

select * from vwmoviesscore;
-- Challenge to fix the mistakes
-- add rence movies 

insert into movie_basic values
('Run for the Forest', 'Drama', 1946, 'Rence Pera', 'Lionel Brownstone', 7.3),
('Luck of the Night', 'Drama', 1951, 'Rence Pera', 'Lionel Brownstone', 6.8),
('Invader Glory', 'Adventure', 1953, 'Rence Pera', 'Lionel Brownstone', 5.5);

-- Change genre 'sci-fi' to 'sf' for all the falstead group films
select * from movie_basic where studio like "Falstead Group";

-- If you getting error that you sql is on safe mode. This below code help to disable the safe mode.
set sql_safe_updates=0;

update movie_basic 
set genre= "sf"
where genre="sci-fi"
and studio like "Falstead Group";

-- This below code help you to enable the safe mode.alter
set sql_safe_updates=1;

-- Remove all the flims Garry Scott did for Lionel Brownstone as those were lost
select * from movie_basic where director='Garry Scott' and studio='Lionel Brownstone';

delete 
from movie_basic
where director='Garry Scott' and studio='Lionel Brownstone';

-- find the best film
select t.title, d.dic_name, cr.critics_rating, p.filename from title t
join director d on t.director_id= d.id
join critics_rating cr on t.id= cr.title_id
join posters p on t.id= p.title_id
order by critics_rating desc
limit 10;

-- Showing 2nd highest Release_year
select max(release_year) from title 
where release_year not in(select max(release_year) from title);

select * from title where title like "s%";
select * from critics_rating;

-- Latest movie by which director.
select d.dic_name as "Director Name", title as "Movies Name", release_year as "Release" from director d 
left join title t on d.id= t.director_id 
order by release_year desc limit 1;

-- create procedure to filter movies by review
drop procedure prfilter;
delimiter &&
create procedure prfilter(review char(4))
begin
select @review=Review from vwmoviesscore where Review=review;
select @title:=title from vwmoviesscore where Review=review;
select @rel:=Released from vwmoviesscore where Review=review;
select @dirc:=Direcor from vwmoviesscore where Review=review;
select @critics:=critics_rating from vwmoviesscore where Review=review;
if (@critics >= 5) then
select review as 'Review', @title as 'Movie Title', @rel as 'Released', @dirc as 'Movie Director',
@critics as 'Rating', 'High';
else
select review as 'Review', @title as 'Movie Title', @rel as 'Released', @dirc as 'Movie Director',
@critics as 'Rating', 'Low';
end if; 
end &&
delimiter ;

call prfilter('good')

select * from vwmoviesscore;
