package cadastroee.servlets;

import cadastroee.controller.ProdutoFacadeLocal;
import cadastroee.model.Produto;
import java.io.IOException;
import java.util.List;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet Front Controller para operações CRUD de Produto.
 */
@WebServlet(name = "ServletProdutoFC", urlPatterns = {"/produto"})
public class ServletProdutoFC extends HttpServlet {

    @EJB
    private ProdutoFacadeLocal facade;

    /**
     * Processa todas as ações: listar, incluir, alterar, excluir, formIncluir, formAlterar.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Capturar o parâmetro acao (default = listar)
        String acao = request.getParameter("acao");
        if (acao == null || acao.isEmpty()) {
            acao = "listar";
        }

        // Definir variável destino para JSP apropriado
        String destino;

        switch (acao) {
            case "formIncluir":
                // Destino para inclusão de novo produto
                destino = "ProdutoDados.jsp";
                break;

            case "formAlterar":
                // Destino para alteração e carregar dados do produto
                destino = "ProdutoDados.jsp";
                Integer idFormAlt = Integer.valueOf(request.getParameter("id"));
                Produto produtoAlt = facade.find(idFormAlt);
                request.setAttribute("produto", produtoAlt);
                break;

            case "excluir":
                // Excluir produto e listar novamente
                Integer idExc = Integer.valueOf(request.getParameter("id"));
                facade.remove(facade.find(idExc));
                List<Produto> listaExc = facade.findAll();
                request.setAttribute("produtos", listaExc);
                destino = "ProdutoLista.jsp";
                break;

            case "alterar":
                // Alterar produto existente e listar novamente
                Integer idAlt = Integer.valueOf(request.getParameter("id"));
                Produto prodAlt = facade.find(idAlt);
                prodAlt.setNome(request.getParameter("nome"));
                prodAlt.setPrecoVenda(Float.valueOf(request.getParameter("precoVenda")));
                facade.edit(prodAlt);
                List<Produto> listaAlt = facade.findAll();
                request.setAttribute("produtos", listaAlt);
                destino = "ProdutoLista.jsp";
                break;

            case "incluir":
                // Incluir novo produto e listar novamente
                Produto novoProd = new Produto();
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    novoProd.setIdProduto(Integer.valueOf(idParam));
                }
                novoProd.setNome(request.getParameter("nome"));
                novoProd.setPrecoVenda(Float.valueOf(request.getParameter("precoVenda")));
                facade.create(novoProd);
                List<Produto> listaIn = facade.findAll();
                request.setAttribute("produtos", listaIn);
                destino = "ProdutoLista.jsp";
                break;

            case "listar":
            default:
                // Listar todos os produtos
                List<Produto> lista = facade.findAll();
                request.setAttribute("produtos", lista);
                destino = "ProdutoLista.jsp";
                break;
        }

        // Redirecionar para o JSP de destino via RequestDispatcher
        RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Front Controller para gerenciamento de Produto";
    }
}