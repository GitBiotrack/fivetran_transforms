with 
-- select customers from the nm trace schema

selected as (
    select
        org,
        orgid,
        location,
        productname,
        id,
        id as productid,
        inventorytype as inventorytypeid,
        requiresweighing,
        ismedicated,
        usableweight,
        strain,
        straintype,
        packageweight,
        sessiontime,
        to_timestamp(sessiontime) as sessiontime_timestamp,
        adjustedsofar,
        current_timestamp() as extract_date,
        ppl_product_ppl_id as manufacturer

    from post_cann_bt_public.bmsi_inventory_raw where _fivetran_deleted = false
)

--final selection
select *
from selected
