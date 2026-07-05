
create database netflix_analysis

create table netflix_analysis
(
release_date date,
title varchar(200),
popularity decimal (10,5),
vote_count int,
vote_average decimal (10,5),
genre varchar(50)
)
--Imported data

select * from netflix_analysis

--Handle missing values

SELECT * FROM netflix_analysis
WHERE release_date IS NULL or genre is null

--Update missing values

update netflix_analysis
set popularity = 0
where popularity is null

update netflix_analysis
set vote_count = 0
where vote_count is null

update netflix_analysis
set vote_average = 0
where vote_average is null

update netflix_analysis
set genre = 'unknown'
where genre is null

--Update realese_date into release_year

SELECT 
    release_date,
    EXTRACT(YEAR FROM release_date) AS release_year
FROM netflix_analysis

--Adding new column for relase_year.

ALTER TABLE netflix_analysis ADD COLUMN release_year INT

UPDATE netflix_analysis
SET release_year = EXTRACT(YEAR FROM release_date)

--Checking Table

select * from netflix_analysis

--drop column release_date

ALTER TABLE netflix_analysis 
DROP COLUMN release_date

--Checking Table

select * from netflix_analysis

SELECT release_year, title, popularity, vote_count, vote_average, genre
FROM netflix_analysis;

 --20 Business Insights Questions

 --1. Which genres are trending in years 2023?
 
 SELECT genre, COUNT(*) AS total_movies
FROM netflix_analysis
WHERE release_year >= 2023
GROUP BY genre
ORDER BY total_movies DESC

--2. Which year had the highest number of releases?

SELECT release_year, COUNT(*) AS total_releases
FROM netflix_analysis
GROUP BY release_year
ORDER BY total_releases DESC
LIMIT 1

--3. Which movies are blockbusters (popularity > 90) but low-rated (vote_average < 6)?

SELECT title, popularity, vote_average
FROM netflix_analysis
WHERE popularity > 90 AND vote_average < 6

--4. Which genres have the highest average rating?

SELECT genre, AVG(vote_average) AS avg_rating
FROM netflix_analysis
GROUP BY genre
ORDER BY avg_rating DESC

--5. Which genres drive the most audience engagement (vote_count)?

SELECT genre, SUM(vote_count) AS total_votes
FROM netflix_analysis
GROUP BY genre
ORDER BY total_votes DESC

--6. What’s the year-over-year growth in content production?

SELECT release_year, COUNT(*) AS total_movies
FROM netflix_analysis
GROUP BY release_year
ORDER BY release_year

--7. Which movies had high ratings but low popularity?

SELECT title, vote_average, popularity
FROM netflix_analysis
WHERE vote_average > 8 AND popularity < 40

--8. Which genres dominate in vote_count (audience engagement)?

SELECT genre, AVG(vote_count) AS avg_votes
FROM netflix_analysis
GROUP BY genre
ORDER BY avg_votes DESC

--9. Which recent movies (after 2020) are top-rated?

SELECT title, release_year, vote_average
FROM netflix
WHERE release_year >= 2020
ORDER BY vote_average DESC
LIMIT 10

--10. Which year had the maximum number of blockbusters (popularity > 80)?

SELECT release_year, COUNT(*) AS blockbuster_count
FROM netflix_analysis
WHERE popularity > 80
GROUP BY release_year
ORDER BY blockbuster_count DESC
LIMIT 1

--11. Which genres have declining popularity over time?

SELECT genre, release_year, AVG(popularity) AS avg_popularity
FROM netflix_analysis
GROUP BY genre, release_year
ORDER BY genre, release_year

--12. Which movies had the highest vote_count in 2021?

SELECT title, vote_count
FROM netflix_analysis
WHERE release_year = 2021
ORDER BY vote_count DESC
LIMIT 5

--13. Which genres have both high ratings AND high popularity?

SELECT genre, AVG(vote_average) AS avg_rating, AVG(popularity) AS avg_popularity
FROM netflix_analysis
GROUP BY genre
HAVING AVG(vote_average) > 7 AND AVG(popularity) > 70

--14. Which movies had vote_count above average?

SELECT title, vote_count
FROM netflix_analysis
WHERE vote_count > (SELECT AVG(vote_count) FROM netflix_analysis)

--15. Which genres have the widest spread in ratings?

SELECT genre, MAX(vote_average) - MIN(vote_average) AS rating_range
FROM netflix_analysis
GROUP BY genre
ORDER BY rating_range DESC

--16. Which movies had popularity BETWEEN 50 and 70?

SELECT title, popularity
FROM netflix_analysis
WHERE popularity BETWEEN 50 AND 70

--17. Which genres had the most releases in 2020?

SELECT genre, COUNT(*) AS total
FROM netflix_analysis
WHERE release_year = 2020
GROUP BY genre
ORDER BY total DESC

--18. Which movies had titles containing “Love” and high ratings?

SELECT title, vote_average
FROM netflix_analysis
WHERE title LIKE '%Love%' AND vote_average > 7

--19. Which genres had fewer than 20 movies released?

SELECT genre, COUNT(*) AS total
FROM netflix_analysis
GROUP BY genre
HAVING COUNT(*) < 20

--20. Which movies had popularity categorized (High/Medium/Low)?

SELECT title, popularity,
       CASE
         WHEN popularity > 80 THEN 'High'
         WHEN popularity BETWEEN 50 AND 80 THEN 'Medium'
         ELSE 'Low'
       END AS popularity_category
FROM netflix_analysis























