
with
-- select pos trans detail
pos_transaction_detail as (
    select *
    from {{ ref('retail_transaction_detail') }}
),

date_for_analysis as (
    select distinct
        transaction_date as date_for_analysis,
        dateadd('month', -12, transaction_date) as previous_24_months
    from {{ ref('retail_transaction_detail') }}
),
-- group by dispensary and summarize customer info
summarize_customers as (
    select
 -- cols for group by
    concat(
        dispensary_id,
        '_',
        person_id_hash,
        '_',
        to_varchar(date_for_analysis.date_for_analysis)
    ) as primary_key,
    dispensary_id as customer_dispensary, -- necessary for the query in looker to work
    person_id_hash as customer_id,
    date_for_analysis.date_for_analysis,
    -- aggs
    count(distinct transaction_id) as customer_lifetime_number_of_transactions,
    count(distinct transaction_item_id_hash ) as customer_lifetime_number_of_items,
    sum(item_final_pretax_price) as customer_lifetime_value,
    min(transaction_date) as customer_first_trans,
    max(transaction_date) as customer_last_trans,

    -- DEI-223
    current_timestamp() as extract_date
from pos_transaction_detail
inner join date_for_analysis
    on pos_transaction_detail.transaction_date <= date_for_analysis.date_for_analysis
    and pos_transaction_detail.transaction_date >= date_for_analysis.previous_24_months
where person_id_hash <> '0000000000'
group by
    concat(
        dispensary_id,
        '_',
        person_id_hash,
        '_',
        to_varchar(date_for_analysis.date_for_analysis)
    ),
    dispensary_id,
    person_id_hash,
    date_for_analysis.date_for_analysis
)

select *
from summarize_customers
