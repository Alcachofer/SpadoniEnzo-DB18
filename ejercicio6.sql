# 1
SELECT *
FROM actor q1
WHERE EXISTS (
    SELECT *
    FROM actor q2
    WHERE q1.actor_id <> q2.actor_id
    AND q1.last_name = q2.last_name
)
ORDER BY last_name;

# 2
SELECT *
FROM actor q1
WHERE NOT EXISTS (
    SELECT *
    FROM film_actor q2
    WHERE q1.actor_id = q2.actor_id
)
ORDER BY actor_id;

# 3
SELECT *
FROM customer q1
WHERE EXISTS (
    SELECT *
    FROM rental q2
    WHERE q1.customer_id = q2.customer_id
    AND NOT EXISTS (
        SELECT *
        FROM rental q3
        WHERE q1.customer_id = q3.customer_id
        AND q2.rental_id <> q3.rental_id
    )
);

# 4 
SELECT *
FROM customer q1
WHERE EXISTS (
    SELECT *
    FROM rental q2
    WHERE q1.customer_id = q2.customer_id
    AND EXISTS (
        SELECT *
        FROM rental q3
        WHERE q1.customer_id = q3.customer_id
        AND q2.rental_id <> q3.rental_id
    )
);

# 5
SELECT *
FROM actor q1
WHERE EXISTS(
    SELECT *
    FROM film_actor q2, film q3
    WHERE q1.actor_id = q2.actor_id
    AND q2.film_id = q3.film_id
    AND q3.title IN ('BETRAYED REAR', 'CATCH AMISTAD')
);

# 6
SELECT *
FROM actor q1
WHERE EXISTS (
    SELECT *
    FROM film_actor q2
    WHERE q1.actor_id = q2.actor_id
    AND EXISTS (
        SELECT * 
        FROM film q3
        WHERE q3.film_id = q2.film_id
        AND title IN ('BETRAYED REAR')
        AND title NOT IN ('CATCH AMISTAD') 
    )
);

# 7
SELECT *
FROM actor q1
WHERE EXISTS(
    SELECT *
    FROM film_actor q2, film q3
    WHERE q1.actor_id = q2.actor_id
    AND q2.film_id = q3.film_id
    AND q3.title IN ('BETRAYED REAR')
    AND q3.title IN ('CATCH AMISTAD')
);

# 8
SELECT *
FROM actor q1
WHERE NOT EXISTS (
    SELECT *
    FROM film_actor q2
    WHERE q1.actor_id = q2.actor_id
    AND EXISTS (
        SELECT * 
        FROM film q3
        WHERE q3.film_id = q2.film_id
        AND title IN ('BETRAYED REAR', 'CATCH AMISTAD')
    )
