-- Q5: Find the top 10 accounts by total MRR across all their subscriptions.
--     Return account_id and their summed MRR, ordered highest first.
SELECT account_id, sum(mrr_amount) as total_mrr
FROM ravenstack_subscriptions
GROUP BY account_id
ORDER BY total_mrr desc
LIMIT 10

-- Q6: What is the average satisfaction score per priority level?
--     Exclude tickets where satisfaction_score is NULL.
--     Cast satisfaction_score to a number and round to 2 decimal places.
SELECT priority, round(avg(satisfaction_score),2) as avg_satisfaction_score
FROM ravenstack_support_tickets
WHERE satisfaction_score
GROUP BY priority

-- Q7: What is the churn rate (%) for each plan tier?
--     Churn rate = churned subscriptions / total subscriptions per tier.
--     Round to 1 decimal place.
SELECT plan_tier, round(sum(churn_flag)*100.0/count(*),1) AS churn_rate 
FROM ravenstack_subscriptions
GROUP BY plan_tier
