package pe.cibertec.streaming.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import pe.cibertec.streaming.dao.impl.UsuarioDAO;
import pe.cibertec.streaming.dao.impl.UsuarioDAOImpl;
import pe.cibertec.streaming.model.Usuario;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        Usuario u = usuarioDAO.login(usuario, password);

        if (u != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("usuarioLogueado", u);
            response.sendRedirect(request.getContextPath() + "/inicio");
            return;
        }

        request.setAttribute("error", "Usuario o contraseña incorrectos.");
        request.setAttribute("userValue", usuario);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
