with source as (
    select
        id,
        event_title,
        description,
        modified_date,
        started,
        ended,
        creators,
        creators_role,
        current_timestamp as loaded_at
    from {{ ref('stg_events') }}
)
select
    *
from source