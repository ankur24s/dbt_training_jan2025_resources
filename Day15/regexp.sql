 select regexp_substr(price,'^\\$[0-9][0-9\\.]+$'),
    regexp_instr(price,'^\\$[0-9][0-9\\.]+$'),
    price from raw.airbnb.raw_listings

---------------

  - name: price
            tests:
              - dbt_expectations.expect_column_values_to_match_regex:
                  regex: "^\\\\$[0-9][0-9\\\\.]+$"
				  
----------------------
