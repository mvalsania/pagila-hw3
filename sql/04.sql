/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
SELECT a.first_name, a.last_name
FROM actor a
JOIN (
  SELECT DISTINCT fa.actor_id
  FROM film_actor fa
  JOIN film_category fc ON fa.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Children'
) AS children ON a.actor_id = children.actor_id
LEFT JOIN (
  SELECT DISTINCT fa.actor_id
  FROM film_actor fa
  JOIN film_category fc ON fa.film_id = fc.film_id
  JOIN category c ON fc.category_id = c.category_id
  WHERE c.name = 'Horror'
) AS horror ON a.actor_id = horror.actor_id
WHERE horror.actor_id IS NULL;

