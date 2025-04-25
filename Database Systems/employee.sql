create table employee( employee_number int NOT NULL,
employee_name varchar(20),
DOB date,
salary decimal(10,2),
start_date date,
Permanent enum('T','F'),
PRIMARY KEY (employee_number));
insert into employee values (1234, "Kevin O Neill", '1976-02-23', 45000.00,'1996-07-01', "T");
insert into employee values (2157, "Maura Clarke", '1981-09-16', 42000.00,'2003-09-15', "T");
insert into employee values (2513, "Ciara Murphy", '1980-01-07', 44500.00,'1999-03-30', "T");
insert into employee values (3215, "Mark Byrne", '1975-11-09', 39800.00,'1996-01-17', "T");
insert into employee values (4352, "Orla Ferris", '1984-02-18', 43000.00,'2005-03-20', "T");
insert into employee values (5623, "Anne Duffy", '1989-07-23', 31000.00,'2007-06-07', "T");
insert into employee values (5823, "Paul Mooney", '1984-04-14', 29000.00,'2005-03-20', "T");
insert into employee values (6354, "Mary Kane", '1990-09-30', 18000.00,'2008-08-12', "F");
insert into employee values (6557, "Lorcan Mc Cann", '1988-03-12', 26000.00,'2007-06-03', "T");
insert into employee values (6619, "Adam Kelly", '1990-08-06', 20000.00,'2008-10-08', "F");
select * from employee where permanent ='t';
select * from employee where permanent !='f';
select * from employee where employee_number like '%2%';
select * from employee where DOB > '1976-01-01';
select * from employee where salary > 38000;
select * from employee where salary/12  >= 4000;
select employee_name, format(salary/12,2) as monthly_pay from employee;
select employee_name, truncate((datediff(curdate(),DOB)/365),0) AS age from employee;
select * from employee where month(DOB) = 2;
select * from employee where year(start_date) = 2008;