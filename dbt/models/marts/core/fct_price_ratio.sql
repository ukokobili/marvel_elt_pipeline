{{
    config(
        materialized = 'incremental',
        on_schema_change= 'fail'
    )
}}

with source as (
    select
        c.id as comic_id,
        x.id as character_id,
        c.modified_date,
        c.number_of_pages,
        c.print_price,
        c.digital_purchase_price,
        coalesce(c.print_price / nullif(c.digital_purchase_price, 0), 0) as price_ratio,
        current_timestamp as loaded_at
    from {{ ref('stg_comics') }} c
    left join {{ ref('stg_characters') }} x
    on c.character_id = x.id
)
select 
    *
from source

# incremental model
{% if is_incremental() %}
    where modified_date > (select max(modified_date) from {{ this }})
{% endif %}
