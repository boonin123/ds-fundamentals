-- Q8: For subscriptions that churned, calculate the average subscription duration in days
--     broken down by plan tier. Duration = end_date minus start_date.
--     Both date columns are stored as VARCHAR — cast them to DATE.
--     Order by average duration descending.
SELECT plan_tier, 
	round(avg(CAST(end_date AS DATE)-CAST(start_date AS DATE)),2) as avg_subscription_duration
FROM ravenstack_subscriptions
WHERE churn_flag
GROUP BY plan_tier 
ORDER BY avg_subscription_duration DESC


-- Q9: Identify accounts that have BOTH an escalated support ticket AND a churned subscription.
--     These are high-risk accounts that had product problems before leaving.
--     Return account_id, number of escalated tickets, and total MRR across all their subscriptions.
WITH 
escalated_accounts AS (
	SELECT account_id, sum(escalation_flag) as escalated_tickets
	FROM ravenstack_support_tickets
	GROUP BY account_id
),
churned_accounts AS (
	SELECT account_id, sum(churn_flag) as churned_subscriptions, sum(mrr_amount) as total_mrr
	FROM ravenstack_subscriptions
	GROUP BY account_id
)
SELECT e.account_id, e.escalated_tickets, c.total_mrr 
FROM escalated_accounts e
JOIN churned_accounts c ON e.account_id = c.account_id
WHERE e.escalated_tickets > 0 AND c.churned_subscriptions > 0
ORDER BY c.total_mrr DESC


-- Q10: Show the number of new subscriptions started each month and a running cumulative total.
--      Use a window function for the running total.
--      Format the month as YYYY-MM and order chronologically.
SELECT strftime(date_trunc('month', CAST(start_date AS DATE)),'%Y-%m') AS month, 
	count(*) AS new_subscriptions,
	sum(count(*)) OVER (ORDER BY strftime(date_trunc('month', CAST(start_date AS DATE)),'%Y-%m')) AS running_total
FROM ravenstack_subscriptions
GROUP BY month
ORDER BY month