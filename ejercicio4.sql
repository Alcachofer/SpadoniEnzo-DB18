# 1 
SELECT film.title, film.special_features 
FROM film 
WHERE film.rating = "PG-13";

# 2
SELECT DISTINCT film.length 
FROM film;

# 3
3) SELECT film.title, film.rental_rate, film.replacement_cost 
FROM film 
WHERE replacement_cost BETWEEN 20.00 AND 24.00;

#4
SELECT film.title, category.name, film.rating, film.special_features 
FROM film, film_category, category 
WHERE film.film_id = film_category.film_id AND film_category.category_id = category.category_id AND film.special_features LIKE "%Behind the Scenes%";

#5
SELECT actor.first_name, actor.last_name 
FROM actor, film, film_actor 
WHERE actor.actor_id = film_actor.actor_id AND film_actor.film_id = film.film_id AND film.title = 'ZOOLANDER FICTION';

#6
SELECT ADDRESS, city, country, store_id 
FROM store, city, ADDRESS, country 
WHERE store.address_id = ADDRESS.address_id AND ADDRESS.city_id = city.city_id AND city.country_id = country.country_id AND store.store_id = 1;

#7
SELECT DISTINCT f1.title , f2.title, f1.rating, f2.rating 
FROM film f1, film f2 
WHERE f1.rating = f2.rating;

#8
SELECT DISTINCT film.title, staff.first_name, staff.last_name 
FROM film, inventory, store, staff 
WHERE film.film_id = inventory.film_id AND store.store_id = inventory.store_id AND store.store_id = 2 AND staff.staff_id = store.manager_staff_id;
