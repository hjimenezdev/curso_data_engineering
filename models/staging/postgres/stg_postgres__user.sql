{{ config(materialized='view') }}

WITH src_user AS (
    SELECT * FROM {{ source('postgres', 'user') }}
),

renamed_casted AS (
    SELECT
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
        , _fivetran_synced AS date_load
    FROM src_user
)

SELECT * FROM renamed_casted