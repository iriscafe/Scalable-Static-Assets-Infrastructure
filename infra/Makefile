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
	@echo "  \033[1mmake apply <ambiente>\033[0m        Aplica as mudanças do plan gerado (ex: \033[1mmake apply dev\033[0m)"
	@echo "  \033[1mmake destroy <ambiente>\033[0m      Destroi a infraestrutura usando o plan gerado (ex: \033[1mmake destroy dev\033[0m)"
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
	terraform plan $$TFVARS -out=plan-$(ENV).out

apply:
	@if [ -z "$(ENV)" ]; then \
		echo "❌ Por favor, especifique um ambiente. Exemplo: \033[1mmake apply dev\033[0m"; \
		exit 1; \
	fi
	@if [ -f "plan-$(ENV).out" ]; then \
		terraform apply plan-$(ENV).out; \
	else \
		echo "❌ Não foi possível encontrar o plan-$(ENV).out. Execute \033[1mmake plan $(ENV)\033[0m primeiro."; \
		exit 1; \
	fi

destroy:
	@if [ -z "$(ENV)" ]; then \
		echo "❌ Por favor, especifique um ambiente. Exemplo: \033[1mmake destroy dev\033[0m"; \
		exit 1; \
	fi
	@if [ -f "plan-$(ENV).out" ]; then \
		terraform destroy plan-$(ENV).out; \
		rm -f plan-$(ENV).out; \
	else \
		echo "❌ Não foi possível encontrar o plan-$(ENV).out. Execute \033[1mmake plan $(ENV)\033[0m primeiro."; \
		exit 1; \
	fi

clean:
	@echo "Removendo arquivos temporários do Terraform..."
	@rm -f plan-*.out
	@rm -f .terraform.lock.hcl
	@rm -rf .terraform
	@echo "✅ Limpeza concluída"