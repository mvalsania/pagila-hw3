/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
(
  SELECT block1.title
  FROM (
    SELECT category.category_id, film.title
    FROM category
    JOIN film_category USING (category_id)
    JOIN film USING (film_id)
    WHERE film.title = 'AMERICAN CIRCUS'
  ) AS block
  LEFT JOIN (
    SELECT category.category_id, film.title
    FROM category
    JOIN film_category USING (category_id)
    JOIN film USING (film_id)
  ) AS block1
    ON block.category_id = block1.category_id
  GROUP BY block1.title
  HAVING COUNT(*) >= 2
)
INTERSECT
(
  SELECT f2.title
  FROM film_actor fa1
  JOIN film_actor fa2 ON fa1.actor_id = fa2.actor_id
  LEFT JOIN film f1 ON f1.film_id = fa1.film_id
  LEFT JOIN film f2 ON f2.film_id = fa2.film_id
  WHERE f1.title = 'AMERICAN CIRCUS'
  GROUP BY f2.title
  HAVING COUNT(DISTINCT fa1.actor_id) >= 1
)
ORDER BY title ASC;

