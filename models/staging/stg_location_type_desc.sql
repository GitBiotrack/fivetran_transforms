with 
-- select customers from the nm trace schema

selected as  (
    select
        description as description,
        state as state,
        locationtype as locationtype
    from location_type_desc where _fivetran_deleted = false
)

select *
from selected
