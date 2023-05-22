with 
-- select customers from the nm trace schema

selected as  (
    select
        orgid as orgid,
        masterorg as masterorg,
        orgname as orgname,
        contact_name as time_zone

    from org where _fivetran_deleted = false
)

select * from selected
