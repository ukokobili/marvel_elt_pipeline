with source as (
    select 
        id,
        name as character_name,
        description,
        date(modified_date) as modified_date,
        current_timestamp as loaded_at
    from {{ source('staging', 'characters') }}
)
select
    *
from source