with 
-- select customers from the nm trace schema

selected as  (
    select
        orgid as orgid,
        masterorg as masterorg,
        orgname as orgname,
        contact_name as time_zone

    from post_cann_public.org where _fivetran_deleted = false
)

select * from selected
