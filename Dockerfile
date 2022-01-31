# Imagem base: Mínima versão do R
FROM rocker/r-ubuntu:20.04

LABEL maintainer="Samuel Souza"

# Adicionando as dependências do R no Linux
RUN apt-get update && apt-get upgrade -y && apt-get install -y libxml2-dev

RUN R -e "install.packages(c('shiny', 'shinydashboard', 'waiter'), \
  repos = 'https://cloud.r-project.org/')"

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
