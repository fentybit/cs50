SELECT title FROM movies WHERE year = 2008;

SELECT birth FROM people WHERE name = "Emma Stone";

SELECT title FROM movies WHERE year >= 2018 ORDER BY title;

SELECT COUNT(movie_id) FROM ratings WHERE rating = '10.0';

SELECT title, year FROM movies WHERE title LIKE '%Harry Potter%' ORDER BY year;

SELECT AVG(rating) FROM ratings
JOIN movies WHERE ratings.movie_id = movies.id AND movies.year = 2012;

SELECT movies.title, ratings.rating FROM movies
JOIN ratings ON movies.id = ratings.movie_id
WHERE movies.year = 2010
ORDER BY ratings.rating DESC, movies.title;

SELECT name FROM people
JOIN stars ON people.id = stars.person_id
WHERE movie_id = (SELECT id FROM movies WHERE title = "Toy Story");

SELECT DISTINCT(name) FROM people
JOIN stars ON people.id = stars.person_id
JOIN movies ON movies.id = stars.movie_id
WHERE movies.year = 2004
ORDER BY people.birth;

SELECT DISTINCT(name) FROM people
JOIN directors ON people.id = directors.person_id
JOIN movies ON movies.id = directors.movie_id
JOIN ratings ON ratings.movie_id = movies.id
WHERE ratings.rating >= '9.0';

SELECT title FROM movies
JOIN ratings ON movies.id = ratings.movie_id
JOIN stars ON stars.movie_id = ratings.movie_id
JOIN people ON people.id = stars.person_id
WHERE people.name = "Chadwick Boseman"
ORDER BY ratings.rating DESC
LIMIT 5;

SELECT title FROM movies
JOIN stars ON movies.id = stars.movie_id
JOIN people ON people.id = stars.person_id
WHERE people.name = "Johnny Depp"
INTERSECT
SELECT title FROM movies
JOIN stars ON movies.id = stars.movie_id
JOIN people ON people.id = stars.person_id
WHERE people.name = "Helena Bonham Carter";

SELECT DISTINCT name FROM people
JOIN stars ON stars.person_id = people.id
JOIN movies ON movies.id = stars.movie_id
WHERE movies.id IN
(SELECT movie_id FROM stars
JOIN people ON people.id = stars.person_id
WHERE people.name = "Kevin Bacon" AND people.birth = 1958)
AND people.name != "Kevin Bacon";