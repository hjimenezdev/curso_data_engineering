with source as (

    select *
    from {{ source('postgres', 'orders') }}

),

renamed as (

    select
        order_id::text                         as order_id,
        user_id::text                          as user_id,
        address_id::text                       as address_id,
        promo_id::text                         as promo_id,
        shipping_service::text                 as shipping_service,
        replace(shipping_cost, ',', '.')::number(10,2) as shipping_cost,
        replace(order_cost, ',', '.')::number(10,2)    as order_cost,
        replace(order_total, ',', '.')::number(10,2)   as order_total,
        status::text                           as status,
        tracking_id::text                      as tracking_id,
        created_at::timestamp_ntz              as created_at,
        estimated_delivery_at::timestamp_ntz   as estimated_delivery_at,
        delivered_at::timestamp_ntz            as delivered_at
    from source
)

select * from renamed