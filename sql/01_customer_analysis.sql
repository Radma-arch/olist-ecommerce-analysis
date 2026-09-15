```sql
-- Olist E-commerce Analysis
-- Customer Analysis


-- 1. Total number of customer records
SELECT COUNT(customer_id) AS total_customer_records
FROM customers;


-- 2. Total number of unique customers
SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM customers;


-- 3. Number of unique customer states
SELECT COUNT(DISTINCT customer_state) AS number_of_states
FROM customers;


-- 4. Customer distribution by state
SELECT customer_state,
       COUNT(DISTINCT customer_unique_id) AS customer_count
FROM customers
GROUP BY customer_state
ORDER BY customer_count DESC;


-- 5. Identify customers appearing more than once
SELECT customer_unique_id,
       COUNT(customer_id) AS repeated_id
FROM customers
GROUP BY customer_unique_id
HAVING COUNT(customer_id) > 1;


-- 6. Top 3 cities by number of unique customers
WITH totals AS (
    SELECT COUNT(DISTINCT customer_unique_id) AS num_of_customers,
           customer_city
    FROM customers
    GROUP BY customer_city
),
ranked AS (
    SELECT num_of_customers,
           customer_city,
           RANK() OVER (ORDER BY num_of_customers DESC) AS rank_num
    FROM totals
)
SELECT rank_num,
       num_of_customers,
       customer_city
FROM ranked
WHERE rank_num <= 3
ORDER BY rank_num;


-- 7. Top 3 states by number of unique customers
WITH totals AS (
    SELECT COUNT(DISTINCT customer_unique_id) AS num_of_customers,
           customer_state
    FROM customers
    GROUP BY customer_state
),
ranked AS (
    SELECT num_of_customers,
           customer_state,
           RANK() OVER (ORDER BY num_of_customers DESC) AS rank_num
    FROM totals
)
SELECT rank_num,
       num_of_customers,
       customer_state
FROM ranked
WHERE rank_num <= 3
ORDER BY num_of_customers DESC;
```

