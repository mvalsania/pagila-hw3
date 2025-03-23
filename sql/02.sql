/*
 * Compute the country with the most customers in it. 
 */
SELECT country
FROM (
  SELECT co.country, COUNT(*) AS count
  FROM customer c
  JOIN address a ON c.address_id = a.address_id
  JOIN city ci ON a.city_id = ci.city_id
  JOIN country co ON ci.country_id = co.country_id
  GROUP BY co.country
  ORDER BY count DESC
  LIMIT 1
) AS top_country;

