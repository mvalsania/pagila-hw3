/* 
 * You've decided that you don't actually like ACADEMY DINOSAUR and AGENT TRUMAN,
 * and want to focus on more movies that are similar to AMERICAN CIRCUS.
 * This time, however, you don't want to focus only on movies with similar actors.
 * You want to consider instead movies that have similar categories.
 *
 * Write a SQL query that lists all of the movies that share 2 categories with AMERICAN CIRCUS.
 * Order the results alphabetically.
 *
 * NOTE:
 * Recall that the following query lists the categories for the movie AMERICAN CIRCUS:
 * ```
 * SELECT name
 * FROM category
 * JOIN film_category USING (category_id)
 * JOIN film USING (film_id)
 * WHERE title = 'AMERICAN CIRCUS';
 * ```
 * This problem should be solved by a self join on the "film_category" table.
 */
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
ORDER BY block1.title;

