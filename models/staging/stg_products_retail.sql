with 
-- select customers from the nm trace schema

selected as  (
    select distinct
        regexp_replace(name, '([^[:ascii:]])', '') as name,
        org,
        location,
        id as productid,
        productcategory as product_categories_id,
        regexp_replace(manufacturer, '([^[:ascii:]])', '') as manufacturer,
        regexp_replace(producer, '([^[:ascii:]])', '') as producer,
        regexp_replace(productdescription, '([^[:ascii:]])', '') as prod_desc,
        defaultusable  as useable,
        applymemberdiscount,
		case
			when requiresweighing is null then false
			else requiresweighing::boolean
		END as requires_weighing,
        strain,
        inventorytype,
        defaultvendor,
        ismedicated,
        costperunit,
        created,
        current_timestamp() as extract_date
    from post_cann_bt_public.products_raw where _fivetran_deleted = false and productcategory is not null
)
select * from selected
