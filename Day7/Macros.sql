Marcos, Custom Tests and Packages
MACROS
The contents of macros/no_nulls_in_columns.sql :
{% macro no_nulls_in_columns(model) %}
 SELECT * FROM {{ model }} WHERE
 {% for col in adapter.get_columns_in_relation(model) -%}
 {{ col.column }} IS NULL OR
 {% endfor %}
 FALSE
{% endmacro %}
The contents of tests/no_nulls_in_dim_listings.sql
{{ no_nulls_in_columns(ref('dim_listings_cleansed')) }}
CUSTOM GENERIC TESTS
The contents of macros/positive_value.sql
{% test positive_value(model, column_name) %}
SELECT
 *
FROM
 {{ model }}
WHERE
 {{ column_name}} < 1
{% endtest %}
PACKAGES
The contents of packages.yml :
packages:
 - package: dbt-labs/dbt_utils
 version: 0.8.0
The contents of models/fct_reviews.sql :
{{
 config(
 materialized = 'incremental',
 on_schema_change='fail'
 )
}}
WITH src_reviews AS (
 SELECT * FROM {{ ref('src_reviews') }}
)
SELECT
 {{ dbt_utils.surrogate_key(['listing_id', 'review_date', 'reviewer_name', 'review_text']) }}
 AS review_id,
 *
 FROM src_reviews
WHERE review_text is not null
{% if is_incremental() %}
 AND review_date > (select max(review_date) from {{ this }})
{% endif %}