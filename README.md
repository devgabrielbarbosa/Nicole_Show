# 🍫 Nicole Show Doces - Documentação Técnica Completa

Este documento descreve detalhadamente todas as **telas e funcionalidades do projeto Nicole Show Doces**, explicando a **estrutura HTML, classes, IDs, CSS, Bootstrap 5 e JavaScript** utilizados em cada página, e a função de cada elemento.

---

## 🏠 1. Home / Index (Cliente)

**Função:** Página inicial do cliente, apresenta produtos em destaque, promoções, busca e links para outras páginas.

### Estrutura e Tags Semânticas:
- `<header>`: Contém logo, menu de navegação e botão de login.
- `<nav>`: Menu com links: Home, Produtos, Carrinho, FAQ, Sobre.
- `<main>`: Área principal com banners, destaques e produtos.
- `<section class="produtos">`: Grade com os cards de produtos.
- `<article class="produto-card">`: Cada produto com imagem, nome, preço e botão de ação.
- `<figure>` / `<figcaption>`: Imagem do produto e legenda.
- `<button id="btn-add-carrinho">`: Adiciona o produto ao carrinho.
- `<footer>`: Informações de contato, redes sociais e direitos autorais.

### Classes e IDs:
- `.navbar`: Estiliza menu usando Bootstrap 5.
- `.banner`: Banner promocional com imagem e texto chamativo.
- `.produto-card`: Card de produto.
- `.promo-card`: Card de promoções.
- `#btn-add-carrinho`: Botão de adicionar ao carrinho.
- `.footer-social`: Ícones de redes sociais.
- `#searchBar`: Input de busca de produtos.
- `#promoList`: Lista de promoções renderizadas via JS.

### Funcionalidade JS:
- Filtragem de produtos pela barra de busca.
- Adicionar ao carrinho com `addEventListener`.
- Atualização dinâmica do contador de itens e total do carrinho.
- Armazenamento de itens no `localStorage`.

---

## 🔑 2. Login

**Função:** Permitir que o cliente ou lojista acesse sua conta.

### Estrutura e Tags:
- `<main>`: Contém formulário de login.
- `<form id="login-form">`: Formulário de login.
- `<label>`: Explicação de cada campo.
- `<input type="email|password">`: Campos para login.
- `<button type="submit" class="btn-login">`: Submete o formulário.
- `<a href="cadastro.html">`: Link para criar conta.

### Classes e IDs:
- `.form-control`: Estiliza campos de formulário.
- `.btn-login`: Botão de login.
- `#erro-login`: Mensagem de erro exibida via JS.

### Funcionalidade JS:
- Validação de campos obrigatórios.
- Autenticação simulada com `localStorage`.
- Redirecionamento após login.

---

## 📝 3. Cadastro

**Função:** Criar nova conta de cliente.

### Estrutura e Tags:
- `<form id="cadastro-form">`: Estrutura de cadastro.
- `<input type="text|email|password|number" required>`: Campos obrigatórios.
- `<textarea>`: Campo de observações.
- `<button type="submit" class="btn-cadastrar">`: Submete cadastro.

### Classes e IDs:
- `.form-group`: Agrupa inputs.
- `.btn-cadastrar`: Botão de cadastro.
- `#erro-cadastro`: Mensagem de erro via JS.

### Funcionalidade JS:
- Validação de senha, email e campos obrigatórios.
- Armazenamento dos dados no `localStorage`.
- Redirecionamento para login após cadastro.

---

## 🛒 4. Carrinho

**Função:** Lista todos os produtos selecionados pelo usuário.

### Estrutura e Tags:
- `<section id="carrinho">`: Container principal do carrinho.
- `<div class="item-carrinho">`: Cada produto adicionado.
- `<table>` / `<thead>` / `<tbody>` / `<tr>` / `<td>`: Estrutura de produtos.
- `<button class="remover-item">`: Remove item do carrinho.
- `<span class="total-carrinho">`: Valor total da compra.

### Classes e IDs:
- `.item-carrinho`: Card de item do carrinho.
- `.btn-finalizar`: Botão para finalizar compra.
- `#qtd-carrinho`: Contador de itens no carrinho.
- `.btn-remove`: Botão de remover item.

### Funcionalidade JS:
- `removerItem()` e `calcularTotal()`.
- Atualização dinâmica do carrinho via `localStorage`.
- Botão “Finalizar compra” limpa o carrinho e redireciona.

---

## 👤 5. Perfil do Cliente

**Função:** Exibir dados do usuário logado.

### Estrutura e Tags:
- `<section id="perfil-usuario">`: Área com informações do usuário.
- `<img>`: Avatar do usuário.
- `<h2>` / `<p>`: Nome e email.
- `<button class="btn-editar">`: Edita perfil.
- `<button class="btn-logout">`: Logout.
- `<div class="abas">`: Seções de pedidos, pagamentos, dados e configurações.

### Classes e IDs:
- `.perfil-card`: Container dos dados do usuário.
- `.btn-editar`: Botão de editar.
- `.btn-logout`: Botão de sair.
- `#previewFoto`, `#nome`, `#email`, `#telefone`, `#endereco`: Inputs conectados ao JS.

### Funcionalidade JS:
- Pré-visualização de foto (`previewFoto()`).
- Salvar alterações no DOM e `localStorage`.
- Toggle entre abas.

---

## 🏪 6. Home do Lojista

**Função:** Painel do lojista, visão geral de vendas e produtos.

### Estrutura e Tags:
- `<header>` / `<nav>`: Menu do lojista.
- `<main>`: Conteúdo principal.
- `<section class="dashboard">`: Cards com métricas e atalhos.
- `<article class="dashboard-card">`: Cada métrica.
- `<button class="btn-novo-produto">`: Adiciona novo produto.

### Classes e IDs:
- `.dashboard-card`: Cards de métricas.
- `.btn-novo-produto`: Botão de novo produto.

### Funcionalidade JS:
- Renderização dinâmica das métricas.
- Atualização conforme vendas simuladas em `localStorage`.

---

## 📦 7. Produtos do Lojista

**Função:** Gerenciar produtos cadastrados.

### Estrutura e Tags:
- `<table class="table">`: Lista de produtos.
- `<tr>` / `<td>`: Linhas e colunas.
- `<button class="btn-editar-produto">`, `<button class="btn-excluir-produto">`.

### Classes e IDs:
- `.table`: Tabela estilizada pelo Bootstrap.
- `.status-produto`: Indica ativo/inativo.

### Funcionalidade JS:
- Editar, excluir e atualizar lista de produtos.
- Simulação de banco de dados via `localStorage`.

---

## 👤 8. Perfil do Lojista

**Função:** Exibir e editar dados do lojista.

### Estrutura e Tags:
- `<section id="perfil-lojista">`: Área de perfil.
- `<input>`: Campos de edição.
- `<button class="btn-salvar">`: Salvar alterações.

### Classes e IDs:
- `.perfil-lojista-card`
- `.btn-salvar`

### Funcionalidade JS:
- Edição e salvamento no `localStorage`.

---

## 🎁 9. Cadastro de Promoções

**Função:** Criar promoções para clientes.

### Estrutura e Tags:
- `<form id="form-promocao">`: Formulário de promoção.
- `<input type="text|number|date">`: Nome, desconto, validade.
- `<textarea>`: Descrição da promoção.
- `<button class="btn-cadastrar-promocao">`: Salvar promoção.

### Classes e IDs:
- `.form-promocao`
- `.btn-cadastrar-promocao`
- `#promoTitle`, `#promoDesc`, `#promoPercent`

### Funcionalidade JS:
- Validação do formulário.
- Renderização, edição e exclusão de promoções.
- Preview de imagem via upload ou URL.
- Toast de sucesso.

---

## 📌 Tecnologias Utilizadas
- HTML5  
- CSS3  
- Bootstrap 5  
- JavaScript  
- `localStorage`  

---

## ⚡ Boas Práticas
- Código organizado e comentado.  
- Classes reutilizáveis e semânticas.  
- Separação de HTML, CSS e JS.  
- Responsividade com grid do Bootstrap.  
- Validação de formulários e acessibilidade.  

---

## 📌 Acessibilidade
- `<img>` com `alt` descritivo.  
- `<label>` associado a `<input>`.  
- Navegação via teclado.  
- Contraste de cores adequado.  
- Uso de tags semânticas: `<header>`, `<main>`, `<section>`, `<footer>`, `<nav>`.

---

## 📌 CSS / Layout
- `.container` – Centraliza conteúdo.  
- `.row` / `.col-md-*` – Grid responsivo.  
- `.navbar` – Menu de navegação.  
- `.btn` – Botões.  
- `.produto-card` / `.promo-card` – Cards de produtos e promoções.  
- `.badge-active` / `.badge-inactive` – Indicação de status.  
- `.footer` / `.footer-social` – Rodapé.  

---

## ⚙️ JavaScript
- Manipulação do DOM (`getElementById`, `querySelector`).  
- Eventos (`addEventListener`) para botões e formulários.  
- Funções de adicionar/remover produtos, calcular total e editar perfil.  
- Renderização dinâmica de listas (produtos, promoções, pedidos).  

---

## 📌 Badges e Emojis
- ![HTML](https://img.shields.io/badge/HTML5-orange)  
- ![CSS](https://img.shields.io/badge/CSS3-blue)  
- ![JS](https://img.shields.io/badge/JavaScript-yellow)  

Emojis para títulos: 🍫 🏠 📝 🛒 🔑 🏪 📦 🎉 🏢 ⚙️ 📌 🖥️





