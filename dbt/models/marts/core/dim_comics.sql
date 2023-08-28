with source as (
    select
        id,
        comic_title,
        description
    from {{ ref('stg_comics') }}
)
select
    *
from source