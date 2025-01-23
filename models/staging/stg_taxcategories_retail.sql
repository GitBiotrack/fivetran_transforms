with 
-- select customers from the nm trace schema

selected as  (
    select
        org,
        id,
        name,
        rate,
        rate as taxrate,
        regexp_replace(name, '([^[:ascii:]])', '') as taxname,
        current_timestamp() as extract_date
    from post_cann_public.taxcategories_raw where _fivetran_deleted = false
)
select * from selected
