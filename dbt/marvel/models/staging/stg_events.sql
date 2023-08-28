with source as (
    select 
        id,
        cast(character_id as int) as character_id,
        cast(comics_id as int) as comic_id,
        title as event_title,
        description,
        date(modified_date) as modified_date,
        date(started) as started,
        date(ended) as ended,
        creators,
        creators_role,
        current_timestamp as loaded_at
    from {{ source('staging', 'events') }}
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