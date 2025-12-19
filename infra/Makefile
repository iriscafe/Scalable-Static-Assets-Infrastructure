# Captura o argumento do ambiente (ex: make plan dev)
ENV := $(word 2,$(MAKECMDGOALS))

# Define help como target padrão
.DEFAULT_GOAL := help

.PHONY: init plan apply destroy clean help

# Previne que o Make tente executar o ambiente como target
%:
	@:

help:
	@echo "Comandos disponíveis:"
	@echo "  \033[1mmake init\033[0m                    Inicializa o Terraform"
	@echo "  \033[1mmake plan <ambiente>\033[0m         Gera um plan do Terraform para o ambiente especificado (ex: \033[1mmake plan dev\033[0m)"
	@echo "  \033[1mmake apply\033[0m                   Aplica as mudanças do plan gerado (requer que \033[1mmake plan\033[0m tenha sido executado primeiro)"
	@echo "  \033[1mmake destroy\033[0m                 Destroi a infraestrutura usando o plan gerado"
	@echo "  \033[1mmake clean\033[0m                   Remove arquivos temporários do Terraform"
	@echo "  \033[1mmake help\033[0m                    Mostra esta mensagem de ajuda"

init:
	@terraform init

plan:
	@if [ -z "$(ENV)" ]; then \
		echo "❌ Por favor, especifique um ambiente. Exemplo: \033[1mmake plan dev\033[0m"; \
		exit 1; \
	fi
	@if [ ! -d "$(ENV)" ]; then \
		echo "❌ Ambiente \033[1m$(ENV)\033[0m não encontrado."; \
		exit 1; \
	fi
	@if [ ! -d ".terraform" ]; then terraform init; fi
	@TFVARS=$$(find $(ENV) -name "*.tfvars" -type f | sort | sed 's/^/-var-file=/'); \
	if [ -z "$$TFVARS" ]; then \
		echo "❌ Nenhum arquivo .tfvars encontrado no ambiente \033[1m$(ENV)\033[0m."; \
		exit 1; \
	fi; \
	terraform plan $$TFVARS -out=plan.out

apply:
	@if [ -f "plan.out" ]; then \
		terraform apply plan.out; \
		rm -f plan.out; \
	else \
		echo "❌ No plan file found. Please run \033[1mmake plan <ambiente>\033[0m first."; \
		exit 1; \
	fi

destroy:
	@if [ -f "plan.out" ]; then \
		terraform destroy plan.out; \
		rm -f plan.out; \
	else \
		echo "❌ No plan file found. Please run \033[1mmake plan <ambiente>\033[0m first."; \
		exit 1; \
	fi

clean:
	@echo "Cleaning Terraform files..."
	@rm -f plan.out
	@rm -f .terraform.lock.hcl
	@rm -rf .terraform
	@echo "✅ Clean completed"