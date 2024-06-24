# Calculate the percentage contribution of each pizza category to total revenue.
SELECT 
    pizza_types.category AS category,
    CONCAT(ROUND(ROUND(SUM(pizzas.price * order_details.quantity),
                            0) / (SELECT 
                            ROUND(SUM(pizzas.price * order_details.quantity),
                                        0)
                        FROM
                            pizzas
                                JOIN
                            order_details ON pizzas.pizza_id = order_details.pizza_id) * 100,
                    2),
            '%') AS contribution
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY category
ORDER BY contribution DESC;

# Analyze the cumulative revenue generated over time
select date, revenue, sum(revenue) over (order by date) as cum_revenue
from
(select
orders.order_date as date,
ROUND(SUM(pizzas.price * order_details.quantity),0) as revenue
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on orders.order_id = order_details.order_id
group by orders.order_date) as subquery;

# Determine the top 3 most ordered pizza types based on revenue for each pizza category.

