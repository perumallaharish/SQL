-- Data Anlysis of the Instagram Database

-- We want to reward the most loyal users on Instagram
-- Finding the 5 most oldest users on the platform

select username from users 
order by created_at ASC
Limit 5;

-- We need to send promotional emails to the people who never posted a Single photo on Instagram
-- Finding the users who never posted a photo on Instagram

select id, username from users
where id not in (select user_id from photos)
order by username;

SELECT u.username, image_url
FROM users u LEFT JOIN photos p
ON u.id = p.user_id
WHERE p.image_url is null;

-- We are arranging a contest to reward the user with most liked photo
-- Finding the user whose single photo is liked the most

select u.username, l.photo_id from users as u
left join likes as l on u.id = l.user_id
where l.photo_id = (select photo_id from likes group by photo_id order by count(photo_id) Desc limit 1);

-- We need to use popular hashtags in order to reach our maximum users
-- Finding the top 5 most commonly used hashtags on Instagram

select tag_name from tags
where id in (select tag_id from photo_tags group by tag_id order by count(tag_id) Desc Limit 5);  

SELECT tag_name FROM tags
WHERE id IN (SELECT tag_id  FROM photo_tags GROUP BY tag_id ORDER BY COUNT(tag_id) DESC LIMIT 5);

SELECT t.tag_name, t.id
FROM tags t
JOIN (SELECT tag_id  FROM photo_tags GROUP BY tag_id ORDER BY COUNT(tag_id) DESC LIMIT 5) q
ON t.id = q.tag_id;

-- ***********Imp*********************************************************
-- We want to launch ads on the best day of the week
-- Finding the day of the week on which most users register on the platform

select * from users;

select year(cast(created_at as Date)) as day_name, count(*) as value
from users
group by 1
order by 2 desc
Limit 1;


 -- We want to see the activeness of the users on Instagram
 -- Finding the amount of time an average user posts on instagram
 
 SELECT ROUND ((SELECT COUNT(*) FROM photos)/(SELECT COUNT(*) FROM users),3) AS Average_Posting;
 
 -- We want to delete some fake accounts/bots
-- Finding those users which have like every single photo

select * from likes;

select * from photos;

select u.username, count(p.id) as number_of_posts from users as u
left join photos as p on u.id = p.user_id
where u.username = 'Jaclyn81'
group by 1
;

SELECT username FROM users
WHERE id IN 
(SELECT user_id  FROM LIKES 
GROUP BY user_id 
HAVING COUNT(user_id) = (SELECT COUNT(*) FROM photos));
