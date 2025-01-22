{% macro learn_variables() %}

{% set my_name = 'Ankur' %}

{{log("Hello " ~ my_name, info=True)}}
{{log("Hello " ~ var("user_name") ~ "!", info=True)}}

{% endmacro %}





{# dbt run-operation learn_variables#}