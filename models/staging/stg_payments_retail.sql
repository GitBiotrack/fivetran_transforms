with 
-- select customers from the nm trace schema
payments as (
    select *
    from {{ source('postgres_cann_replication_public', 'payments_raw') }}
),
selected as  (
    select
        org,
        location,
        -- group each payment method cell into a comma separated list
        listagg(paymentmethod, ',') as paymentmethod,
        ticketid,
        current_timestamp() as extract_date

    from payments where _fivetran_deleted = false
    group by
        org,
        location,
        ticketid
)
select * from selected where ticketid is not null
