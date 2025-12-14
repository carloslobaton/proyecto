package pe.cibertec.streaming.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import pe.cibertec.streaming.model.Usuario;

@WebServlet(name = "InicioServlet", urlPatterns = {"/inicio"})
public class InicioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("usuario", u);
        request.getRequestDispatcher("inicio.jsp").forward(request, response);
    }
}
