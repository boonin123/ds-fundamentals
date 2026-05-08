-- Q8: For subscriptions that churned, calculate the average subscription duration in days
--     broken down by plan tier. Duration = end_date minus start_date.
--     Both date columns are stored as VARCHAR — cast them to DATE.
--     Order by average duration descending.


-- Q9: Identify accounts that have BOTH an escalated support ticket AND a churned subscription.
--     These are high-risk accounts that had product problems before leaving.
--     Return account_id, number of escalated tickets, and total MRR across all their subscriptions.


-- Q10: Show the number of new subscriptions started each month and a running cumulative total.
--      Use a window function for the running total.
--      Format the month as YYYY-MM and order chronologically.