with 
-- select customers from the nm trace schema
inventoryrooms as (
    select *
    from {{ source('postgres_cann_replication_public', 'inventoryrooms_raw') }}
),
selected as(
    select
        org,
        location,
        id,
        coalesce(regexp_replace(roomname, '([^[:ascii:]])', ''), 'NA') as room,
        current_timestamp as extract_date
    from inventoryrooms where _fivetran_deleted = false
)

select * from inventoryrooms
