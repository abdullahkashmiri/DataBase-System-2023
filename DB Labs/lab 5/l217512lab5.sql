-- ABDULLAH DAR 21-L-7512 BSCS - 4G DB LAB 5

Create database twitter
go
use twitter
go

create table Users
(
User_ID int,
UserName varchar(20) primary key,
Age int,
Country varchar(20),
privacy int
)

go

INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (1,N'Ali123', 18, N'Pakistan',1)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (2,N'Aliza', 40, N'USA',1)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (3,N'Aysha', 19, N'Iran',0)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (4,N'DonaldTrump', 60, N'USA',0)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (5,N'ImranKhan', 55, N'Pakistan',0)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (6,N'Natasha', 28, N'USA',0)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (7,N'Samuel', 37, N'Australia',0)
INSERT [dbo].[users] (User_ID,[UserName], [Age], [Country],privacy) VALUES (8,N'Sara', 30, N'Iran',1)



go

create table Following
(
FollowerUserName varchar(20) Foreign key References Users(UserName) ,
FollowedUserName varchar(20) Foreign key References Users(UserName),
primary key (FollowerUserName, FollowedUserName)
)

go

INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Ali123', N'DonaldTrump')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Aliza', N'Ali123')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Aliza', N'DonaldTrump')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Aliza', N'ImranKhan')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Aysha', N'ImranKhan')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'DonaldTrump', N'ImranKhan')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'ImranKhan', N'DonaldTrump')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Natasha', N'ImranKhan')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Samuel', N'DonaldTrump')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Samuel', N'ImranKhan')
INSERT [dbo].[Following] ([FollowerUserName], [FollowedUserName]) VALUES (N'Sara', N'DonaldTrump')

go

Create table Tweets
(
TweetID int primary key,
UserName varchar(20) Foreign key References Users(UserName),
[Text] varchar(140)
)

go

INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (1, N'Ali123', N'Pakistan’s largest-ever population #Census  starts today in 63 districts after 19 years. ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (2, N'ImranKhan', N'Pakistan’s largest-ever population #Census  starts today in 63 districts after 19 years. ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (3, N'Sara', N'Take the soldier who come to our door for #Census as A ThankYou from Pakistan Army for our devotion. #CensusWithSupportOfArmy')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (4, N'ImranKhan', N'Pakistan is going to experience 6th #Census 2017.')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (5, N'Sara', N'Only #census can reveal where this aunty lives ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (6, N'ImranKhan', N'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (7, N'Sara', N'Over 1 million decrypted Gmail and Yahoo accounts allegedly up for sale on the Dark Web https://geekz0ne.fr/shaarli/?wQRSoQ  #piratage')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (8, N'Sara', N'Harry pot-head and the Sorcerer''s stoned')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (9, N'DonaldTrump', N'LSDespicable Me  #DrugMovies')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (10, N'ImranKhan', N'Forrest Bump #DrugMovies @midnight')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (12, N'DonaldTrump', N'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (13, N'Sara', N'#DrugMovies')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (14, N'DonaldTrump', N'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique ')
INSERT [dbo].[Tweets] ([TweetID], [UserName], [Text]) VALUES (15, N'Aliza', N'Quand tu te lèves 3h en avance (littéralement) pour la #massecritique ')

go

Create table Likes
(
TweetID int Foreign key References Tweets(TweetID),
LikeByUserName varchar(20) Foreign key References Users(UserName),
LikeOnDate date
primary key (TweetID ,LikeByUserName)
)

GO
INSERT [dbo].[Likes] ([TweetID], [LikeByUserName], [LikeOnDate]) VALUES (1, N'Aliza', CAST(0x693C0B00 AS Date))
INSERT [dbo].[Likes] ([TweetID], [LikeByUserName], [LikeOnDate]) VALUES (2, N'Aliza', CAST(0x693C0B00 AS Date))
go

Create table Interests
(
InterestID int primary key,
[Description] varchar(30)
)

GO
INSERT [dbo].[Interests] ([InterestID], [Description]) VALUES (10, N'Politics')
INSERT [dbo].[Interests] ([InterestID], [Description]) VALUES (11, N'Sports')
INSERT [dbo].[Interests] ([InterestID], [Description]) VALUES (12, N'Movies')
INSERT [dbo].[Interests] ([InterestID], [Description]) VALUES (13, N'Education')
INSERT [dbo].[Interests] ([InterestID], [Description]) VALUES (14, N'Video Games')

go

create table UserInterests
(UserName varchar(20)  Foreign key References Users(UserName),
InterestID int Foreign key References Interests(InterestID)
primary key (UserName, InterestID)
 )
 
 GO
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Ali123', 10)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Ali123', 11)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Ali123', 13)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Ali123', 14)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Aliza', 10)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Aliza', 11)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Aliza', 13)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'Aliza', 14)
INSERT [dbo].[UserInterests] ([UserName], [InterestID]) VALUES (N'ImranKhan', 10)
 
 go

 Create table Hashtags
 (HashtagID int primary key,
 Hashtag varchar(30))
 
 GO
INSERT [dbo].[Hashtags] ([HashtagID], [Hashtag]) VALUES (1, N'#Census')
INSERT [dbo].[Hashtags] ([HashtagID], [Hashtag]) VALUES (2, N'#ClassiqueMatin')
INSERT [dbo].[Hashtags] ([HashtagID], [Hashtag]) VALUES (3, N'#MasseCritique')
INSERT [dbo].[Hashtags] ([HashtagID], [Hashtag]) VALUES (4, N'#piratage')
INSERT [dbo].[Hashtags] ([HashtagID], [Hashtag]) VALUES (5, N'#DrugMovies')

GO

Select * from Following
Select * from Hashtags
Select * from Interests
Select * from Tweets
Select * from UserInterests
Select * from Users

----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
--------------------------------------- S_O_L_U_T_I_O_N --------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------


-- 1. What is maximum, minimum, average and standard deviation of ages of the users? -- DONE
--(Search Standard Dev function)

SELECT MAX(Age) AS MaxAge, MIN(Age) AS MinAge, STDEV(Age) AS StdevAge FROM Users;

-- 2. Give name of the user who has the highest number of followers.  -- DONE

SELECT FollowedUserName AS UserName, COUNT(FollowerUserName) AS NoOfFollowers FROM Following GROUP BY
FollowedUserName HAVING COUNT(FollowerUserName) = (SELECT MAX(abc) FROM (SELECT COUNT(FollowerUserName)
AS abc FROM Following GROUP BY FollowedUserName) as sub);

-- 3. Give name of the user who has second highest followers.  -- DONE

SELECT UserName, NoOfFollowers FROM (SELECT FollowedUserName AS UserName, COUNT(FollowerUserName) AS
NoOfFollowers FROM Following WHERE FollowedUserName NOT IN (SELECT TOP 2 FollowedUserName FROM Following
GROUP BY FollowedUserName ORDER BY COUNT(FollowerUserName) DESC) GROUP BY FollowedUserName ORDER BY 
NoOfFollowers DESC OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY) AS subquery;

-- 4. List names of all the users who have never tweeted. -- DONE

select u.UserName  from Users as u left join Tweets as t ON u.UserName = t.UserName  WHERE t.TweetID IS NULL

-- 5. List all the hashtags and usernames and number of times that user used that hashtag.  -- DONE

SELECT h.Hashtag, t.UserName, COUNT(*) AS NoOfUsers FROM Hashtags as h INNER JOIN Tweets as t ON t.Text 
LIKE CONCAT('%', h.Hashtag, '%') GROUP BY h.Hashtag, t.UserName;

--6. Find the users who have never used the hashtag #Census. -- DONE

select distinct t.Username from Tweets as t Where UserName NOT IN (select t.UserName from Users as u inner
join tweets as t on ((u.UserName = t.UserName) AND (t.Text LIKE '%#Census%')) Group BY t.UserName)

-- 7. List all the usernames that have never been followed. -- DONE

select distinct u.UserName from Users as u where u.Username NOT IN (select u.UserName from Users as u inner
join Following as f on ((u.UserName = f.FollowedUserName) AND (FollowerUserName IS NOT NULL)))

-- 8. List all the usernames that have never been followed. Using Exist Clause.  -- DONE

 SELECT DISTINCT u.UserName FROM Users u WHERE NOT EXISTS (SELECT 1 FROM Users u2 INNER JOIN Following f ON 
 u2.UserName = f.FollowedUserName WHERE f.FollowerUserName IS NOT NULL AND u.UserName = u2.UserName);

-- 9. Find the most common interest of users. (The interest with largest number of users). Also -- DONE
-- find the least common interest.

-- MOST COMMON USER INTERESTS
SELECT i.InterestID, counts.NoOfUsers FROM Interests i INNER JOIN (SELECT ui.InterestID, COUNT(ui.UserName) AS NoOfUsers
FROM UserInterests ui GROUP BY ui.InterestID HAVING COUNT(ui.UserName) = ( SELECT MAX(counts.NoOfUsers) FROM (SELECT 
COUNT(ui.UserName) AS NoOfUsers FROM UserInterests ui GROUP BY ui.InterestID) counts)) counts ON i.InterestID = counts.InterestID;


-- LEAST COMMON USER INTERESTS
SELECT i.InterestID, counts.NoOfUsers FROM Interests i INNER JOIN (SELECT ui.InterestID, COUNT(ui.UserName) AS NoOfUsers
FROM UserInterests ui GROUP BY ui.InterestID HAVING COUNT(ui.UserName) = ( SELECT MIN(counts.NoOfUsers) FROM (SELECT 
COUNT(ui.UserName) AS NoOfUsers FROM UserInterests ui GROUP BY ui.InterestID) counts)) counts ON i.InterestID = counts.InterestID;

-- 10. Show total tweets per country. The result should be in order of country name. -- DONE

select u.Country, COUNT(t.UserName) from Users as u inner join tweets as t on t.UserName = u.UserName Group By Country Order by 
country asc

--11. Give the name of the users who have at least one follower from Pakistan. --DONE

select f.FolloweduserName from Following as f inner join Users as u on (u.UserName = f.FollowerUsername AND u.Country = 'Pakistan')
Group BY f.FollowedUserName


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- E_N_D ----------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------