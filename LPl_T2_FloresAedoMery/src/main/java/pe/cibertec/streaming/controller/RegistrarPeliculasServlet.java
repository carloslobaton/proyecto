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

@WebServlet(name = "RegistrarPeliculasServlet", urlPatterns = {"/registrarPeliculas"})
public class RegistrarPeliculasServlet extends HttpServlet {

    private final CategoriaDAO categoriaDAO = new CategoriaDAOImpl();
    private final PeliculaDAO peliculaDAO = new PeliculaDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("editar".equalsIgnoreCase(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Pelicula p = peliculaDAO.buscarPorId(id);
            request.setAttribute("edit", p);
        }

        if ("eliminar".equalsIgnoreCase(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            peliculaDAO.eliminar(id);
            response.sendRedirect(request.getContextPath() + "/registrarPeliculas?msg=ok");
            return;
        }

        cargarData(request);
        request.getRequestDispatcher("/registrarPeliculas.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        int anio = Integer.parseInt(request.getParameter("anio"));
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));

        // En BD es portada_url (NO NULL). Aquí generamos el valor final.
        String imagenInput = request.getParameter("imagen"); // ej: terror1.jpg
        String portadaUrl = normalizarPortadaUrl(imagenInput);

        boolean ok;

        if ("actualizar".equalsIgnoreCase(accion)) {
            int id = Integer.parseInt(request.getParameter("idPelicula"));
            Pelicula p = new Pelicula();
            p.setIdPelicula(id);
            p.setTitulo(titulo);
            p.setDescripcion(descripcion);
            p.setAnio(anio);
            p.setIdCategoria(idCategoria);
            p.setImagen(portadaUrl); // <- se guarda en portada_url

            ok = peliculaDAO.actualizar(p);

        } else {
            Pelicula p = new Pelicula();
            p.setTitulo(titulo);
            p.setDescripcion(descripcion);
            p.setAnio(anio);
            p.setIdCategoria(idCategoria);
            p.setImagen(portadaUrl); // <- se guarda en portada_url

            ok = peliculaDAO.insertar(p);
        }

        response.sendRedirect(request.getContextPath() + "/registrarPeliculas?msg=" + (ok ? "ok" : "error"));
    }

    private void cargarData(HttpServletRequest request) {
        List<Categoria> categorias = categoriaDAO.listarActivas();
        List<Pelicula> peliculas = peliculaDAO.listarConCategoria();

        request.setAttribute("categorias", categorias);
        request.setAttribute("peliculas", peliculas);
    }

    private String normalizarPortadaUrl(String input) {
        String v = (input == null) ? "" : input.trim();
        v = v.replace("\\", "/");

        // Si lo dejan vacío, igual debe ir algo porque portada_url es NOT NULL
        if (v.isEmpty()) {
            return "assets/img/no-image.jpg"; // si no tienes este archivo, crea uno o cambia el nombre
        }

        // Si ponen solo "terror1.jpg", lo convertimos a "assets/img/terror1.jpg"
        if (!v.contains("/")) {
            return "assets/img/" + v;
        }

        // Si ya ponen "assets/img/terror1.jpg" lo dejamos
        if (v.startsWith("/")) v = v.substring(1);
        return v;
    }
}
