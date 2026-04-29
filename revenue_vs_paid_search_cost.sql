-- Project: Monthly Revenue vs Paid Search Cost Analysis
-- Description: 
-- This query calculates total monthly revenue and paid search costs
-- to compare marketing performance over time.

SELECT year, month, SUM(revenue) as revenue, SUM(cost) as cost
FROM(

SELECT
      EXTRACT(YEAR FROM s.date) as year,
      EXTRACT(MONTH FROM s.date) as month,
      SUM(p.price) as revenue,
      NULL as cost
FROM `DA.product` p
join `DA.order` o
on p.item_id = o.item_id
join `DA.session` s
on o.ga_session_id = s.ga_session_id
GROUP BY 1,2

UNION ALL

SELECT
      EXTRACT(YEAR FROM date) as year,
      EXTRACT(MONTH FROM date) as month,
      NULL as revenue,
      SUM(cost) as cost
FROM `DA.paid_search_cost`
GROUP BY 1, 2

) revenue_cost

GROUP BY 1, 2
