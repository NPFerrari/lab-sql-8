-- Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country
FROM sakila.store s
JOIN sakila.address a
USING (address_id)
JOIN sakila.city c
USING (city_id)
JOIN sakila.country co
USING(country_id);

-- Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) AS total_business
FROM sakila.staff s
JOIN sakila.payment p
USING (staff_id)
GROUP BY s.store_id
ORDER BY total_business DESC;

-- Which film categories are longest?
SELECT c.category_id, c.name, SUM(f.length) AS total_duration
FROM sakila.film f
JOIN sakila.film_category fc
USING (film_id)
JOIN sakila.category c
USING (category_id)
GROUP BY c.category_id
ORDER BY total_duration DESC;

SELECT MAX(f.length) as longest, c.name
FROM sakila.category as c
JOIN sakila.film_category as fc
USING (category_id)
JOIN sakila.film as f
USING (film_id)
GROUP BY c.name
ORDER BY c.name DESC;

-- Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(f.film_id) as frequency_rent
FROM sakila.rental as r
JOIN sakila.inventory as i
USING (inventory_id)
JOIN sakila.film as f
USING (film_id)
GROUP BY f.title
ORDER BY frequency_rent desc
LIMIT 1;

-- List the top five genres in gross revenue in descending order.
SELECT c.category_id, c.name, SUM(p.amount) as tot_genres
FROM sakila.category as c
JOIN sakila.film_category as fc
USING (category_id)
JOIN sakila.inventory as i
USING (film_id)
JOIN sakila.rental as r
USING (inventory_id)
JOIN sakila.payment as p
USING (rental_id)
GROUP BY c.category_id
ORDER BY tot_genres DESC
LIMIT 5

-- Is "Academy Dinosaur" available for rent from Store 1?

SELECT store_id, f.title, COUNT(store_id) AS Num_film
FROM store
JOIN sakila.inventory i
USING (store_id)
JOIN sakila.film f
USING(film_id)
GROUP BY f.title, store_id, return_date
HAVING f.title = 'Academy Dinosaur';

SELECT f.title, COUNT(r.return_date IS NULL) AS not_available, COUNT(r.return_date IS NOT NULL) AS available, i.store_id
FROM sakila.rental r
JOIN sakila.inventory i
USING (inventory_id)
JOIN sakila.film f
USING (film_id)
WHERE f.title = 'Academy Dinosaur' AND i.store_id=1;

-- Get all pairs of actors that worked together.
-- i think Desh, Marta and I figured out we need to use the self-joining operation. BUT we don't know yet how to do it
SELECT a1.film_actor, a2.film_actor, a1.film_id
FROM sakila.film_actor a1
JOIN sakila.film_actor a2
ON (a1.film_actor = a2.film_actor) 


-- Get all pairs of customers that have rented the same film more than 3 times.

-- List each pair of actors that have worked together. (same questions as above)
SELECT CONCAT(a.first_name,' ', a.last_name) AS Actor, COUNT(film_id) AS Num_films
FROM film
JOIN sakila.film_actor fa
USING(film_id)
JOIN sakila.actor a
USING (actor_id)
GROUP BY actor_id
ORDER BY Num_films DESC
LIMIT 1;