package pe.cibertec.streaming.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String ctx = request.getContextPath();                 // /
        String uri = request.getRequestURI();                  // /
        String path = uri.substring(ctx.length());             // /login

        // Rutas públicas (NO requieren sesión)
        boolean publicPath =
                path.equals("/") ||
                path.equals("/login") ||
                path.equals("/index.html") ||
                path.equals("/index.jsp") ||
                path.startsWith("/assets/");

        if (publicPath) {
            chain.doFilter(req, res);
            return;
        }

        HttpSession session = request.getSession(false);
        Object usuarioLogueado = (session != null) ? session.getAttribute("usuarioLogueado") : null;

        if (usuarioLogueado == null) {
            response.sendRedirect(ctx + "/login");
            return;
        }

        chain.doFilter(req, res);
    }
}
