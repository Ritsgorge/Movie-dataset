
----QUESTION 1- Provide the managers' names and full address(address, district, city & country)
	SELECT dbo.staff.first_name, dbo.staff.last_name, dbo.address.address, dbo.address.district, dbo.city.city, dbo.country.country 
	FROM dbo.staff
	LEFT JOIN dbo.address on dbo.staff.address_id=dbo.address.address_id
	LEFT JOIN dbo.city on dbo.address.city_id=dbo.city.city_id
	LEFT JOIN dbo.country on dbo.city.country_id=dbo.country.country_id;


----QUESTION 2- Provide the inventory list including their store-id, inventory_id, name of film, film's rating, rental rate & replacement cost.
	SELECT dbo. inventory.store_id, dbo.inventory.inventory_id, title, rating, rental_rate, replacement_cost
	FROM dbo.film
	LEFT JOIN dbo.inventory on dbo.film.film_id=dbo.inventory.film_id;

	
----QUESTION 3- Provide a list showing the number of inventory items by each rating and store.
	SELECT COUNT(inventory_id) as number_of_items, store_id, dbo.film.rating
	FROM dbo.inventory
	LEFT JOIN dbo.film on dbo.inventory.film_id=dbo.film.film_id
	GROUP BY store_id, dbo.film.rating
	ORDER BY 1;


----QUESTION 4- Show the number of films, average replacement cost & average total cost. Group result by store and film category.
	SELECT COUNT(dbo.film.film_id) AS number_of_films, ROUND(AVG(dbo.film.replacement_cost),0) AS avg_replacement_cost, 
	ROUND(SUM(dbo.film.replacement_cost),0) AS total_replacement_cost, dbo.inventory.store_id, dbo.film_category.category_id
	FROM dbo.film
	LEFT JOIN dbo.inventory on dbo.film.film_id=dbo.inventory.film_id
	LEFT JOIN dbo.film_category on dbo.film.film_id=dbo.film_category.film_id
	GROUP BY dbo.inventory.store_id, dbo.film_category.category_id
	ORDER BY 1 DESC;
	

----QUESTION 5- Provide these information about customers; Names, store, whether or not they are active & full address-street, city, country)
	SELECT  first_name, last_name, store_id,
		CASE WHEN active='1' then 'YES' ELSE 'NO'
		END AS Active, dbo.address.address, dbo.city.city, dbo.country.country
	FROM dbo.customer
	LEFT JOIN dbo.address on dbo.customer.address_id=dbo.address.address_id
	LEFT JOIN dbo.city on dbo.address.city_id=dbo.city.city_id
	LEFT JOIN dbo.country on dbo.city.country_id=dbo.country.country_id;

	
----QUESTION 6- Provide information on most valuable customers
	SELECT TOP(10) first_name, last_name, ROUND(SUM(dbo.payment.amount), 0) AS sum_of_payment
	FROM dbo.customer
	LEFT JOIN dbo.payment on dbo.customer.customer_id=dbo.payment.customer_id
	GROUP BY first_name, last_name
	ORDER BY sum_of_payment DESC;


----QUESTION 7- Provide the details of advisors and investors in one table
	SELECT first_name, last_name, company_name, 
		CASE WHEN company_name IN ('Iron investors', 'Springfield Syndicators', 'Chocolate Ventures')
		THEN 'Investor' 
	END AS type 
	FROM dbo.investor
	UNION 
	SELECT first_name, last_name, is_chairman, 
		CASE WHEN is_chairman IN ('Yes', 'No') 
		THEN 'Advisor' 
	END AS type 
	FROM dbo.advisor
	

----QUESTION 8- Show the percentages of actors with 3, 2 & 1 awards respectivley
	SELECT COUNT (actor_award_id) / 200 * 100 AS percent_of_one_award 
	FROM actor_award
	WHERE awards IN ('Emmy', 'Oscar', 'Tony') 


