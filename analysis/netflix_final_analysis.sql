
-- for active customers, group by time buckets, count the customers 
-- calc % of grand total of active customers – # of active in each bucket/grand total of active across the dataset
with length_and_status as (
	select user_id,
    case 
		when datediff(last_payment_date, join_date)/365 <= 3 then '0-3 years'
        when datediff(last_payment_date, join_date)/365 > 3 and datediff(last_payment_date, join_date)/365 <= 7 then '4-7 years'
        when datediff(last_payment_date, join_date)/365 > 7 and datediff(last_payment_date, join_date)/365 <= 11 then '8-11 years'
        when datediff(last_payment_date, join_date)/365 > 11 and datediff(last_payment_date, join_date)/365 <= 15 then '12-15 years'
        else '16+ years'
	end as length_of_stay,
	case 
		when month(last_payment_date) < 12 and year(Last_Payment_Date) < 2023 then 'inactive'
		else 'active'
	end as account_status
	from netflixusers
	where Last_Payment_Date > join_date
),
grand_active as (
	select sum(if(account_status = 'active', 1, 0)) as grand_total_active
    from length_and_status
),
active_counts as (
	select length_of_stay, sum(if(account_status = 'active', 1, 0)) as active_count
	from length_and_status las
	group by length_of_stay
)
select length_of_stay, active_count/grand_total_active as percent_of_total_active
from active_counts, grand_active
order by percent_of_total_active desc;

-------------------------------------------------------------------------------------------------

-- group by device, continent, age_bucket, get active count for each group
select user_id,
device,
country,
case 
	when country in ('United States', 'Canada', 'Mexico') then 'North America'
    when country in ('United Kingdom', 'Germany', 'France', 'Spain', 'Italy') then 'Europe'
    when country in ('Brazil') then 'South America'
    else 'Australia'
end as continent,
case 
	when age <= 30 then '0-30'
    when age > 30 and age <= 40 then '31-40'
    when age > 40 and age <= 50 then '41-50'
    when age > 50 and age <= 60 then '51-60'
    else '61+'
end as age_bucket,
case 
		when month(last_payment_date) < 12 and year(Last_Payment_Date) < 2023 then 0
		else 1 end as active
from netflixusers
where last_payment_date > join_date
group by user_id, device, country, continent, age_bucket
order by device, age_bucket;


-- account status based on device and continent
with device_and_status as (
	select user_id,
			device,
            case 
	when country in ('United States', 'Canada', 'Mexico') then 'North America'
    when country in ('United Kingdom', 'Germany', 'France', 'Spain', 'Italy') then 'Europe'
    when country in ('Brazil') then 'South America'
    else 'Australia'
end as continent,
			case 
				when month(last_payment_date) < 12 and year(last_payment_date) < 2023 then 'inactive'
				else 'active'
			end as account_status
	from netflixusers
	where last_payment_date > join_date
)
select device, 
		continent,
        sum(if(account_status = 'active', 1, 0)) as active_count,
		count(user_id) as total_count,
		sum(if(account_status = 'active', 1, 0))/count(user_id) as local_retention_rate
from device_and_status
group by device, continent
order by device;

-- generate an ‘active’ column – assuming that a last_payment_date that is before {Dec 2023} is an inactive account
-- get active count
with length_and_status as (
	select user_id,
    case 
		when datediff(last_payment_date, join_date)/365 <= 3 then '0-3 years'
        when datediff(last_payment_date, join_date)/365 > 3 and datediff(last_payment_date, join_date)/365 <= 7 then '4-7 years'
        when datediff(last_payment_date, join_date)/365 > 7 and datediff(last_payment_date, join_date)/365 <= 11 then '8-11 years'
        when datediff(last_payment_date, join_date)/365 > 11 and datediff(last_payment_date, join_date)/365 <= 15 then '12-15 years'
        else '16+ years'
	end as length_of_stay,
	case 
		when month(last_payment_date) < 12 and year(Last_Payment_Date) < 2023 then 'inactive'
		else 'active'
	end as account_status
	from netflixusers
	where Last_Payment_Date > join_date
)
select user_id, length_of_stay, 
if(account_status = 'active', 1, 0) as active
from length_and_status las
group by user_id, length_of_stay;
