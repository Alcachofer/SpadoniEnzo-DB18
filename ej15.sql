#1)
CREATE OR REPLACE VIEW list_of_customers AS
	SELECT customer.customer_id, CONCAT(customer.last_name, ', ', customer.first_name) AS 'full name', address.address, 
			address.postal_code AS 'zip code', address.phone, city.city, country.country,
			CASE customer.active WHEN '1' THEN 'active'
									ELSE 'inactive'
									END AS status, 
			customer.store_id
	FROM customer
	INNER JOIN address USING (address_id)
	INNER JOIN city USING (city_id)
	INNER JOIN country USING (country_id);

SELECT * FROM list_of_customers;



#2)

CREATE OR REPLACE VIEW film_details AS
	SELECT film.film_id, film.title, film.description, c.name AS 'category', film.replacement_cost, film.`length`, film.rating, 
			GROUP_CONCAT(CONCAT(actor.first_name, ' ', actor.last_name) ORDER BY actor.last_name SEPARATOR ' - ') AS 'actors'
	FROM film
	INNER JOIN film_category USING (film_id)
	INNER JOIN category c USING (category_id)
	INNER JOIN film_actor USING (film_id)
	INNER JOIN actor USING (actor_id)
	GROUP BY 1, 4;


SELECT * FROM film_details;



#3)

CREATE OR REPLACE VIEW sales_by_film_category AS
	SELECT category.name, SUM(payment.amount) AS total_rental
	FROM category 
	INNER JOIN film_category USING(category_id)
	INNER JOIN film USING(film_id)
	INNER JOIN inventory USING(film_id)
	INNER JOIN rental USING(inventory_id)
	INNER JOIN payment USING(rental_id)
	GROUP BY 1;

SELECT * FROM sales_by_film_category;



#4) 

CREATE OR REPLACE VIEW actor_information AS
	SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film.film_id)
	FROM actor
	INNER JOIN film_actor USING(actor_id)
	INNER JOIN film USING(film_id)
	INNER JOIN inventory USING(film_id)
	INNER JOIN rental USING(inventory_id)
	INNER JOIN payment USING(rental_id)
	GROUP BY 1;

SELECT * FROM actor_information;


#5)


select `a`.`actor_id` AS `actor_id`, `a`.`first_name` AS `first_name`, `a`.`last_name` AS `last_name`,
	group_concat(
		distinct concat(
			`c`.`name`, ': ',(
				select group_concat( `f`.`title` order by `f`.`title` ASC separator ', ' )
					from(( `sakila`.`film` `f`
						join `sakila`.`film_category` `fc` on(( `f`.`film_id` = `fc`.`film_id` )))
						join `sakila`.`film_actor` `fa` on(( `f`.`film_id` = `fa`.`film_id` )))
					where(( `fc`.`category_id` = `c`.`category_id` )
						and( `fa`.`actor_id` = `a`.`actor_id` )))
		)order by `c`.`name` ASC separator '
	) AS `film_info`
from ((( `sakila`.`actor` `a`
		left join `sakila`.`film_actor` `fa` on ( `a`.`actor_id` = `fa`.`actor_id` ))
		left join `sakila`.`film_category` `fc` on ( `fa`.`film_id` = `fc`.`film_id` ))
		left join `sakila`.`category` `c` on( `fc`.`category_id` = `c`.`category_id` )
group by `a`.`actor_id`, `a`.`first_name`, `a`.`last_name`;



#6) Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.

Son vistas que  muestran su resultado en una tabla temporaria.
Se utilizan para no tener que repetir una misma query varias veces, y para tener un acceso mas rapido a la informacion.
