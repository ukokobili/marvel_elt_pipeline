with source as (
    select
        x.character_name,
        c.comic_title,
        f.modified_date as comic_modified_date,
        e.event_title,
        e.started as event_started,
        e.ended as event_ended,
        e.creators as event_creators,
        e.creators_role as event_creators_role,
        s.series_title,
        s.start_year as series_start_year,
        s.end_year as series_end_year,
        s.rating as series_rating,
        s.type as series_type,
        t.stories_title,
        t.type as stories_type,
        d.year,
        d.week,
        d.day,
        d.month,
        d.month_name,
        d.week_day,
        d.day_name,
        d.day_is_weekday,
        f.number_of_pages,
        f.print_price,
        f.digital_purchase_price,
        f.price_ratio,
        current_timestamp as loaded_at
    from {{ ref("fct_price_ratio") }} f
    left join {{ ref("dim_comics") }} c on f.comic_id = c.id
    left join {{ ref("dim_events") }} e on f.event_id = e.id
    left join {{ ref("dim_character") }} x on f.character_id = x.id
    left join {{ ref("dim_series") }} s on f.series_id = s.id
    left join {{ ref("dim_stories") }} t on f.stories_id = t.id
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