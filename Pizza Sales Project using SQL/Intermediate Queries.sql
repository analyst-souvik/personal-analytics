# Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category AS Category,
    SUM(order_details.quantity) AS Quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY Category
ORDER BY Quantity DESC;

# Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS orders
FROM
    orders
GROUP BY hour;

# Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    category, COUNT(name) AS distribution
FROM
    pizza_types
GROUP BY category;

# Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(quantity), 0) AS `Avg. Quantity`
FROM
    (SELECT 
        DATE(orders.order_date) AS date,
            SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY date) AS subquery;
    
# Determine the top 3 most ordered pizza based on revenue.
SELECT 
    pizza_types.name AS name,
    ROUND(SUM(pizzas.price * order_details.quantity),
            0) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY quantity DESC
LIMIT 3;
