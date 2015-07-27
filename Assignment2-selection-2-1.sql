#1 Find the film title and language name of all films in which ADAM GRANT acted
#Order the results by title, descending (use ORDER BY title DESC at the end of the query)
SELECT F.title, L.name From film F 
inner join language L on L.language_id = F.language_id
inner join film_actor FA on FA.film_id = F.film_id 
inner join actor A on A.actor_id = FA.actor_id where A.first_name = 'ADAM' AND  A.last_name = 'GRANT'
ORDER BY F.title DESC;

#2 We want to find out how many of each category of film each actor has started in so return a table with actor's id, actor's first name, actor's last name, category name and the count
#of the number of films that the actor was in which were in that category (You do not need to return the rows whose column count is 0. Please note that there may be some actors with the exact same first names and last names).
SELECT A.actor_id, A.first_name, A.last_name, C.name, count(F.film_id) from actor A
inner join film_actor FA on FA.actor_id = A.actor_id
inner join film F on F.film_id = FA.film_id
inner join film_category FC on FC.film_id = F.film_id
inner join category C on C.category_id = FC.category_id
group by C.category_id, A.actor_id;

#3 Find the first name, last name and total combined film length of Sci-Fi films for every actor
#That is the result should list the names of all of the actors (even if an actor has not been in any Sci-Fi films) and the total length of Sci-Fi films they have been in.
SELECT A.first_name, A.last_name, lengthtable.length from actor A left join
(select sum(F.length) as length, A2.actor_id as actor_id from actor A2
inner join film_actor FA on FA.actor_id = A2.actor_id
inner join film F on F.film_id = FA.film_id
inner join film_category FC on FC.film_id = F.film_id
left join category C on C.category_id = FC.category_id where C.name = 'Sci-Fi'
group by A2.actor_id) as lengthtable on A.actor_id = lengthtable.actor_id;


#4 Find the first name and last name of all actors who have never been in a Sci-Fi film 
select A2.first_name, A2.last_name from actor A2 where A2.actor_id not in
(select A.actor_id from actor A
inner join film_actor FA on FA.actor_id = A.actor_id
inner join film F on F.film_id = FA.film_id
inner join film_category FC on FC.film_id = F.film_id
left join category C on C.category_id = FC.category_id where C.name = 'Sci-Fi'
group by A.actor_id);


#5 Find the film title of all films which feature both SCARLETT DAMON and BEN HARRIS
#Order the results by title, descending (use ORDER BY title DESC at the end of the query)
#Warning, this is a tricky one and while the syntax is all things you know, you have to think oustide
#the box a bit to figure out how to get a table that shows pairs of actors in movies
select title from ((select F.title from film F 
inner join film_actor FA on FA.film_id = F.film_id
inner join actor A on A.actor_id = FA.actor_id where A.first_name = 'SCARLETT' and A.last_name = 'DAMON') as ScarlettTable
inner join
(select F2.title as title2 from film F2
inner join film_actor FA2 on FA2.film_id = F2.film_id
inner join actor A2 on A2.actor_id = FA2.actor_id where A2.first_name = 'BEN' and A2.last_name = 'HARRIS'
) as benTable on ScarlettTable.title = benTable.title2)
ORDER BY title DESC;