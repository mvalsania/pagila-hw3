/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
SELECT
  cat_name AS name,
  film_title AS title,
  total_rentals AS "total rentals"
FROM (
  SELECT
    cat.name AS cat_name,
    f.film_id,
    f.title AS film_title,
    COUNT(r.rental_id) AS total_rentals,
    ROW_NUMBER() OVER (
      PARTITION BY cat.category_id
      ORDER BY COUNT(r.rental_id) DESC, f.film_id DESC
    ) AS film_rank
  FROM film f
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category cat ON fc.category_id = cat.category_id
  JOIN inventory i ON f.film_id = i.film_id
  JOIN rental r ON i.inventory_id = r.inventory_id
  GROUP BY cat.category_id, cat.name, f.film_id, f.title
) AS ranked
WHERE film_rank <= 5
ORDER BY cat_name, total_rentals DESC, film_id ASC;

