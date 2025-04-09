 # Proyecto_2_Modulo_4_the_Power
 ----------------------------------------------------------------
En este proyecto muestra los conocimientos aprendidos en el módulo de SQL. 
Proyecto esta realizado  usando  PostgreSQL y  DBeaver.
Para aplicar estos conocimientos vamos a trabajar con una base de datos de una tienda de "películas ficticia",  que se puede ver en apartado de ficheros.
Archivo del esquema de la BBDD esta disponible en apartado de ficheros.
La Diagrama de base de datos esta presentada en apartado de ficheros.
El fichero con codigo de todas las consultas esta presentado en apartado de ficheros. Las consultas muestran siguientes conocimientos: las consultas con una sola tabla de tu BBDD,  las consultas con las relaciones entre tablas,  las subconsultas, Vistas,  datos temporales, tablas temporales.
------------------------------------------------------------------
Ficheros adjuntos a proyecto:
- Base de datos de proyecto - BBDD_Proyecto.sql
- La diagrama de relaciones entre tablas - Diagrama_proyecyo_sql.png
- Fichero con tareas resueltas - Proyecto_sql.sql
------------------------------------------------------------------
El Proyecto 2 del Módulo 4 tiene como objetivo demostrar y aplicar los conocimientos adquiridos en SQL. Para ello, se utiliza una base de datos de una tienda de películas ficticia, desarrollada con PostgreSQL y gestionada a través de DBeaver.​

Estructura del Proyecto:
    1. Base de Datos:
        Archivo: BBDD_Proyecto.sql​
        Contenido: Este script contiene las instrucciones SQL necesarias para crear y poblar la base de datos de la tienda de películas ficticia.​
    2. Diagrama de la Base de Datos:
        Archivo: Diagrama_proyecyo_sql.png​
        Contenido: Una representación gráfica del esquema de la base de datos, mostrando las tablas y sus relaciones, facilitando la comprensión de su estructura.​
    3. Consultas SQL:
        Archivo: Proyecto_sql.sql​
        Contenido: Este archivo incluye diversas consultas SQL​

  El archivo BBDD_Proyecto.sql del proyecto "Proyecto 2 del Módulo 4" contiene el script SQL necesario para crear y poblar la base de datos de una tienda de películas ficticia. A continuación, se describe la estructura de las principales tablas y sus relaciones:​

1. Tabla actor:
    Descripción: Almacena información sobre los actores.​
    Columnas:
        actor_id: Identificador único del actor.​
        first_name: Nombre del actor.​
        last_name: Apellido del actor.​
        last_update: Fecha de la última actualización del registro.​
2. Tabla film:
    Descripción: Contiene detalles de las películas disponibles en la tienda.​
    Columnas:
        film_id: Identificador único de la película.​
        title: Título de la película.​
        description: Descripción de la película.​
        release_year: Año de lanzamiento.​
        language_id: Identificador del idioma original.​
        rental_duration: Duración del alquiler en días.​
        rental_rate: Tarifa de alquiler.​
        length: Duración de la película en minutos.​
        replacement_cost: Costo de reemplazo de la película.​
        rating: Clasificación de la película (por ejemplo, 'PG', 'R').​
        last_update: Fecha de la última actualización del registro.​
3. Tabla inventory:
    Descripción: Registra las copias físicas de cada película en las distintas tiendas.​
    Columnas:
        inventory_id: Identificador único del inventario.​
        film_id: Identificador de la película (clave foránea que referencia a film).​
        store_id: Identificador de la tienda donde se encuentra la copia.​
        last_update: Fecha de la última actualización del registro.​
4. Tabla rental:
   Descripción: Almacena información sobre los alquileres realizados por los clientes.​
    Columnas:
        rental_id: Identificador único del alquiler.​
        rental_date: Fecha y hora en que se realizó el alquiler.​
        inventory_id: Identificador del inventario alquilado (clave foránea que referencia a inventory).​
        customer_id: Identificador del cliente que realizó el alquiler.​
        return_date: Fecha y hora de devolución de la película.​
        staff_id: Identificador del empleado que gestionó el alquiler.​
        last_update: Fecha de la última actualización del registro.​
5. Tabla customer:
    Descripción: Contiene información de los clientes de la tienda.​
    Columnas:
        customer_id: Identificador único del cliente.​
        store_id: Identificador de la tienda a la que está asociado el cliente.​
        first_name: Nombre del cliente.​
        last_name: Apellido del cliente.​
        email: Correo electrónico del cliente.​
        address_id: Identificador de la dirección del cliente.​
        activebool: Indica si el cliente está activo o no.​
        create_date: Fecha de creación del registro.​
        last_update: Fecha de la última actualización del registro.​
        active: Número que indica el estado activo del cliente.​
6. Tabla payment:
    Descripción: Registra los pagos realizados por los clientes por concepto de alquileres.​
    Columnas:
        payment_id: Identificador único del pago.​
        customer_id: Identificador del cliente que realizó el pago (clave foránea que referencia a customer).​
        staff_id: Identificador del empleado que recibió el pago.​
        rental_id: Identificador del alquiler asociado al pago.​
        amount: Monto pagado.​
        payment_date: Fecha y hora en que se realizó el pago.​
        last_update: Fecha de la última actualización del registro.​
7. Tabla staff:
    Descripción: Almacena información sobre los empleados de la tienda.​
    Columnas:
        staff_id: Identificador único del empleado.​
        first_name: Nombre del empleado.​
        last_name: Apellido del empleado.​
        address_id: Identificador de la dirección del empleado.​
        email: Correo electrónico del empleado.​
        store_id: Identificador de la tienda donde trabaja el empleado.​
        active: Indica si el empleado está activo.
----------------------------------------------------------------------------------------------------------

El archivo Proyecto_sql.sql del Proyecto 2 del Módulo 4 contiene una serie de consultas SQL diseñadas para interactuar con la base de datos de una tienda de películas ficticia. Las tareas realizadas en este archivo abarcan diversos aspectos del manejo y análisis de datos, incluyendo:​
    1. Consultas sobre Tablas Individuales:
        Extracción de información específica de tablas como actor, film, customer, entre otras.​
        Filtrado de datos utilizando cláusulas WHERE para obtener registros que cumplen con ciertos criterios.​
    2. Consultas con Joins entre Múltiples Tablas:
        Combinación de datos de dos o más tablas relacionadas mediante claves foráneas, utilizando diferentes tipos de JOIN (INNER JOIN, LEFT JOIN, etc.).​
        Obtención de información consolidada, como listar películas junto con sus actores o categorías.​
    3. Uso de Subconsultas:
        Implementación de subconsultas en cláusulas SELECT, FROM o WHERE para realizar consultas más complejas y anidadas.​
        Ejemplos incluyen la identificación de clientes que han alquilado más películas que el promedio.​
    4. Creación y Utilización de Vistas:
        Definición de vistas (CREATE VIEW) para almacenar consultas frecuentes y simplificar el acceso a datos complejos.​
        Uso de estas vistas para realizar consultas posteriores de manera más eficiente.​
    5. Manejo de Datos Temporales:
        Consultas que involucran la manipulación de fechas y horas, como calcular la duración de los alquileres o determinar retrasos en las devoluciones.​
        Uso de funciones de fecha para extraer información temporal relevante.​
    6. Uso de Tablas Temporales:
        Creación de tablas temporales para almacenar resultados intermedios o conjuntos de datos específicos durante una sesión.​
        Inserción y manipulación de datos dentro de estas tablas para análisis temporales.​
Estas tareas reflejan una aplicación práctica y avanzada de SQL, enfocada en la gestión eficiente de bases de datos relacionales y en la extracción de información significativa para el análisis de la operativa de la tienda de películas.
   

