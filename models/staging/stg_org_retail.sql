with 
-- select customers from the nm trace schema
org as (
    select *
    from {{ source('postgres_cann_replication_public', 'org') }}
),
selected as  (
    select
        orgid as orgid,
        masterorg as masterorg,
        orgname as orgname,
        contact_name as time_zone

    from org where _fivetran_deleted = false
)

select * from selected
