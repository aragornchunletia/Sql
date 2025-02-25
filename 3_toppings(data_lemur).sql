/*
Problem:
Given a list of pizza toppings, consider all the possible 3-topping pizzas, and print out the total cost of those 3 toppings. Sort the results with the highest total cost on the top followed by pizza toppings in ascending order.
Break ties by listing the ingredients in alphabetical order, starting from the first ingredient, followed by the second and third.
steps:
cross join for all the toppings, add prices
row-output should look like this
topping_1,topping_2,topping_3 total(t1.Price + t2.price + t3.price)
*/

Solution:
SELECT CONCAT_WS(
        ',', pt1.topping_name, pt2.topping_name, pt3.topping_name) as pizza,
        (pt1.ingredient_cost + pt2.ingredient_cost + pt3.ingredient_cost) as total_cost
FROM pizza_toppings as pt1
CROSS JOIN 
pizza_toppings as pt2,
pizza_toppings as pt3
WHERE pt1.topping_name < pt2.topping_name AND pt2.topping_name < pt3.topping_name
ORDER BY total_cost DESC, pizza ASC
;