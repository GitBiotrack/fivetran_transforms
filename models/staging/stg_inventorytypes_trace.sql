with 
-- select customers from the nm trace schema
inventorytype as (
    select *
    from {{ source('postgres_cann_replication_public', 'bmsi_inventorytypes_raw') }}
),
selected as  (
    select
        distinct
        org,
        -- in quotations due since these are key words
        id,
        name,
        -- DEI-236
        current_timestamp() as extract_date

    from inventorytype where _fivetran_deleted = false
)

-- final selection
select *
from selected
