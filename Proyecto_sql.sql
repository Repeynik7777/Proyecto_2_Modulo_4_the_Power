-- DataProject: LógicaConsultasSQL=================================================

-- 1. Crea el esquema de la BBDD.

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.
SELECT f.title AS nombre_pelicula, f.rating AS clasificacion_edad
FROM film AS f
WHERE f.rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
SELECT concat(a.first_name ,' ',a.last_name ) AS nombre_actor, a.actor_id AS id_actor
FROM actor AS a 
WHERE a.actor_id BETWEEN 30 AND 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
SELECT  f.title AS nombre_pelicula, 
        f.language_id AS idioma_pelicula, 
        f.original_language_id AS idioma_pelicula_original
FROM film AS f
WHERE f.language_id = f.original_language_id;

-- 5.  Ordena las películas por duración de forma ascendente.
SELECT  f.title AS nombre_pelicula, 
        f.length AS duracion_pelicula
FROM film AS f
ORDER BY f.length;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido
SELECT concat(a.first_name ,' ',a.last_name ) AS nombre_actor
FROM actor AS a 
WHERE a.last_name ILIKE 'allen';

/* 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
 “filmˮ y muestra la clasificación junto con el recuento*/
SELECT  f.rating AS clasificacio_pelicula,
        count(f.film_id) AS cantidad_peliculas
FROM film AS f 
GROUP BY f.rating; 


/* 8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una
duración mayor a 3 horas en la tabla film.*/
SELECT f.title AS nombre_pelicula,
        f.rating AS clasificacion_pelicula,
        f.length AS duracion_pelicula
FROM film AS f 
WHERE f.rating = 'PG-13' OR f.length > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT STDDEV(f.replacement_cost) AS variacion_gasto_reemplazar_pelicula
FROM film AS f ;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT  min(f.length) AS minima_duracion_pelicula,
        max(f.length) AS maxima_duracion_pelicula
FROM film AS f;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT f.rental_duration AS duracion_alquiler,
        f.rental_rate AS coste_alquiler
FROM film AS f 
ORDER BY f.rental_duration DESC
LIMIT 1 OFFSET 2;

/*12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-
17ʼ ni ‘Gʼ en cuanto a su clasificación.*/
SELECT f.title AS nombre_pelicula,
        f.rating AS clasificacion_pelicula
FROM film AS f 
WHERE f.rating NOT IN ('NC-17', 'G') ;

/*13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.*/
SELECT  f.rating AS clasificacion_pelicula,
        avg(f.length) AS promedio_duracion_pelicula
FROM film AS f
GROUP BY f.rating ;

/*14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.*/
SELECT  f.title AS nombre_pelicula,
        f.length AS duracion_pelicula
FROM film AS f 
WHERE  f.length > 180;

--15.¿Cuánto dinero ha generado en total la empresa?
SELECT sum(p.amount) AS total_beneficio
FROM payment AS p;

--16. Muestra los 10 clientes con mayor valor de id.
SELECT c.customer_id AS id_cliente
FROM customer AS c
ORDER BY c.customer_id DESC
LIMIT 10; 

/*17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igbyʼ.*/
SELECT concat(a.first_name ,' ',a.last_name ) nombre_actor,
        f.title AS nombre_pelicula
FROM actor AS a 
INNER JOIN film_actor AS fa 
ON a.actor_id =fa.actor_id 
INNER JOIN film AS f 
ON f.film_id = fa.film_id 
WHERE f.title ILIKE 'egg igby';

--18. Selecciona todos los nombres de las películas únicos.
SELECT  DISTINCT f.title AS nombre_pelicula
FROM film AS f;

/*19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “filmˮ.*/
SELECT  f.title AS nombre_pelicula,
        c."name" AS nombre_categoria,
        f.length AS duracion_pelicula
FROM film AS f
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN category AS c 
ON c.category_id = fc.category_id 
WHERE c."name" ILIKE 'comedy' AND f.length > 180;

/*20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.*/
WITH duracion_promedio_por_categoria AS (
SELECT  c."name" AS nombre_categoria,
        avg(f.length) AS duracion_promedio_pelicula
FROM film AS f
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN category AS c 
ON c.category_id = fc.category_id
GROUP BY c."name" 
)
SELECT nombre_categoria , duracion_promedio_pelicula 
FROM duracion_promedio_por_categoria 
WHERE duracion_promedio_pelicula > 110;

--21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT avg(f.rental_duration) AS duracion_media_alquiler
FROM film AS f ;

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT concat(a.first_name ,' ',a.last_name ) AS nombre_completo_actores
FROM actor AS a;

/*23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.*/
SELECT 
    EXTRACT(YEAR FROM r.rental_date) AS año,
    EXTRACT(MONTH FROM r.rental_date) AS mes,
    EXTRACT(DAY FROM r.rental_date) AS dia,
    COUNT(r.rental_id) AS total_alquileres
FROM rental AS r
GROUP BY año, mes, dia
ORDER BY año DESC, mes DESC, dia DESC ;

--25 Encuentra las películas con una duración superior al promedio.
SELECT f.title AS nombre_pelicula,
       f.length as duracion_pelicula
FROM film AS f 
WHERE f.length > (
                SELECT avg(f2.length) AS promedio_duracion_pelicula
                FROM film AS f2 
);

--26.  Averigua el número de alquileres registrados por mes.
SELECT 
    EXTRACT(YEAR FROM r.rental_date) AS año,
    EXTRACT(MONTH FROM r.rental_date) AS mes,
    COUNT(r.rental_id) AS total_alquileres
FROM rental AS r
GROUP BY año, mes
ORDER BY año DESC, mes DESC;

--27. Encuentra el promedio, la desviación estándar y varianza del total pagado.
SELECT  round(avg(p.amount), 2) AS promedio_pagos,
        round(stddev(p.amount ), 2) AS desviacion_pagos,
        round(variance(p.amount ), 2) AS varianza_pagos
FROM payment AS p 

--28. ¿Qué películas se alquilan por encima del precio medio?
SELECT f.title AS nimbre_pelicula,
        f.replacement_cost AS precio_alquiler
FROM film AS f 
WHERE f.replacement_cost > (
                            SELECT avg(f2.replacement_cost ) AS precio_medio
                            FROM film AS f2 
                            );

--29. Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT 
        fa.actor_id AS id_actor,
        count(fa.film_id) AS numero_peliculas
FROM film_actor AS fa 
GROUP BY fa.actor_id 
HAVING count(fa.actor_id) > 40  ;

/*30. Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible.*/
SELECT f.title AS nombre_pelicula,
        sum(i.inventory_id ) AS cantidad_disponible
FROM film AS f 
INNER JOIN inventory AS i 
ON f.film_id = i.film_id 
GROUP BY f.title 

--31. Obtener los actores y el número de películas en las que ha actuado.
SELECT  fa.actor_id AS id_actor, 
        count(fa.film_id)  AS numero_peliculas
FROM film_actor AS fa
GROUP BY fa.actor_id ;

/*32. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados.*/
SELECT f.title AS nombre_pelicula,
        concat(a.first_name ,' ',a.last_name ) AS nombre_actor
FROM film AS f 
FULL JOIN film_actor AS fa 
ON f.film_id = fa.film_id 
FULL JOIN actor AS a 
ON a.actor_id = fa.actor_id 
ORDER BY f.title ;

/*33.Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.*/
SELECT  concat(a.first_name ,' ',a.last_name ) AS nombre_actor,
        f.title AS nombre_pelicula
FROM actor AS a 
FULL JOIN film_actor AS fa 
ON a.actor_id  = fa.actor_id 
FULL JOIN film AS f
ON f.film_id  = fa.film_id 
ORDER BY nombre_actor ;

--34. Obtener todas las películas que tenemos y todos los registros de alquiler.
SELECT f.title AS nombre_pelicula,
        r.rental_id AS id_alquiler
FROM film AS f 
FULL JOIN inventory AS i 
ON f.film_id = i.film_id 
FULL JOIN rental AS r 
ON i.inventory_id = r.inventory_id;

--35. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
SELECT concat(c.first_name ,' ',c.last_name ) AS nombre_cliente,
        sum(p.amount ) AS pagado_cliente
FROM customer AS c 
INNER JOIN rental AS r 
ON c.customer_id = r.customer_id 
INNER JOIN payment AS p 
ON r.rental_id = p.rental_id
GROUP BY nombre_cliente  
ORDER BY pagado_cliente DESC 
LIMIT 5;

--36. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
SELECT concat(a.first_name ,' ',a.last_name ) AS nombre_actor
FROM actor AS a 
WHERE a.first_name ILIKE 'johnny';


--37. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
SELECT a.first_name AS Nombre,
        a.last_name AS Apellido
FROM actor AS a ;

--38. Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT min(a.actor_id) AS min_id_actor,
        max(a.actor_id) AS max_id_actor
FROM actor AS a ;

--39. Cuenta cuántos actores hay en la tabla “actorˮ.
SELECT count(a.actor_id ) AS numero_actores
FROM actor AS a ;

--40. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
SELECT a.first_name AS Nombre,
        a.last_name AS Apellido
FROM actor AS a 
ORDER BY a.last_name ;

--41. Selecciona las primeras 5 películas de la tabla “filmˮ.
SELECT f.title AS nombre_pelicula
FROM film AS f 
LIMIT 5;

/*42. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?*/
--Kenneth, Penelope, Julia
SELECT a.first_name AS nombre_actor,
        count(a.actor_id ) AS numero_actores
FROM actor AS a 
GROUP BY a.first_name 
ORDER BY numero_actores DESC ;

--43. Encuentra todos los alquileres y los nombres de los clientes que los realizaron
SELECT concat(c.first_name ,' ', c.last_name ) AS nombre_clientes,
        r.rental_id AS id_alquiler
FROM customer AS c
INNER JOIN rental AS r 
ON c.customer_id = r.customer_id;

/*44.Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.*/
SELECT concat(c.first_name ,' ', c.last_name ) AS nombre_clientes,
        r.rental_id AS id_alquiler
FROM customer AS c
FULL JOIN rental AS r
ON c.customer_id = r.customer_id;

/*45. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.*/
SELECT *
FROM film AS f 
CROSS JOIN category AS c ;
/*Esta consulta devuelve datos porque el CROSS JOIN 
 * devuelve datos sin ningun tipo de relacion de las tablas,
 * solo se combina cada fila de la primera tabla con cada fila de segunda tabla
 */

--46. Encuentra los actores que han participado en películas de la categoría 'Action'.
SELECT  c."name" AS nombre_categoria,
        f.title AS nombre_pelicula,
        concat(a.first_name ,' ', a.last_name ) AS nombre_actor
FROM film AS f
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN category AS c 
ON c.category_id = fc.category_id
INNER JOIN film_actor AS fa 
ON fa.film_id = f.film_id 
INNER JOIN actor AS a 
ON a.actor_id = fa.actor_id 
WHERE c."name" ILIKE  'action';



--47. Encuentra todos los actores que no han participado en películas.
SELECT concat(a.first_name ,' ', a.last_name ) AS nombre_actor,
        fa.film_id AS id_pelicula
FROM actor AS a 
FULL JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id 
WHERE fa.film_id IS NULL ;

/*48. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado.*/
SELECT  concat(a.first_name ,' ', a.last_name ) AS nombre_actor,
        count(fa.film_id) AS numero_pelicula
FROM actor AS a 
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
GROUP BY nombre_actor ;

/*49.  Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres
de los actores y el número de películas en las que han participado.*/
CREATE VIEW actor_num_peliculas AS (
            SELECT  concat(a.first_name ,' ', a.last_name ) AS nombre_actor,
        count(fa.film_id) AS numero_pelicula
FROM actor AS a 
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
GROUP BY nombre_actor
)

SELECT *
FROM actor_num_peliculas AS anp 

--50.Calcula el número total de alquileres realizados por cada cliente.
SELECT c.customer_id AS id_cliente,
        count(r.rental_id ) AS numero_alquileres
FROM customer AS c 
INNER JOIN rental AS r 
ON c.customer_id = r.customer_id 
GROUP BY c.customer_id 
ORDER BY c.customer_id ;

--51.  Calcula la duración total de las películas en la categoría 'Action'.
SELECT  c."name" AS nombre_categoria,
        sum(f.length ) AS duracion_total_peliculas
FROM film AS f
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN category AS c 
ON c.category_id = fc.category_id
GROUP BY c."name" 
HAVING  c."name" ILIKE  'action';

/*52. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para
almacenar el total de alquileres por cliente.*/
CREATE TEMPORARY TABLE cliente_rentas_temporal AS
    SELECT r.customer_id AS id_cliente,
            count(r.rental_id ) AS numero_alquileres
    FROM rental AS r
    GROUP BY r.customer_id ;

SELECT *
FROM cliente_rentas_temporal
ORDER BY id_cliente;

DROP TABLE cliente_rentas_temporal;

/*53. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las
películas que han sido alquiladas al menos 10 veces.*/
CREATE TEMPORARY TABLE peliculas_alquiladas as
SELECT f.title AS nombre_pelicula,
        count(r.rental_id ) AS numeros_alquiler
FROM film AS f 
INNER JOIN inventory AS i 
ON f.film_id = i.film_id 
INNER JOIN rental AS r 
ON i.inventory_id = i.inventory_id 
GROUP BY f.title 
HAVING count(r.rental_id) >= 10;

/*54. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.*/
SELECT f.title,
        concat(c.first_name ,' ',c.last_name) AS nombre_cliente
FROM film AS f 
INNER JOIN inventory AS i 
ON f.film_id = i.film_id 
INNER JOIN rental AS r 
ON i.inventory_id = r.inventory_id 
INNER JOIN customer AS c 
ON c.customer_id = r.customer_id 
WHERE concat(c.first_name ,' ',c.last_name) ILIKE 'Tammy Sanders' AND 
        return_date IS NULL  
ORDER BY f.title ;


/*55. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados
alfabéticamente por apellido.*/
SELECT   DISTINCT concat(a.last_name ,' ', a.first_name ) AS nombre_actor,
        c."name" AS nombre_categoria
FROM actor AS a 
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id 
INNER JOIN film AS f 
ON f.film_id = fa.film_id 
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id 
INNER JOIN category AS c 
ON c.category_id = fc.category_id 
WHERE c."name" ILIKE 'sci-fi'
ORDER BY nombre_actor  ;


/*56. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaperʼ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.*/

SELECT DISTINCT a.first_name AS nombre_actor, a.last_name AS apellido_actor
FROM actor as a
INNER JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
INNER JOIN film AS f 
ON fa.film_id = f.film_id
INNER JOIN inventory as i 
ON f.film_id = i.film_id
INNER JOIN rental AS r 
ON i.inventory_id = r.inventory_id
WHERE r.rental_date  > (
    SELECT MIN(r2.rental_date )
    FROM film AS f2 
    INNER JOIN inventory AS i2 
    ON f2.film_id  = i2.film_id
    INNER JOIN rental AS  r2 
    ON i2.inventory_id = r2.inventory_id
    WHERE f2.title ILIKE  'Spartacus Cheaper'
)
ORDER BY apellido_actor ;



/*57. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Musicʼ.*/
SELECT   concat(a.first_name ,' ', a.last_name ) AS nombre_actor
FROM actor AS a 
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor AS fa
    INNER JOIN film f 
    ON fa.film_id = f.film_id
    INNER JOIN film_category AS  fc 
    ON f.film_id = fc.film_id
    INNER JOIN category AS  c
    ON fc.category_id = c.category_id
    WHERE c.name ILIKE  'Music'
    );


/*58. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.*/
SELECT DISTINCT f.title AS titulo_pelicula
FROM film AS f 
INNER JOIN inventory AS  i 
ON f.film_id  = i.film_id 
INNER JOIN rental AS  r 
ON i.inventory_id = r.inventory_id
WHERE r.return_date - r.rental_date > INTERVAL '8 days';


/*59. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animationʼ.*/
SELECT f.title AS titulo_pelicula
FROM film AS f 
INNER JOIN film_category AS fc  
ON f.film_id = fc.film_id  
INNER JOIN category AS c 
ON c.category_id = fc.category_id 
WHERE c."name" ILIKE 'animation';

/*60.  Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Feverʼ. Ordena los resultados
alfabéticamente por título de película.*/
SELECT f.title AS titulo_pelicula
FROM film AS f 
WHERE f.length = (
        SELECT f2.length 
        FROM film AS f2 
        WHERE f2.title ILIKE 'Dancing Fever'
        )
ORDER BY f.title ;


/*61. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.*/
CREATE TEMPORARY TABLE numero_alquileres_por_cliente AS 
SELECT concat (c.last_name ,' ', c.first_name ) AS nombre_cliente,
        count( DISTINCT i.film_id  ) AS numero_alquileres
FROM customer AS c
INNER JOIN rental r 
ON c.customer_id = r.customer_id
INNER JOIN inventory i 
ON i.inventory_id = r.inventory_id 
GROUP  BY nombre_cliente 
ORDER BY nombre_cliente  ;

DROP TABLE numero_alquileres_por_cliente;

SELECT nombre_cliente, numero_alquileres
FROM numero_alquileres_por_cliente
WHERE numero_alquileres > 7



/*62.Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres.*/
SELECT c."name" AS nombre_categoria,
        count(r.rental_id ) AS numero_alquileres
FROM category AS c
INNER JOIN film_category as fc 
ON c.category_id = fc.category_id 
INNER JOIN film AS f
ON f.film_id = fc.film_id
INNER JOIN inventory AS i
ON i.film_id = f.film_id
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id 
GROUP BY c."name" ;


--63. Encuentra el número de películas por categoría estrenadas en 2006.
SELECT c."name" AS nombre_categoria,
        count(f.film_id  ) AS numero_peliculas
FROM category AS c
INNER JOIN film_category as fc 
ON c.category_id = fc.category_id 
INNER JOIN film AS f
ON f.film_id = fc.film_id
WHERE  f.release_year = 2006
GROUP BY c."name";


/*64. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.*/
SELECT concat(s.first_name ,' ',s.last_name ) AS nombre_trabajador,
        s2.store_id AS id_tienda
FROM staff AS s 
CROSS JOIN store AS s2 ;


/*65. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.*/
SELECT c."customer_id" AS id_cliente,
        concat(c."first_name" ,' ', c."last_name" ),
        count(rental_id) AS numero_alquileres
FROM "customer" AS c  
INNER JOIN rental AS r 
ON r.customer_id = c."customer_id" 
GROUP BY c."customer_id" ;



