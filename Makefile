.PHONY: help createmigration migrate migrate-down

createmigration:
	migrate create -ext sql -dir internal/infra/database/migrations -seq create_order_table

migrate:
	migrate -database "mysql://root:root@tcp(localhost:3306)/orders" -path internal/infra/database/migrations up

migrate-down:
	migrate -database "mysql://root:root@tcp(localhost:3306)/orders" -path internal/infra/database/migrations down
