.PHONY: docs fmt validate clean

# Generate terraform-docs for all modules
docs:
	@./scripts/generate-docs.sh

# Format all terraform files
fmt:
	terraform fmt -recursive .

# Validate all modules
validate:
	@for dir in . modules/cluster modules/node-pool modules/scheduled-scaling; do \
		echo "Validating $$dir..."; \
		cd $$dir && terraform init -backend=false > /dev/null && terraform validate && cd - > /dev/null; \
	done

# Clean terraform cache
clean:
	find . -type d -name ".terraform" -exec rm -rf {} + 2>/dev/null || true
	find . -name ".terraform.lock.hcl" -delete 2>/dev/null || true
	find . -name "terraform.tfstate*" -delete 2>/dev/null || true

# Run all checks
all: fmt docs validate
