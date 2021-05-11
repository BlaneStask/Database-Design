insert into users values('UserAbby', 'Abby', 'Smith', 'smith@gmail.com', 'asmith', 20);
insert into users values('UserJulia', 'Julia', 'Haze', 'haze@gmail.com', 'jhaze', 21);
insert into users values('UserJames', 'James', 'O''Brien', 'obrien@yahoo.com', 'jobrien', 18);
insert into users values('UserMark', 'Mark', 'De''Andre', 'deandre@gmail.com', 'meandre', 18);

insert into groups values(123, 'Group1', 'first group', 20, 22);
insert into groups values(234, 'Group2', 'second group', 18, 20);

insert into posts values(1111, 'UserAbby', 'T', 'Good Morning!', 123);
insert into posts values(2222, 'UserJulia', 'T', 'Hi!', 123);
insert into posts values(3333, 'UserMark', 'T', 'Good Night!', 234);
insert into posts values(4444, 'UserAbby', 'T', 'coffee break', 123);

insert into reactions values('UserJames', 3333, '+');
insert into reactions values('UserMark', 3333, '+');
insert into reactions values('UserJulia', 4444, '-');

insert into relationships values('UserAbby', 'UserMark', 'S');
insert into relationships values('UserJames', 'UserMark', 'S');
insert into relationships values('UserMark', 'UserJames', 'S');


-- Q1
select username, first_name, last_name, text
from users natural join posts
order by last_name, first_name, post_id ;

-- Q2
select * from users
where first_name LIKE '%''%' OR last_name LIKE '%''%';

-- Q3
select name, username from groups, users 
where (age >= min_age OR min_age is null ) 
AND (age <= max_age or max_age is null);

-- Q4
select first_name, last_name, count(text) 
from users natural join posts 
group by first_name, last_name;

-- Q5
with num_reaction(post_id, reactions)as 
(select post_id, count(type)   
from reactions    
group by post_id), 
max_reaction(max) as 
(select max(reactions) 
from num_reaction)
select post_id from num_reaction, max_reaction
where num_reaction.reactions = max_reaction.max;

-- Q6
with num_likes(post_id, likes) as
(select post_id, count(type)    
from reactions    
where type = '+'    
group by post_id)
select text, likes 
from num_likes, posts
where num_likes.post_id = posts.post_id 
and likes > 1;

-- Q7
select username, other_user 
from relationships 
where type = 'S'
minus 
select R1.username, R1.other_user 
from relationships R1, relationships R2 
where R1.username = R2.other_user 
and R1.other_user = R2.username 
and R1.type='S' 
and R2.type='S';

-- Q8
select username from users 
minus 
select username from posts;

-- Q9
select username 
from users
where username not in ( select username from posts);

