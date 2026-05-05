select
    user_id
    , updated_at
    , address_id
    , last_name
    , created_at
    , phone_number
    , total_orders
    , first_name
    , email
    , _fivetran_deleted
    , date_load
from {{ ref('stg_postgres__user') }}