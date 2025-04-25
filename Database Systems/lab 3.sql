insert into friend (friend_id,name) values (16, 'Mary Jones');
update friend set address = '34 High St',telephone = '04276345' where name = 'Mary Jones';
delete from hobbies where friend_id = 13 and hobby = 'golf';
delete from friend where friend_id = 6 or address like '%Chapel%';