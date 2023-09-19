with source as (
    select
        x.character_name,
        c.comic_title,
        f.modified_date as comic_modified_date,
        f.number_of_pages,
        f.print_price,
        f.digital_purchase_price,
        f.price_ratio,
        d.year,
        d.week,
        d.day,
        d.month,
        d.month_name,
        d.week_day,
        d.day_name,
        d.day_is_weekday,
        current_timestamp as loaded_at
    from {{ ref("fct_price_ratio") }} f
    left join {{ ref("dim_comics") }} c on f.comic_id = c.id
    left join {{ ref("dim_character") }} x on f.character_id = x.id
    left join {{ ref("dim_date") }} d on f.modified_date = d.full_date
),
deduplication as (
    select
        *,
        row_number() over (partition by comic_title, comic_modified_date) as dup
    from source
)
select
    *
from deduplication 
where dup = 1