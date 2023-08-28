with source as (
    select
        id,
        stories_title,
        description,
        modified_date,
        type,
        current_timestamp as loaded_at
    from {{ ref('stg_stories') }}
)
select
    *
from source