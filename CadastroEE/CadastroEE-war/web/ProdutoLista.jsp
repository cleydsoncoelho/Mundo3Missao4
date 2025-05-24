<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, cadastroee.model.Produto" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Listagem de Produtos</title>

  <!-- Bootstrap CSS via CDN -->
  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT"
    crossorigin="anonymous">
</head>
<body class="container">

  <h1 class="mt-4">Listagem de Produtos</h1>

  <!-- Link para abrir o formulário de inclusão -->
  <p>
    <a href="produto?acao=formIncluir"
       class="btn btn-primary m-2">
      Novo Produto
    </a>
  </p>

  <%
    @SuppressWarnings("unchecked")
    List<Produto> produtos = (List<Produto>) request.getAttribute("produtos");
    if (produtos == null || produtos.isEmpty()) {
  %>
    <div class="alert alert-info">Nenhum produto encontrado.</div>
  <%
    } else {
  %>
  <table class="table table-striped">
    <thead class="table-dark">
      <tr>
        <th>#</th>
        <th>Nome</th>
        <th>Quantidade</th>
        <th>Preço de Venda</th>
        <th>Opções</th>
      </tr>
    </thead>
    <tbody>
      <%
        for (Produto p : produtos) {
      %>
      <tr>
        <td><%= p.getIdProduto() %></td>
        <td><%= p.getNome() %></td>
        <td><%= p.getQuantidade() %></td>
        <td>R$ <%= String.format("%.2f", p.getPrecoVenda()) %></td>
        <td>
          <a href="produto?acao=formAlterar&id=<%= p.getIdProduto() %>"
             class="btn btn-primary btn-sm">
            Alterar
          </a>
          <a href="produto?acao=excluir&id=<%= p.getIdProduto() %>"
             class="btn btn-danger btn-sm"
             onclick="return confirm('Confirma exclusão deste produto?');">
            Excluir
          </a>
        </td>
      </tr>
      <%
        }
      %>
    </tbody>
  </table>
  <%
    }
  %>

  <!-- Bootstrap Bundle JS via CDN -->
  <script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO"
    crossorigin="anonymous">
  </script>
</body>
</html>