{% macro day_is_weekday(d) -%}
    
    case 
        when to_char({{ d }}, 'Day') in ('Sunday', 'Saturday') then 'Weekend'
        else 'Weekday'
    end

{%- endmacro %}
