with 
-- select customers from the nm trace schema

selected as (
    select
        org,
        id,
        regexp_replace(name, '([^[:ascii:]])', '') as inventorytype,
        -- DEI-236
        current_timestamp() as extract_date
    from post_cann_bt_public.inventorytypes_raw where _fivetran_deleted = false
)

select * from selected
