-- Quiz Funnel #2
-- What is the number of responses for each question?
SELECT question,COUNT(DISTINCT user_id)
FROM survey
GROUP BY 1;

-- Style
SELECT style AS Style,COUNT(user_ID) AS Responses
FROM quiz
GROUP BY style
ORDER BY style DESC;

-- Home Try On Breakdown
WITH funnels AS (SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs AS Pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
SELECT Pairs, COUNT(DISTINCT user_ID) AS Quiz, SUM(is_home_try_on) AS Home,
SUM(is_purchase) AS Purchase, ROUND(1.0 * SUM(is_purchase)/SUM(is_home_try_on),2) AS Conversion
FROM funnels
--WHERE Pairs IS NOT NULL
GROUP BY Pairs; 

-- Revenue by Model
SELECT model_name AS Model, COUNT(product_id) AS Quantity,ROUND(AVG(price),2) AS 'Avg Price', 1.0 * COUNT(product_id) * ROUND(AVG(price),2) AS Revenue
FROM purchase
GROUP BY Model
ORDER BY Revenue DESC;
 
