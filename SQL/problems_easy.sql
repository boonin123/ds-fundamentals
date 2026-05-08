-- Q1: Count the total number of subscriptions for each plan tier (Basic, Pro, Enterprise).
-- Order results from most to least subscriptions.
SELECT plan_tier, count(*) AS ct 
FROM ravenstack_subscriptions
GROUP BY plan_tier
ORDER BY ct desc


-- Q2: Find all currently active subscriptions.
--     A subscription is active when it has not churned and has no end date.
--     Return the subscription_id, account_id, plan_tier, and mrr_amount.
SELECT subscription_id, account_id, plan_tier, mrr_amount 
FROM ravenstack_subscriptions
WHERE NOT churn_flag AND end_date == ''


-- Q3: What is the average MRR for monthly billing vs annual billing?
--     Round to 2 decimal places.
SELECT billing_frequency, round(avg(mrr_amount),2) as avg_mrr_amount 
FROM ravenstack_subscriptions
GROUP BY billing_frequency 


-- Q4: How many support tickets exist for each priority level (low, medium, high, urgent)?
--     Include the percentage each priority makes up of total tickets.
SELECT priority, count(*) as ct, count(*)*100.0/sum(count(*)) OVER() as pct
FROM ravenstack_support_tickets
GROUP BY priority
