{{ config(materialized='view') }}

WITH src_promos AS (
    SELECT * FROM {{ source('postgres','promos') }}
),

renamed_casted AS (
    SELECT
        promo_id
        , discount
        , status
        , _fivetran_deleted
        , _fivetran_synced AS date_load
    FROM src_promos
)

SELECT * FROM renamed_casted