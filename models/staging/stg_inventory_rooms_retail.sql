with 

selected as(
    select
        org,
        location,
        id,
        coalesce(regexp_replace(roomname, '([^[:ascii:]])', ''), 'NA') as room,
        current_timestamp as extract_date
    from post_cann_bt_public.inventoryrooms_raw where _fivetran_deleted = false
)

select * from selected
