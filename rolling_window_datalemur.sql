/*
Given a table of tweet data over a specified time period, calculate the 3-day rolling average of tweets for each user. Output the user ID, tweet date, and rolling averages rounded to 2 decimal places.

Notes:

A rolling average, also known as a moving average or running mean is a time-series technique that examines trends in data over a specified period of time.
In this case, we want to determine how the tweet count for each user changes over a 3-day period.
Effective April 7th, 2023, the problem statement, solution and hints for this question have been revised.

tweets Table:
Column Name	Type
user_id	integer
tweet_date	timestamp
tweet_count	integer
*/

/*
ROLLING WINDOW FORMAT IS SIMPLE
average(*column whose average to be determined)
partition by (*the column that seperates the entities)
order by DATE
ROWS BETWEEN <ROLLING WINDOW -1> PRECEDING AND CURRENT ROW
*/

SELECT user_id, tweet_date,
       ROUND(avg(tweet_count) over (
       PARTITION BY user_id
       Order by tweet_date
       ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS rolling_avg_3d
FROM tweets;
