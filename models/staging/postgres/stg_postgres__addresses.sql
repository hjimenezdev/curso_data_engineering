with source as (

    select *
    from {{ source('postgres', 'addresses') }}

),

renamed as (
    select
        address_id::text      as address_id,
        zipcode::text         as zipcode,
        country::text         as country,
        address::text         as address,
        state::text           as state
    from source
)

select * from renamed