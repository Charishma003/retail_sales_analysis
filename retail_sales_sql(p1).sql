-- create  table
drop table if exists retail_sales;
create table retail_sales
            (
             transactions_id INT primary key,
			 sale_date DATE,
			 sale_time TIME,
			 customer_id INT,
			 gender VARCHAR(15),
			 age INT,
			 category VARCHAR(15),
			 quantity INT,
			 price_per_unit FLOAT,
			 cogs FLOAT,
			 total_sale FLOAT
			);


select * from retail_sales
limit 10;

select count(*) from retail_sales;

 --data cleaning
select * from retail_sales
where transactions_id= null;

select * from retail_sales
where sale_date= null;

select * from retail_sales
where transactions_id is null or sale_time is null or sale_date is null or customer_id is null or
			 gender is null or 
			 age is null or
			 category is null or
			 quantity is null or
			 price_per_unit is null or
			 cogs is null or
			 total_sale is null; 

UPDATE retail_sales
SET age = 54
WHERE age IS NULL;

DELETE from retail_sales
where transactions_id is null or sale_time is null or sale_date is null or customer_id is null or
			 gender is null or 
			 age is null or
			 category is null or
			 quantity is null or
			 price_per_unit is null or
			 cogs is null or
			 total_sale is null;

--data exploration
--how many sales we have?
select count(*) as total_sale from retail_sales;


--how many unique customers we have?
select count( distinct customer_id) as total_sale from retail_sales;

select count( distinct category) as total_sale from retail_sales;

select distinct category  from retail_sales;

--data analysis & business key problems
--q1.write a sql query to retrieve all columns for sales made on '2022-11-05'?

select 
from retail_sales
where sale_date= '2022-11-05';

--q2.write a sql query to retrieve all transcactions where category is 'clothing' and the quantity 
--sold is more than 10 in the month of nov 2022?

select * from retail_sales
where category='Clothing' and TO_CHAR(sale_date,'yyyy-mm')='2022-11' and quantity >= 4;

--q3. write a sql query to calculate the total sales (total_sale) for each category?
select category, sum(total_sale),count(*)as total_orders from retail_sales
group by category;

--q4.write a query to find the avg age of customers who purchased items from beauty category?
select ROUND(AVG(age),2) from retail_sales where category='Beauty';

--q5.write a sql query to find all transactions where the total_sale is greater than 1000?
select * from retail_sales where total_sale>1000;

--q6.write a sql query to find the total no.of transactions (transaction_id)made by
--each gender in each category?
select gender,category,count(transactions_id) from retail_sales
group by gender,category;

--q7.write a sql query to calculate the average sale for each month.fing out best sellimg month
--in each year?
select year,month,avg_sale from
(
SELECT
   EXTRACT(YEAR FROM sale_date) AS year,
   EXTRACT(MONTH FROM sale_date) AS month,
   avg(total_sale) as avg_sale,
   rank() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) order by avg(total_sale) desc) AS RANK
   from retail_sales
   group by 1,2
) as t1
where rank=1;

--q8.write a sql query to find the top 5 customers based on the highest total sales?
select customer_id, sum(total_sale) from retail_sales
group by customer_id
order by sum(total_sale)desc
limit 5;

--q9. write a sql query to find the number of unique customers who purchased items from each category?
select category,count(distinct customer_id) from retail_sales
group by category;


--q10.write a sql query to create each shift and number of orders
--(ex: morning <=12,afternoon between 12& 17, evening >17)
with hourly_sale
as
(
select *,
   CASE
       WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'morning'
	   WHEN EXTRACT(HOUR FROM sale_time) between 12 and 17 THEN 'afternoon'
	   ELSE 'evening'
   END as shift
from retail_sales
)
select shift,count(*)as total_orders
from hourly_sale
group by shift;



