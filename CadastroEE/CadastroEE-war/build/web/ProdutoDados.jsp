<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="cadastroee.model.Produto" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dados do Produto</title>

  <!-- Bootstrap CSS via CDN -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"
    crossorigin="anonymous">
</head>
<body class="container mt-4">

  <%
    String acao = request.getParameter("acao");
    Produto produto = (Produto) request.getAttribute("produto");
    boolean isAlterar = "formAlterar".equals(acao);
  %>

  <h1 class="mb-4">Dados do Produto</h1>

  <form action="produto" method="post" class="form">
    <input type="hidden" name="acao" value="<%= acao %>">
    <% if (isAlterar) { %>
      <input type="hidden" name="id" value="<%= produto.getIdProduto() %>">
    <% } %>

    <div class="mb-3">
      <label for="nome" class="form-label">Nome:</label>
      <input
        type="text"
        class="form-control"
        id="nome"
        name="nome"
        required
        value="<%= produto != null ? produto.getNome() : "" %>">
    </div>

    <div class="mb-3">
      <label for="quantidade" class="form-label">Quantidade:</label>
      <input
        type="number"
        class="form-control"
        id="quantidade"
        name="quantidade"
        min="0"
        value="<%= produto != null ? produto.getQuantidade() : 0 %>">
    </div>

    <div class="mb-3">
      <label for="precoVenda" class="form-label">Preço de Venda:</label>
      <input
        type="text"
        class="form-control"
        id="precoVenda"
        name="precoVenda"
        required
        value="<%= produto != null ? produto.getPrecoVenda() : "" %>">
    </div>

    <button type="submit" class="btn btn-primary">
      <%= isAlterar ? "Alterar Produto" : "Incluir Produto" %>
    </button>
    <a href="produto?acao=listar" class="btn btn-secondary ms-2">Cancelar</a>
  </form>

  <!-- Bootstrap JS Bundle via CDN -->
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
    crossorigin="anonymous"></script>
</body>
</html>
