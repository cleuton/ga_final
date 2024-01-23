# Imagem base do Python
FROM python

# Pasta de trabalho no contêiner
WORKDIR /usr/src/app

# Copiando as dependências para o contêiner
COPY requirements.txt ./

# Instalando as dependências no contêiner
RUN pip install --no-cache-dir -r requirements.txt

# Copiando o código Python:
COPY . .

# Entrypoint:
ENTRYPOINT [ "python", "./app/app.py" ]