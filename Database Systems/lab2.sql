create table friend ( friend_id int NOT NULL,
name varchar(20),
address varchar(20),
telephone varchar(20),
PRIMARY KEY (friend_id));
create table hobbies ( friend_id int NOT NULL,
hobby varchar(20)NOT NULL,
PRIMARY KEY (friend_id,hobby),
FOREIGN KEY (friend_id)REFERENCES friend(friend_id));
describe friend;
insert into friend values ('1','Joe Bloggs','2 Old Rd','04273619');
insert into friend values ('2','Fred Bloggs','21 New Rd','04134816');
insert into friend values ('3','Sam Smith','10 High St','04291062');
insert into friend values ('4','Lucy Murphy','37 Old Rd','04274356');
insert into friend values ('5','John Clarke','29 High St','04275674');
insert into friend values ('6','Frank Smith','12 Chapel St','04123432');
insert into friend values ('7','Mary Clarke','14 New Rd','04267545');
insert into friend values ('8','Sarah Smith','12 Chapel St','04123432');
insert into friend values ('9','Kevin Jones','34 High St','04267564');
insert into friend values ('10','Laura King','23 New Rd','04123423');
insert into friend values ('11','Bill Daly','45 Chapel St','04234323');
insert into friend values ('12','Jane Smyth','11 Chapel St','04198783');
insert into friend values ('13','Jim Byrne','61 New Rd','04165215');
insert into friend values ('14','Ciara Smyth','11 Chapel St','04198783');
insert into friend values ('15','Ben Jones','34 High St','04267564');
describe hobbies;
insert into hobbies values ('1','golf');
insert into hobbies values ('1','pool');
insert into hobbies values ('1','snooker');
insert into hobbies values ('2','football');
insert into hobbies values ('2','snooker');
insert into hobbies values ('3','golf');
insert into hobbies values ('3','running');
insert into hobbies values ('3','swimming');
insert into hobbies values ('4','swimming');
insert into hobbies values ('4','tennis');
insert into hobbies values ('5','football');
insert into hobbies values ('6','pool');
insert into hobbies values ('6','squash');
insert into hobbies values ('7','running');
insert into hobbies values ('8','swimming');
insert into hobbies values ('8','tennis');
insert into hobbies values ('9','football');
insert into hobbies values ('9','golf');
insert into hobbies values ('9','tennis');
insert into hobbies values ('10','football');
insert into hobbies values ('10','squash');
insert into hobbies values ('11','swimming');
insert into hobbies values ('12','running');
insert into hobbies values ('12','squash');
insert into hobbies values ('12','swimming');
insert into hobbies values ('13','football');
insert into hobbies values ('13','golf');
insert into hobbies values ('13','snooker');
insert into hobbies values ('14','swimming');
insert into hobbies values ('14','tennis');
insert into hobbies values ('15','football');
select * from friend;
select friend.name from friend join hobbies using(friend_id);
select friend.name from friend join hobbies using(friend_id) where hobby = 'golf';
select friend.name, friend.address from friend join hobbies using (friend_id) where hobby = 'football';
select friend.name, friend.address from friend join hobbies using (friend_id) where address like '%Old%';
select distinct friend.name, friend.address from friend join hobbies using (friend_id) where name like '%Byrne';
select * from friend join hobbies using (friend_id) where hobby = 'golf';