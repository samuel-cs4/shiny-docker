# Shiny & Docker - Exemplo

Um exemplo simples de como utilizar o Shiny e Docker.

## Rodando a aplicação via Shiny

1. Abra o RStudio

1. Clique no botão `Run App` no RStudio

1. Uma janela irá abrir com a aplicação pelo próprio RStudio.

## Rodando a aplicação via Docker

1. No terminal, construa a imagem docker da aplicação com o comando

```bash
docker build -t shiny-docker .
```

1. Verifique se a imagem está presente em sua máquina com o comando

```bash
docker images
```

1. Após criado a imagem, crie um container utilizando o comando

```bash
docker run -it -p 3838:3838 shiny-docker
```

1. Se tudo der certo, acesse o endereço [http://0.0.0.0:3838](http://0.0.0.0:3838)

1. Para interromper a execução do container, utilize o comando abaixo passando o _container id_ de seu container, que pode ser obtido com o comando `docker ps`.

```bash
docker stop <container id>
```
