{{ config(materialized='table') }}

with date_spine as (
    {{
        dbt.date_spine(
            datepart="day",
            start_date="cast('2020-01-01' as date)",
            end_date="cast('2030-12-31' as date)"
        )
    }}
),

final as (
    select
        date_day as date_day,
        extract(year from date_day)  as year,
        extract(month from date_day) as month,
        extract(day from date_day)   as day,
        date_trunc('week', date_day)  as week_start,
        date_trunc('month', date_day) as month_start
    from date_spine
)

select * from final