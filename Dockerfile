# Imagem base: Mínima versão do R
FROM rhub/r-minimal

LABEL maintainer="Samuel Souza"

# Adicionando as dependências do R no Linux
RUN apk add --no-cache --update-cache \
  --repository http://nl.alpinelinux.org/alpine/v3.11/main \
  autoconf=2.69-r2 \
  automake=1.16.1-r0 && \
  installr -d \
  -t "bash libsodium-dev curl-dev linux-headers autoconf automake" \
  -a libsodium \
  # Bibliotecas do R
  shiny shinydashboard waiter

# Seta as variáveis de Ambiente
ENV PROJECT_NAME='Workshop - Docker 4intelligence'

# Cria um diretório para o projeto dentro do container
RUN mkdir /root/shiny-docker

# Copia este diretório para o diretório criado
COPY . /root/shiny-docker

# Libera a porta 3838 do CONTAINER
EXPOSE 3838

# Executa o dashboard dentro do container na porta 3838
CMD ["R", "-e", "shiny::runApp('/root/shiny-docker', port = 3838, host = '0.0.0.0')"]
