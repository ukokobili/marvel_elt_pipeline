with source as (
    select
        id,
        character_name,
        description,
        modified_date,
        current_timestamp as loaded_at
    from {{ ref('stg_characters') }}
)
select
    *
from source