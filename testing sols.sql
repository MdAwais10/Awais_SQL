create database tests;
use tests;

create table movies 
(
mov_id int not null primary key,
title varchar(100),
genre varchar(30)
);

create table ratings
(
mov_id int not null,
ratings int not null
);



insert into movies values (1,'khiladi','action');
insert into movies values (2,'hera pheri','comedy');
insert into movies values (3,'dhamaal','comedy');
insert into movies values (4,'inception','scifi');
insert into movies values (5,'da vinci code','thriller');


select * from movies;


insert into ratings values (1,1);
insert into ratings values (1,1);
insert into ratings values (1,2);

insert into ratings values (2,3);
insert into ratings values (2,4);
insert into ratings values (2,5);
insert into ratings values (2,5);
insert into ratings values (2,5);

insert into ratings values (3,1);
insert into ratings values (3,2);
insert into ratings values (3,1);
insert into ratings values (3,2);
insert into ratings values (3,1);
insert into ratings values (3,3);

insert into ratings values (4,4);
insert into ratings values (4,4);
insert into ratings values (4,4);
insert into ratings values (4,4);
insert into ratings values (4,4);

insert into ratings values (5,5);
insert into ratings values (5,4);
insert into ratings values (5,5);
insert into ratings values (5,4);
insert into ratings values (5,5);
insert into ratings values (5,4);



select * from ratings;

select * from
movies as mov
join ratings as rt
where mov.mov_id = rt.mov_id;

select mov.mov_id,
mov.title,
mov.genre,
avg(rt.ratings) over (partition by mov.title) as avg_movie_rating
from
movies as mov
join ratings as rt
on mov.mov_id = rt.mov_id
order by genre asc;





select * from movies;
select * from ratings;


-- display average ratings per movies
-- this was my method which is wrong as the ouput showed multiple entries from each movies
select 
mv.mov_id, 
mv.title, 
mv.genre, 
avg(rt.ratings) as avg_movie_rating
from movies as mv
inner join ratings as rt
where mv.mov_id = rt.mov_id
group by mv.mov_id
;

-- display average ratings per movies
-- this is correct as it shows each movie once with average 
SELECT m.mov_id, m.title, m.genre, AVG(r.ratings) AS average_rating
FROM movies m
JOIN ratings r ON m.mov_id = r.mov_id
GROUP BY m.mov_id;


SELECT m.title, AVG(r.ratings) AS average_rating
FROM movies m
JOIN ratings r ON m.mov_id = r.mov_id
GROUP BY m.title;

-- display as star ratings
SELECT m.title, 
       ROUND(AVG(r.ratings), 1) AS average_rating, 
       REPEAT('⭐', FLOOR(AVG(r.ratings))) AS star_rating
FROM movies m
JOIN ratings r ON m.mov_id = r.mov_id
GROUP BY m.title;


-- my modifications
SELECT m.mov_id, m.title, m.genre, REPEAT('⭐', FLOOR(AVG(r.ratings))) AS star_rating
FROM movies m
JOIN ratings r ON m.mov_id = r.mov_id
GROUP BY m.mov_id;


-- gpt code for sorting avg of ratings and sorting in ascending order of genre
SELECT 
    m.title, 
    m.genre, 
    AVG(r.ratings) AS average_rating
FROM movies m
JOIN ratings r ON m.mov_id = r.mov_id
GROUP BY m.title, m.genre
ORDER BY m.genre ASC;

-- my modifications
SELECT 
    m.mov_id,
    m.title,
    m.genre, 
    repeat ('*',floor(AVG(r.ratings))) AS average_rating
FROM movies m
JOIN ratings r ON m.mov_id = r.mov_id
GROUP BY m.mov_id, m.genre
ORDER BY m.genre ASC;