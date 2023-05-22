with 
-- select customers from the nm trace schema

selected as  (
    select
        org,
        location,
        name,
        coalesce(regexp_replace(name, '([^[:ascii:]])', ''), 'NA') as tracecat, ---also known as 'category' in raw_products
        id as product_categories_id,
        current_timestamp() as extract_date
    from productcategories_raw where _fivetran_deleted = false
)

select * from selected
