#!/bin/bash
set -e

ECR_REGISTRY="${ecr_registry}"
ECR_REPOSITORY="${ecr_repository}"
IMAGE_TAG="${image_tag}"
AWS_REGION="${aws_region}"
CLOUDFRONT_URL="${cloudfront_url}"

# Log para CloudWatch
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "Iniciando configuração da instância EC2..."

if aws ecr describe-repositories --repository-names $${ECR_REPOSITORY} --region $${AWS_REGION} &>/dev/null; then
  echo "Repositório ECR encontrado: $${ECR_REPOSITORY}"
  
  # Login no ECR
  echo "Fazendo login no ECR..."
  aws ecr get-login-password --region $${AWS_REGION} | \
    docker login --username AWS --password-stdin $${ECR_REGISTRY}
  
  echo "Verificando se a imagem existe: $${ECR_REGISTRY}/$${ECR_REPOSITORY}:$${IMAGE_TAG}"
  if aws ecr describe-images --repository-name $${ECR_REPOSITORY} --image-ids imageTag=$${IMAGE_TAG} --region $${AWS_REGION} &>/dev/null; then
    echo "Imagem encontrada no ECR!"
    
    # Parar e remover container anterior se existir
    echo "Limpando containers anteriores..."
    docker stop admin-panel 2>/dev/null || true
    docker rm admin-panel 2>/dev/null || true
    
    # Remover imagem antiga se existir
    docker rmi $${ECR_REGISTRY}/$${ECR_REPOSITORY}:$${IMAGE_TAG} 2>/dev/null || true
    
    # Pull da imagem do ECR
    echo "Fazendo pull da imagem: $${ECR_REGISTRY}/$${ECR_REPOSITORY}:$${IMAGE_TAG}"
    docker pull $${ECR_REGISTRY}/$${ECR_REPOSITORY}:$${IMAGE_TAG}
    
    # Executar container
    echo "Iniciando container..."
    docker run -d \
      --name admin-panel \
      --restart unless-stopped \
      -e CLOUDFRONT_URL=$${CLOUDFRONT_URL} \
      -p 80:80 \
      $${ECR_REGISTRY}/$${ECR_REPOSITORY}:$${IMAGE_TAG}
    
    # Verificar se o container está rodando
    sleep 5
    if docker ps | grep -q admin-panel; then
      echo "✅ Container iniciado com sucesso!"
      docker ps | grep admin-panel
    else
      echo "❌ Erro: Container não está rodando"
      docker logs admin-panel || true
      exit 1
    fi
  else
    echo "⚠️  AVISO: A imagem $${ECR_REGISTRY}/$${ECR_REPOSITORY}:$${IMAGE_TAG} ainda não existe no ECR."
    echo "A instância será configurada, mas o container só será iniciado manualmente após a imagem ser publicada."
  fi
else
  echo "⚠️  AVISO: O repositório ECR '$${ECR_REPOSITORY}' ainda não existe."
  echo "A instância será configurada, mas o container só será iniciado após o repositório e a imagem serem criados."
fi

echo "Configuração concluída!"
