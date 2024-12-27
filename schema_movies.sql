-- creating database name movies
create database movies;

-- use movies
use movies;

-- creating schema or table for movies databas
-- creating table movie basic data
create table movie_basic
(
title varchar(100) not null,
genre varchar(50) not null,
release_year int not null,
director varchar(50) not null,
studio varchar(50) not null,
critic_rating decimal(2,1) default 0
);

-- crearing table movie genres 
create table genre
(
id int primary key auto_increment,
genre varchar(20) not null
);

-- creating table movie director
create table director
(
id int primary key auto_increment,
dic_name varchar(40) not null
);

-- creating table movie studio
create table studio
(
id int primary key auto_increment,
studio_name varchar(30) not null,
city varchar(50) not null
);

-- creating table mobie title 
create table title
(
id int primary key auto_increment,
title varchar(100) not null,
genre_id int not null,
release_year int not null,
director_id int not null,
studio_id int not null,
foreign key(genre_id) references genre(id),
foreign key(director_id) references director(id),
foreign key(studio_id) references studio(id)
on update cascade
on delete cascade
);

-- creating table movie critics rating
create table critics_rating
(
id int primary key auto_increment,
title_id int not null,
critics_rating decimal(2,1) default 0,
foreign key(title_id) references title(id)
on update cascade 
on delete cascade
);

-- describing all tables schemas
describe movie_basic;
describe genre;
describe director;
describe studio;
describe title;
describe critics_rating;

-- see the data from table
select * from movie_basic;
select * from genre;
select * from director;
select * from studio;
select * from title;
select * from critics_rating;
