with 
-- select customers from the nm trace schema
tickets as (
    select *
    from {{ source('postgres_cann_replication_public', 'tickets_raw') }}
),
selected as  (
    select

        org,

        current_timestamp() as extract_date,
        userid as employee_userid,
        location,
        coalesce(transactionid, id :: float) as transactionid,
        id as ticketid,
        ROW_NUMBER() OVER (PARTITION BY id, org, location ORDER BY datetime DESC) as rank,
        datetime,
        to_timestamp(datetime) as datetime_timestamp

    from tickets where _fivetran_deleted = false
)
select * from selected where ticketid is not null 
