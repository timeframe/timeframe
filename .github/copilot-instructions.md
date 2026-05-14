# Copilot Instructions

## Validation Checklist

Before considering any task complete, always run all of the following checks and fix any issues:

1. **Tests & Coverage (ha-addon):** `cd ha-addon && bundle exec rake test` — all tests must pass with 100% line coverage.
2. **Tests & Coverage (cloud):** `cd cloud && bundle exec rake test` — all tests must pass with 100% line coverage.
3. **StandardRB (ha-addon):** `cd ha-addon && bundle exec standardrb` — no violations.
4. **StandardRB (cloud):** `cd cloud && bundle exec standardrb` — no violations.
5. **Herb (ha-addon):** `cd ha-addon && bundle exec herb analyze` — all `.html.erb` files must be clean.
