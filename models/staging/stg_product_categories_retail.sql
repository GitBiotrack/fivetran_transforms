with 
-- select customers from the nm trace schema

selected as  (
    select
        org,
        location,
        name,
        coalesce(regexp_replace(name, '([^[:ascii:]])', ''), 'NA') as tracecat, ---also known as 'category' in raw_products
        id as product_categories_id,
        current_timestamp() as extract_date,
        c.new_category,
        c.sub_category 
    from postgres_cann_replication_public.productcategories_raw p left join
    postgres_cann_replication_public.cat_mapping c on p.name = c.source_category
    where _fivetran_deleted = false
)

select * from selected
