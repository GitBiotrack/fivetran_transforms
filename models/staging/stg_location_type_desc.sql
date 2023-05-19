with
location_type_desc as (
    select
        description as description,
        state as state,
        locationtype as locationtype
    from postgres_cann_replication_public.location_type_desc where _fivetran_deleted = false
)

select *
from location_type_desc
