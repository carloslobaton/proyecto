package pe.cibertec.streaming.controller;

import pe.cibertec.streaming.dao.impl.CategoriaDAO;
import pe.cibertec.streaming.dao.impl.CategoriaDAOImpl;
import pe.cibertec.streaming.dao.impl.PeliculaDAO;
import pe.cibertec.streaming.dao.impl.PeliculaDAOImpl;
import pe.cibertec.streaming.model.Categoria;
import pe.cibertec.streaming.model.Pelicula;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "PeliculasServlet", urlPatterns = {"/peliculas"})
public class PeliculasServlet extends HttpServlet {

    private final CategoriaDAO categoriaDAO = new CategoriaDAOImpl();
    private final PeliculaDAO peliculaDAO = new PeliculaDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // CARGAR DATA (categorías + películas) para que el JSP pueda llenar el combo
        List<Categoria> categorias = categoriaDAO.listarActivas();
        List<Pelicula> peliculas = peliculaDAO.listarConCategoria();

        request.setAttribute("categorias", categorias);
        request.setAttribute("peliculas", peliculas);

        request.getRequestDispatcher("/peliculas.jsp").forward(request, response);
    }
}
