# Copilot Instructions

## Migrations

All database migrations must be added to `ha-addon/engine/db/migrate/` using sequential numbering (001, 002, ...). Never add migrations to `cloud/db/migrate/`. The engine migrations are shared by both apps via the engine's `append_migrations` initializer.

After running migrations, copy the schema: `cp ha-addon/engine/db/schema.rb cloud/db/schema.rb` (ha-addon/db/schema.rb is a symlink to the engine's).

## Validation Checklist

Before considering any task complete, always run all of the following checks and fix any issues:

1. **Tests & Coverage (ha-addon):** `cd ha-addon && bundle exec rake test` — all tests must pass with 100% line coverage.
2. **Tests & Coverage (cloud):** `cd cloud && bundle exec rake test` — all tests must pass with 100% line coverage.
3. **StandardRB (ha-addon):** `cd ha-addon && bundle exec standardrb` — no violations.
4. **StandardRB (cloud):** `cd cloud && bundle exec standardrb` — no violations.
5. **Herb (ha-addon):** `cd ha-addon && bundle exec herb analyze` — all `.html.erb` files must be clean.
