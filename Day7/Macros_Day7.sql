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
