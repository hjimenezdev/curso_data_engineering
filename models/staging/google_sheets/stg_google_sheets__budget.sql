---------------------- Vista NO incremental ----------------------

 {{ config(materialized='view') }}

WITH src_budget AS (
    SELECT * FROM {{ source('google_sheets','budget') }}
),

renamed_casted AS (
    SELECT
        _row
        , product_id
        , quantity
        , month
        , _fivetran_synced AS date_load
    FROM src_budget
)

SELECT * FROM renamed_casted 

---------------------- Estrategia MERGE - Transient table ----------------------
/* 
 {{ config(
    materialized='incremental',
    unique_key='_row',
    incremental_strategy='merge'
) }}

WITH src_budget AS (
    SELECT * FROM {{ source('google_sheets','budget') }}
),

renamed_casted AS (
    SELECT
        _row
        , product_id
        , quantity
        , month
        , _fivetran_synced AS date_load
    FROM src_budget
    {% if is_incremental() %}
        WHERE date_load > (SELECT MAX(date_load) FROM {{ this }})
    {% endif %}
)

SELECT * FROM renamed_casted */

---------------------- Estrategia APPEND - Temporary table ----------------------
/*
 {{ config(
    materialized='incremental',
    incremental_strategy='append'
) }}

WITH src_budget AS (
    SELECT * FROM {{ source('google_sheets','budget') }}
),

renamed_casted AS (
    SELECT
        _row
        , product_id
        , quantity
        , month
        , _fivetran_synced AS date_load
    FROM src_budget
    {% if is_incremental() %}
        WHERE date_load > (SELECT MAX(date_load) FROM {{ this }})
    {% endif %}
)

SELECT * FROM renamed_casted */

---------------------- Estrategia DELETE+INSERT (por partición) - Temporary table ----------------------
/* {{ config(
    materialized='incremental',
    unique_key='_row',
    incremental_strategy='delete+insert'
) }}

WITH src_budget AS (
    SELECT * FROM {{ source('google_sheets','budget') }}
),

renamed_casted AS (
    SELECT
        _row
        , product_id
        , quantity
        , month
        , _fivetran_synced AS date_load
    FROM src_budget
    {% if is_incremental() %}
        WHERE date_load > (SELECT MAX(date_load) FROM {{ this }})
    {% endif %}
)

SELECT * FROM renamed_casted */