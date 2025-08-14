-- YouTube Content Performance & Trends Analysis (Philippines)

-- 1. Total Videos, Views, Likes, Comments
SELECT 
	COUNT(*) AS total_videos,
	SUM(views) AS total_views,
    SUM(likes) AS total_likes,
    SUM(comments) AS total_comments
FROM youtube_philippines;


-- 2. Total Channels (Unique Creators)
SELECT COUNT(distinct channel_name) AS total_creators
FROM youtube_philippines;


-- 3. Top 10 Creators by Total Views
SELECT channel_name,
		SUM(views) AS total_views
FROM youtube_philippines
GROUP BY channel_name
ORDER BY total_views DESC
LIMIT 10;


-- 4. Most Viewed Individual Videos
SELECT 
	video_title,
    channel_name,
    views,
    likes,
    comments
FROM youtube_philippines
ORDER BY views DESC
LIMIT 10;


-- 5. Total Views by Category
SELECT 
	category,
    SUM(views) AS total_views
FROM youtube_philippines
GROUP BY category
ORDER BY total_views DESC;


-- 6. Average Engagement Rate per Category (likes/views)
SELECT 
	category,
    ROUND(AVG(likes / views) , 4) AS avg_engagement_rate
FROM youtube_philippines
WHERE views > 0
GROUP BY category
ORDER BY avg_engagement_rate DESC;


-- 7. Monthly Video Upload Count
SELECT 
  DATE_FORMAT(publish_date, '%Y-%m') AS upload_month,
  COUNT(*) AS videos_uploaded
FROM youtube_philippines
GROUP BY upload_month
ORDER BY upload_month;


-- 8. View Performance by Video Length Category
SELECT 
  CASE
    WHEN video_length_min < 5 THEN 'Short (<5min)'
    WHEN video_length_min BETWEEN 5 AND 15 THEN 'Medium (5–15min)'
    ELSE 'Long (>15min)'
  END AS length_category,
  COUNT(*) AS video_count,
  ROUND(AVG(views), 0) AS avg_views
FROM youtube_philippines
GROUP BY length_category
ORDER BY avg_views DESC;


-- 9. Engagement by Channel Subscribers
SELECT 
  CASE
    WHEN subscribers < 500000 THEN 'Small (Under 500K)'
    WHEN subscribers BETWEEN 500000 AND 2000000 THEN 'Medium (500K–2M)'
    ELSE 'Large (2M+)'
  END AS channel_size,
  ROUND(AVG(likes / views), 4) AS avg_engagement_rate,
  COUNT(*) AS total_videos
FROM youtube_philippines
WHERE views > 0
GROUP BY channel_size
ORDER BY avg_engagement_rate DESC;


-- 10. Views Per Video Per Channel
SELECT 
  channel_name,
  COUNT(*) AS video_count,
  ROUND(SUM(views) / COUNT(*)) AS avg_views_per_video
FROM youtube_philippines
GROUP BY channel_name
ORDER BY avg_views_per_video DESC
LIMIT 10;
