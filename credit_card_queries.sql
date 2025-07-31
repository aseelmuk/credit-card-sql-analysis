--1) 5 cities with highest spends and their percentage contribution of
--total credit card spends 


with cte as (select city,sum(amount) as total_spent 
from credit_card_transactions
group by city)

,cte2 as (select *
,sum(total_spent) over (order by total_spent desc rows between unbounded preceding and unbounded following ) as total_amt
from cte)

select top 5 city,total_spent,(total_spent/total_amt)*100 as share
from cte2
order by total_spent desc


--2) Highest spend month and amount spent in that month for each card type


with cte as (select card_type,datepart(year,transaction_date) as yr,datepart(month,transaction_date) as mnt,sum(amount) as total_spent
from credit_card_transactions
group by datepart(year,transaction_date),datepart(month,transaction_date),card_type)

,cte2 as (select * ,rank() over (partition by card_type order by total_spent desc) as rnk
from cte)

select card_type,yr,mnt,total_spent
from cte2
where rnk=1


--3) Print the transaction details(all columns from the table) for each card type when
--it reaches a cumulative of  1,000,000 total spends(We should have 4 rows in the o/p one for each card type)

with cte as (
select *,sum(amount) over(partition by card_type order by transaction_date,transaction_id) as total_spend
from credit_card_transactions
)
select * from (select *, rank() over(partition by card_type order by total_spend) as rn  
from cte where total_spend >= 1000000) a where rn=1

--4) City which had lowest percentage spend for gold card type

with cte as (select city,sum(case when card_type='gold' then amount end) as gold_amt,sum(amount) as total_amt
from credit_card_transactions
group by city)

select top 1 city,gold_amt*1.0/total_amt as gold_percent
from cte
where gold_amt is not null
order by gold_percent asc


--5) Get highest and lowest expense type for each city

with cte as (
select city,exp_type, sum(amount) as total_amount from credit_card_transactions
group by city,exp_type)
select
city , max(case when rn_asc=1 then exp_type end) as lowest_exp_type
, min(case when rn_desc=1 then exp_type end) as highest_exp_type
from
(select *
,rank() over(partition by city order by total_amount desc) rn_desc
,rank() over(partition by city order by total_amount asc) rn_asc
from cte) A
group by city;

--6) Find percentage contribution of spends by females for each expense type

select exp_type,
sum(case when gender='F' then amount else 0 end)*1.0/sum(amount) as percentage_female_contribution
from credit_card_transactions
group by exp_type
order by percentage_female_contribution desc;

--7) which card and expense type combination saw highest month over month growth in Jan-2014

with cte as (
select card_type,exp_type,datepart(year,transaction_date) yt
,datepart(month,transaction_date) mt,sum(amount) as total_spend
from credit_card_transactions
group by card_type,exp_type,datepart(year,transaction_date),datepart(month,transaction_date)
)
select  top 1 *, (total_spend-prev_mont_spend) as mom_growth
from (
select *
,lag(total_spend,1) over(partition by card_type,exp_type order by yt,mt) as prev_mont_spend
from cte) A
where prev_mont_spend is not null and yt=2014 and mt=1
order by mom_growth desc;

--8) During weekends which city has highest total spend to total no of transcations ratio 

select top 1 city , sum(amount)*1.0/count(1) as ratio
from credit_card_transactions
where datepart(weekday,transaction_date) in (1,7)
group by city
order by ratio desc;

--9) Which city took least number of days to reach its
--500th transaction after the first transaction in that city;


with cte as (
select *
,row_number() over(partition by city order by transaction_date,transaction_id) as rn
from credit_card_transactions)
select top 1 city,datediff(day,min(transaction_date),max(transaction_date)) as datediff1
from cte
where rn=1 or rn=500
group by city
having count(1)=2
order by datediff1 











