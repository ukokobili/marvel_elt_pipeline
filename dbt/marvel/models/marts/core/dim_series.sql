with source as (
    select
        id,
        series_title,
        description,
        modified_date,
        start_year,
        end_year,
        rating,
        type,
        current_timestamp as loaded_at
    from {{ ref('stg_series') }}
)
select
    *
from source