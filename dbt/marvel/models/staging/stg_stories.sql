with source as (
    select 
        id,
        cast(character_id as int) as character_id,
        cast(comics_id as int) as comic_id,
        title as stories_title,
        description,
        date(modified_date) as modified_date,
        type,
        current_timestamp as loaded_at
    from {{ source('staging', 'stories') }}
    
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