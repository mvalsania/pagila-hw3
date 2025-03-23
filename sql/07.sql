/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
SELECT DISTINCT UPPER(a.first_name || ' ' || a.last_name) AS "Actor Name"
FROM film_actor fa
JOIN film_actor fb ON fa.film_id = fb.film_id
JOIN actor a ON fb.actor_id = a.actor_id
WHERE fa.actor_id IN (
  -- Bacall Number 1: all actors who appeared with Russell Bacall
  SELECT DISTINCT fa1.actor_id
  FROM film_actor fa1
  JOIN film_actor fb1 ON fa1.film_id = fb1.film_id
  JOIN actor r ON fb1.actor_id = r.actor_id
  WHERE r.first_name = 'RUSSELL'
    AND r.last_name = 'BACALL'
    AND fa1.actor_id <> r.actor_id
)
  -- Exclude actors who already appeared with Russell (Bacall Number 1)
  AND a.actor_id NOT IN (
    SELECT DISTINCT fa1.actor_id
    FROM film_actor fa1
    JOIN film_actor fb1 ON fa1.film_id = fb1.film_id
    JOIN actor r ON fb1.actor_id = r.actor_id
    WHERE r.first_name = 'RUSSELL'
      AND r.last_name = 'BACALL'
      AND fa1.actor_id <> r.actor_id
  )
  -- Also exclude Russell Bacall himself
  AND a.actor_id <> (
    SELECT actor_id FROM actor
    WHERE first_name = 'RUSSELL'
      AND last_name = 'BACALL'
  )
ORDER BY "Actor Name";

