select
    order_id,
    user_id,
    address_id,
    promo_id,
    shipping_service,
    shipping_cost,
    order_cost,
    order_total,
    status,
    tracking_id,
    created_at,
    estimated_delivery_at,
    delivered_at
from {{ ref('stg_postgres__orders') }}
