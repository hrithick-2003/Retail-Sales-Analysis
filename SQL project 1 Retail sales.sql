SQL Retail Analysys

create table retail_sales
(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id	int,
gender varchar(15),
age	int,
category varchar(20),
quantiy	float,
price_per_unit float,
cogs float,
total_sale float
)

Data updated using Excel file

select* from retail_sales

----Data cleaning----

select* from retail_sales
where
transactions_id is Null
OR
sale_date is Null
OR
sale_time is Null
OR
customer_id is Null 
OR
gender is Null 
OR
category is Null 
OR
quantiy is Null 
OR
price_per_unit is Null 
OR
cogs is Null 
OR
total_sale is Null 

delete from retail_sales
where
transactions_id is Null
OR
sale_date is Null
OR
sale_time is Null
OR
customer_id is Null 
OR
gender is Null 
OR
category is Null 
OR
quantiy is Null 
OR
price_per_unit is Null 
OR
cogs is Null 
OR
total_sale is Null 

select count(*) from retail_sales

--- Data cleaning completed -----

----- Data exploration -----

--- How many sale we have ---

select count(*) as total_sales from retail_sales

--- Questiton ---

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select* from retail_sales
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of 
Nov-2022

select* from retail_sales
where
category = 'Clothing'
and
to_char(sale_date,'YYYY-MM') = '2022-11'
and
quantiy >=3


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select 
category,
SUM(total_sale) as net_sales,
count(*) as total_orders
from retail_sales
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select* from retail_sales

select 
Round(AVG(age),2) as avg_age
from retail_sales 
where category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select* from retail_sales
where total_sale>=1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select
category,
gender,
count(*) as total_sales
from retail_sales
group by category, gender

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select* from 
(
select
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	avg(total_sale),
	rank() over	(partition by extract(year from sale_date) order by avg(total_sale)desc) as rank
from retail_sales
group by 1, 2) as t1
 where rank = 1

 -- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select
customer_id,
sum(total_sale) as sales
from retail_sales
group by 1
order by 2 desc
limit (5)

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select
category,
count(distinct customer_id) as unique_customer
from retail_sales
group by 1

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with shift_sale 
as
(
select *,
	case
		when extract(hour from sale_time) < 12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
from retail_sales
)
select
shift,
count(*) as total_orders
from shift_sale
group by shift

--- END PROJECT ---