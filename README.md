# Store

Projeto de e-commerce desenvolvido com **Ruby on Rails** como parte do meu aprendizado do framework.

A aplicação implementa o fluxo básico de uma loja virtual, desde a visualização dos produtos até a criação de pedidos.

## Tecnologias

* Ruby
* Ruby on Rails
* PostgreSQL
* HTML / ERB
* CSS
* Git

## Funcionalidades

* Catálogo de produtos
* Controle de estoque dos produtos
* Carrinho de compras
* Adição e remoção de produtos do carrinho
* Alteração da quantidade de itens
* Checkout
* Cadastro de endereço no checkout
* Criação de pedidos
* Itens dos pedidos
* Controle de status dos pedidos

## Fluxo da aplicação


Produtos
   ↓
Carrinho
   ↓
Checkout
   ↓
Pedido


## Executando o projeto

Clone o repositório:


git clone <URL_DO_REPOSITORIO>
cd store


Instale as dependências:


bundle install


Configure o banco de dados:


bin/rails db:create
bin/rails db:migrate


Inicie o servidor:


bin/rails server


A aplicação estará disponível em:

http://localhost:3000


## Objetivo

Este projeto tem como objetivo praticar o desenvolvimento de aplicações web utilizando Ruby on Rails, explorando conceitos como:

* Models e Active Record
* Migrations
* Associations
* Controllers
* Views com ERB
* Rotas
* Validações
* Transações
* Relacionamentos entre entidades
* Persistência com PostgreSQL

## Status

🚧 Projeto em desenvolvimento e utilizado como projeto de aprendizado em Ruby on Rails.
