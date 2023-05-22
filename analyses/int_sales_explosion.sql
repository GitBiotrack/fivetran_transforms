with 
sales as (
    select *
    from {{ ref('stg_retail__sales') }}
),

with products_logs as (
    select *
    from {{ ref('stg_retail__products_logs') }}
),

joined as (
    select
        
        sales.id as saleid,
        sales.productid

    from sales
    left join discounts on discounts.saleid = sales.id 
),

counted as (
    select 
        count(*),
        count(distinct saleid)
    from joined
)

select  
    count(*),
    count(distinct saleid)
from counted