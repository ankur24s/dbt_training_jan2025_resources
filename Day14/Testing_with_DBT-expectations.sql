Debugging Tests and Testing with dbt-expectations


Great Expectation project link:
https://github.com/great-expectations/great_expectations

dbt-expectations: https://github.com/calogica/dbt-expectations

For the final code in packages.yml, models/schema.yml and models/sources.yml, please
refer to the course's Github repo:



TESTING A SINGLE MODEL
dbt test -m dim_listings_w_hosts


Testing individual sources:
dbt test -m source:raw_airbnb.listings


DEBUGGING DBT
dbt --debug test --select dim_listings_w_hosts


Keep in mind that in the lecture we didn't use the --debug_ flag after all as taking a look at
the compiled sql file is the better way of debugging tests












----
Adding expect_column_distinct_count_to_equal:


- name: listings
        identifier: raw_listings
        columns:
          - name: room_type
            tests:
              - dbt_expectations.expect_column_distinct_count_to_equal:
                  value: 4
          - name: price
            tests:
              - dbt_expectations.expect_column_values_to_match_regex:
                  regex: "^\\\\$[0-9][0-9\\\\.]+$"
        
      - name: reviews
        identifier: raw_reviews
		

add in schema.yml

- name: dim_listings_w_hosts
    tests:
      - dbt_expectations.expect_table_row_count_to_equal_other_table:
          compare_model: source('raw_airbnb', 'listings')
    columns:
      - name: price
        tests:
          - dbt_expectations.expect_column_values_to_be_of_type:
              column_type: number
          - dbt_expectations.expect_column_quantile_values_to_be_between:
              quantile: .99
              min_value: 50
              max_value: 500
          - dbt_expectations.expect_column_max_to_be_between:
              max_value: 5000
              config:
                severity: warn