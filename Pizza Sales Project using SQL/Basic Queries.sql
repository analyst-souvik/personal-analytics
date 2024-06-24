# Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS `Total Orders`
FROM
    orders;

# Calculate the total revenue generated from pizza sales.
SELECT 
    CONCAT('$ ',
            ROUND(SUM(pizzas.price * order_details.quantity),
                    0)) AS `Total Revenue`
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;
    
# Identify the highest-priced pizza.
SELECT 
    pizza_types.name, CONCAT('$ ', pizzas.price) AS price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

# Identify the most common pizza size ordered.
SELECT 
    pizzas.size, COUNT(order_details.order_id) AS `Total Orders`
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY `Total Orders` DESC
LIMIT 1;

# List the top 5 most ordered pizzas along with their quantities.
SELECT 
    pizza_types.name AS `Pizza Name`,
    SUM(order_details.quantity) AS Quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY `Pizza Name`
ORDER BY Quantity DESC
LIMIT 5;
 
 
