DELETE FROM finished WHERE Title = 'Title'
--This deletes the row with the title 'your_title_value' as this is 
--an error with uploading the csv as it repeats the column names.


--These are some example queries to show how to use the database.
SELECT * FROM finished WHERE Location = 'Dublin';
-- this code shows the listings in Dublin.
SELECT AVG(Salary) AS AveragePay FROM finished WHERE Salary <> 'Salary not specified';
-- this code shows the average salary.
SELECT * FROM finished WHERE Days_Ago > 28;
-- this code shows the listings that were posted more than 28 days ago.
SELECT * FROM finished WHERE Company = 'Reperio Human Capital';
-- this code shows the listings in Reperio Human Capital.