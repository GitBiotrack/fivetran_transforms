
-- inventory table uniqueuness

-- notes
-- (inventory)id is unique, it is not sequential
-- each productid has multiple (inventory)ids
-- each productid has multiple strains
-- each productid can have multiple cost_per_units
-- each productid can have multiple sessiontimes
-- 90% productids have an associated cost
-- 75% of productids have an associated cost in the most recent entry

-- conclusion:
    -- (inventory)id is unique
    -- it is not sequential but sessiontime informs us on the most recent entry per product
    -- productid is not unique nor does it have a one to one relationship with other columns

-- reference
select
    *
from bt_4206_public.inventory
limit 20

-- columns we use
select
    strain,
    location,
    productid,
    id,
    expiration,
    straintype,
    cost_per_unit,
    pricein,
    vendorid,
    -- not used
    sessiontime,
    remainingweight,
    parentid,
    inventoryparentid,
    replication_val,
    transactionid
from bt_4206_aws.inventory
limit 10

-- (inventory)id is unique, it is not sequential
select 
    id,
    count(*)
from bt_4206_aws.inventory
group by id
having count(*) > 1
order by count desc

-- each productid has multiple (inventory)ids
select
    productid,
    count(distinct id)
from bt_4206_aws.inventory
group by productid
having count(distinct id) > 1
order by count desc

-- each productid has multiple strains
select
    productid,
    count(distinct strain)
from bt_4206_aws.inventory
group by productid
having count(distinct strain) > 1
order by count desc

-- straintype is null
select
    productid,
    count(distinct straintype)
from bt_4206_aws.inventory
group by productid
having count(distinct straintype) > 1
order by count desc

select *
from bt_4206_aws.inventory
where straintype is not null

-- expiration is null
select
    productid,
    count(distinct expiration)
from bt_4206_aws.inventory
group by productid
having count(distinct expiration) > 1
order by count desc

select *
from bt_4206_aws.inventory
where expiration is not null

-- each productid can have multiple cost_per_units
select
    productid,
    count(distinct cost_per_unit)
from bt_4206_aws.inventory
group by productid
having count(distinct cost_per_unit) > 1
order by count desc

-- eg above
select
    productid,
    cost_per_unit
from bt_4206_aws.inventory
where productid = 5293

-- a productid can have multiple sessiontimes
select
    productid,
    location,
    count(distinct sessiontime)
from bt_4206_public.inventory
group by productid, location
having count(distinct sessiontime) > 1
order by count desc

-- eg above
select
    location,
    productid,
    sessiontime
from bt_4206_public.inventory
where productid = 10161

-- 90% of products have a cost
select 
    count(distinct case when cost_per_unit is not null then productid end),
    count(distinct productid)
from bt_4206_aws.inventory

-- 75% have a cost with the most recent entry
with x as (
select
    productid,
    cost_per_unit,
    sessiontime,
    row_number() over (partition by productid order by sessiontime desc) as r
from bt_4206_aws.inventory
)
select 
    count(case when cost_per_unit is not null then 1 end),
    count(distinct productid)
from x
where r = 1

-- multiple locations per productid
select
    productid,
    count(distinct location)
from bt_4206_public.inventory
group by productid
having count(distinct location) > 1

-- 
select 
    strain,
    location,
    productid,
    id,
    expiration,
    straintype,
    cost_per_unit,
    sessiontime
from bt_4206_public.inventory
where productid = 23
    and location = 1
order by sessiontime desc

with x as (
select 
    id,
    location,
    productid,
   sessiontime,
    row_number() over (partition by productid, location order by sessiontime desc) as r
from bt_4206_public.inventorylog
where productid = 23
    and location = 1
order by sessiontime desc
)
select *
from x
where r = 1

select 
    id,
    location,
    productid,
   sessiontime
from bt_4206_public.inventory
--where productid = 23
--    and location = 1
where id = '6319528177849990'
order by sessiontime desc

select 
    id,
    location,
    productid,
   sessiontime
from bt_4206_public.inventorylog
where id = '6163075737007420'

-- most recent sessiontime for product-location does not reflect 