with 
-- select customers from the nm trace schema
taxcat as (
    select *
    from {{ source('postgres_cann_replication_public', 'taxcategories_raw') }}
),
selected as  (
    select
        org,
        id,
        name,
        rate,
        rate as taxrate,
        regexp_replace(name, '([^[:ascii:]])', '') as taxname,
        current_timestamp() as extract_date
    from taxcat where _fivetran_deleted = false
)
select * from selected
