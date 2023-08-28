with source as (
    select 
        id,
        cast(character_id as int) as character_id,
        title as comic_title,
        description,
        date(modified_date) as modified_date,
        cast(number_of_pages as int) as number_of_pages,
        cast(print_price as float) as print_price,
        cast(digital_purchase_price as float) as digital_purchase_price, 
        current_timestamp as loaded_at
    from {{ source('staging', 'comics') }}
    where modified_date not like '%-0001-11-30T00:00:00-0500%'
),
deduplication as (
    select
        *,
        row_number() over (partition by id) as dedup
    from source
)
select
    *
from deduplication 
where dedup = 1