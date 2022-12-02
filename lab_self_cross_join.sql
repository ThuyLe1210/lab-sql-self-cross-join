use sakila;
-- Get all pairs of actors that worked together.
select * from film_actor a join film_actor a2 on a.actor_id > a2.actor_id 
and a.film_id = a2.film_id
order by a.film_id, a.actor_id;
--  Get all pairs of customers that have rented the same film more than 3 times.
select c1.customer_id as customerID1, c2.customer_id  as customerID2, c1.film_id from (
(select c.customer_id, film_id, count(rental_id)
from customer as c
join rental as r
on r.customer_id = c.customer_id
join inventory as i on i.inventory_id = r.inventory_id
group by c.customer_id, film_id
having count(rental_id) >1)
) as c1
join (
(select c.customer_id, i.film_id, count(rental_id)
from customer as c
join rental as r
on r.customer_id = c.customer_id
join inventory as i on i.inventory_id = r.inventory_id
group by c.customer_id, film_id
having count(rental_id) >1)
) as c2
on c2.film_id = c1.film_id AND c2.customer_id < c1.customer_id
group by c1.customer_id, c2.customer_id;

-- Get all possible pairs of actors and films.
select * from (select distinct title from film) as film1
cross join (select distinct actor_id, first_name, last_name from actor) as film2;
