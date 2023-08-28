with source as (
    select
        to_char(d, 'YYYY-MM-DD') as id,
        d as full_date,
        extract(YEAR from d) as year,
        extract(WEEK from d) as week,
        extract(DAY from d) as day,
        extract(YEAR from d) as fiscal_year,
        to_char(d, 'Q') as fiscal_qtr,
        extract(MONTH from d) as month,
        to_char(d, 'Month') as month_name,
        extract(DOW from d) as week_day,
        to_char(d, 'Day') as day_name,
        {{ day_is_weekday('d') }} as day_is_weekday,
        current_timestamp as loaded_at
    from(
        select 
            *
        from 
            generate_series ( '2010-01-01'::date, '2050-05-01'::date, interval '1 day') as d
    ) x
)
select
    *
from source