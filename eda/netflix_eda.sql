select * from netflixusers;

select join_date from netflixusers;

-- how many customers are active
select count(*)
from netflixusers
where Last_Payment_Date > '2023-12-31';

-- how many subscribers for each subscription type
select Subscription_Type, count(Subscription_Type) as num_subscibers
from netflixusers
group by Subscription_Type;

-- avg length of stay
select min(datediff(last_payment_date, join_date))
from netflixusers
where Join_Date < Last_Payment_Date;

-- how many customers of the 2 reported genders
select gender, count(Gender) as count_reported_gender
from netflixusers
group by Gender;

-- how many customers of the 2 reported genders using each device type
select gender, device, count(*) as device_count
from netflixusers
group by gender, device
order by gender, device;

-- count number of customers in reported countries
select country, count(*) as customer_count
from netflixusers
group by country
order by country;

-- for each device type, how many customers in each country use it
select device, country, count(*) as customer_count
from netflixusers
group by device, country
order by device, customer_count desc;

-- revenue generated from each customer, assuming the same plan since they joined
select user_id, Monthly_Revenue * Last_Payment_Date - Join_Date as rev_per_customer
from netflixusers
where Last_Payment_Date > Join_Date
group by user_id;

-- what is the ratio of male-female subscribers in each country
with male_cust as (
	select country, count(user_id) as male_user_count
	from netflixusers
	where Gender = 'Male'
	group by Country
),
female_cust as (
	select country, count(user_id) as female_user_count
    from netflixusers
    where gender = 'Female'
    group by country
)
select male_cust.country, male_cust.male_user_count/female_cust.female_user_count as male_female_ratio
from male_cust, female_cust
where male_cust.country = female_cust.country
order by male_female_ratio asc;

-- which device type subgroup has average customer age greater than the average across all customers
select device, avg(age)
from netflixusers
group by Device
having avg(age) > (
	select avg(age)
	from netflixusers
);

-- which device type subgroup has average customer age less than the average across all customers
select device, avg(age)
from netflixusers
group by Device
having avg(age) < (
	select avg(age)
	from netflixusers
);

-- for each country, which subscription type is most common
with overall_sub_counts as (
	select country, Subscription_Type, count(*) as subscription_count
	from netflixusers
	group by country, Subscription_Type
	order by country, subscription_count desc
)
select nu.country, max(subscription_count)
from netflixusers nu, overall_sub_counts osc 
where nu.country = osc.country
group by nu.country;

-- what percentage of total customers has been with Netflix for over 5 years from the current/today’s date
select datediff(now(), join_date)/365
from netflixusers
where join_date < now();

---------------------------------------------------------------------------------------------------



-- group by continent, gender, age buckets, device -> get customer count for each device type
select distinct country
from netflixusers;

select 
case
	when age < 30 then 'low'
    when age > 30 and age < 60 then 'middle'
    else 'high'
end as age_bracket, count(*)
from netflixusers
group by age_bracket;

select
case
	when datediff(last_payment_date, join_date)/365 < 5 then 'low'
    when datediff(last_payment_date, join_date)/365 > 5 and datediff(last_payment_date, join_date)/365 < 10 then 'mid'
    else 'hi'
end as length_of_stay, count(*)
from netflixusers
where join_date < last_payment_date
group by length_of_stay;


select device, country, gender, age, count(*)
from netflixusers
group by device, country, gender, age
order by device, country desc;



