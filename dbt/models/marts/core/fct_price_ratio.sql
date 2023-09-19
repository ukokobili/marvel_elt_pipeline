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
        s.id as series_id,
        e.id as event_id,
        t.id as stories_id,
        c.modified_date,
        c.number_of_pages,
        c.print_price,
        c.digital_purchase_price,
        coalesce(c.print_price / nullif(c.digital_purchase_price, 0), 0) as price_ratio,
        current_timestamp as loaded_at
    from {{ ref('stg_comics') }} c
    left join {{ ref('stg_characters') }} x
    on c.character_id = x.id
    left join {{ ref('stg_series') }} s
    on c.id = s.comic_id
    left join {{ ref('stg_events') }} e
    on c.id = e.comic_id
    left join {{ ref('stg_stories') }} t
    on c.id = t.comic_id
)
select 
    *
from source

{% if is_incremental() %}
    where modified_date > (select max(modified_date) from {{ this }})
{% endif %}
