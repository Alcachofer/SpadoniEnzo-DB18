1)
INSERT INTO customer
(store_id, first_name, last_name, email, address_id)
VALUES
(1, 'Leo', 'Messi', 'leomessi@gmail.com', (SELECT address_id FROM address
INNER JOIN city USING (city_id)
INNER JOIN country USING (country_id)
WHERE country.country LIKE 'United States'
ORDER BY address_id DESC LIMIT 1));

2)
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id) VALUES(
    CURRENT_DATE(),
    (SELECT inventory_id FROM inventory INNER JOIN film USING (film_id) WHERE title = "ACADEMY DINOSAUR" LIMIT 1),
    (SELECT customer_id FROM customer WHERE store_id = 1 LIMIT 1),
    (SELECT staff_id FROM staff WHERE store_id = 1 LIMIT 1));

3)
UPDATE film
SET release_year = CASE
    WHEN rating = 'G' THEN 1970
    WHEN rating = 'PG' THEN 1971
    WHEN rating = 'PG-13' THEN 1972
    WHEN rating = 'R' THEN 1973
    WHEN rating = 'NC-17' THEN 1974
END;

4)
UPDATE rental
SET return_date = CURRENT_DATE()
WHERE rental_id = 14769;

INSERT INTO payment 
(customer_id, staff_id, rental_id, amount, payment_date, last_update)
VALUES (0, 0, NULL, 0, '',current_timestamp());

SELECT rental_id FROM rental WHERE return_date IS NULL;


5)
DELETE FROM film_actor
WHERE film_id = 1;

DELETE FROM film_category
WHERE film_id = 1;

DELETE FROM rental
WHERE inventory_id in (select inventory_id from inventory where film_id = 1);

DELETE FROM inventory
WHERE film_id = 1;

DELETE FROM film
WHERE film_id = 1;
