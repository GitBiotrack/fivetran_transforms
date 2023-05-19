with 
-- select customers from the nm trace schema
inventorytype as (
    select *
    from {{ source('postgres_cann_replication_public', 'inventorytypes_raw') }}
),
selected as (
    select
        org,
        id,
        regexp_replace(name, '([^[:ascii:]])', '') as inventorytype,
        -- DEI-236
        current_timestamp() as extract_date
    from inventorytype where _fivetran_deleted = false
)

select * from selected
