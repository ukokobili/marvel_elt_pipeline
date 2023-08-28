with source as (
    select 
        id,
        cast(character_id as int) as character_id,
        cast(comics_id as int) as comic_id,
        title as series_title,
        description,
        date(modified_date) as modified_date,
        cast(start_year as int) as start_year,
        cast(end_year as int) as end_year,
        rating,
        type,
        current_timestamp as loaded_at
    from {{ source('staging', 'series') }}
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