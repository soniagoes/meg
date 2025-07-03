# O Dockerfile constroi a imagem
# Use uma imagem oficial do Python como imagem base.
# python:3.10-slim é uma boa escolha por ser leve e compatível com o projeto (conforme readme.md).
FROM python:3.10-slim

# Define o diretório de trabalho dentro do container.
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .

# Instala as dependências.
# --no-cache-dir: Desabilita o cache do pip para manter a imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
# O .dockerignore garantirá que arquivos desnecessários como 'venv' não sejam copiados.
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do container.
EXPOSE 8000

# Comando para executar a aplicação com Uvicorn.
# --host 0.0.0.0 é necessário para que a aplicação seja acessível externamente.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

