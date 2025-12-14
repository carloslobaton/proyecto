<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="pe.cibertec.streaming.model.Categoria"%>
<%@page import="pe.cibertec.streaming.model.Pelicula"%>

<%
    String ctx = request.getContextPath();
    String msg = request.getParameter("msg");

    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
    Pelicula edit = (Pelicula) request.getAttribute("edit");
    boolean modoEdicion = (edit != null);

    // Si en BD viene "assets/img/xxx.jpg", para el input mostramos solo el nombre (xxx.jpg)
    String editImagen = "";
    if (modoEdicion && edit.getImagen() != null) {
        editImagen = edit.getImagen().trim();
        if (editImagen.startsWith("assets/img/")) {
            editImagen = editImagen.substring("assets/img/".length());
        } else if (editImagen.startsWith("/assets/img/")) {
            editImagen = editImagen.substring("/assets/img/".length());
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Catálogo | CRUD Chic</title>
    <style>
        :root{
            --bg1:#070711;
            --bg2:#16162b;
            --card: rgba(255,255,255,.06);
            --stroke: rgba(255,255,255,.10);
            --txt:#f2f2f6;
            --muted:#b9b9c7;
            --pink:#ff4da6;
            --lila:#a78bfa;
            --shadow: 0 18px 40px rgba(0,0,0,.40);
            --radius: 22px;
        }
        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial;
            color:var(--txt);
            background:
                radial-gradient(900px 500px at 15% 10%, rgba(255,77,166,.12), transparent 60%),
                radial-gradient(900px 500px at 85% 15%, rgba(167,139,250,.14), transparent 60%),
                linear-gradient(180deg, var(--bg1), var(--bg2));
            min-height:100vh;
        }
        .top{
            display:flex;
            justify-content:space-between;
            align-items:center;
            padding:18px 26px;
            border-bottom: 1px solid rgba(255,255,255,.08);
            background: rgba(0,0,0,.22);
            backdrop-filter: blur(10px);
        }
        .brand{ font-weight:950; letter-spacing:2px; display:flex; align-items:center; gap:10px; }
        .dot{ width:12px; height:12px; border-radius:999px; background:linear-gradient(135deg,var(--pink),var(--lila)); }
        .menu a{
            color:#eaeaf7;
            text-decoration:none;
            font-weight:900;
            margin-left:14px;
            opacity:.9;
        }
        .menu a:hover{ opacity:1; }
        .menu a.primary{
            color:#0b0b12;
            background: linear-gradient(135deg, var(--pink), var(--lila));
            padding:10px 14px;
            border-radius:999px;
        }

        .wrap{ max-width:1200px; margin:0 auto; padding:22px 18px 42px; }
        .msgok, .msgerr{
            border-radius:16px;
            padding:12px 14px;
            margin-bottom:14px;
            border:1px solid rgba(255,255,255,.10);
        }
        .msgok{ background: rgba(52,211,153,.14); border-color: rgba(52,211,153,.28); }
        .msgerr{ background: rgba(255,77,166,.12); border-color: rgba(255,77,166,.28); }

        .layout{
            display:grid;
            grid-template-columns: 420px 1fr;
            gap:14px;
            align-items:start;
        }
        .card{
            background:var(--card);
            border:1px solid var(--stroke);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding:18px;
            backdrop-filter: blur(10px);
        }
        h2{ margin:0 0 12px; font-weight:950; }
        label{ display:block; font-size:12px; color:var(--muted); margin-top:10px; }
        input, textarea, select{
            width:100%;
            padding:12px 12px;
            border-radius:14px;
            border:1px solid rgba(255,255,255,.14);
            background: rgba(0,0,0,.22);
            color:var(--txt);
            outline:none;
            margin-top:6px;
        }
        textarea{ min-height: 110px; resize: vertical; }
        .btnrow{ display:flex; gap:10px; margin-top:14px; flex-wrap:wrap; }
        .btn{
            border:0;
            padding:12px 14px;
            border-radius:14px;
            cursor:pointer;
            font-weight:950;
        }
        .btn.primary{ color:#0b0b12; background: linear-gradient(135deg, var(--pink), var(--lila)); }
        .btn.ghost{ color:var(--txt); background: rgba(0,0,0,.18); border:1px solid rgba(255,255,255,.14); text-decoration:none; display:inline-block; }

        table{ width:100%; border-collapse:collapse; margin-top:8px; }
        th, td{
            padding:12px 10px;
            border-bottom: 1px solid rgba(255,255,255,.10);
            vertical-align: top;
        }
        th{ text-align:left; color:#d7d7e6; font-size:12px; letter-spacing:1px; text-transform:uppercase; }
        .miniimg{
            width:74px; height:50px; object-fit:cover;
            border-radius:14px;
            border:1px solid rgba(255,255,255,.12);
            background:#000;
        }
        .pill{
            display:inline-block;
            padding:6px 10px;
            border-radius:999px;
            border:1px solid rgba(255,255,255,.14);
            background: rgba(0,0,0,.18);
            font-size:12px;
            color:#eaeaf7;
        }
        .actions a{
            color:#ffd1ea;
            font-weight:900;
            text-decoration:none;
            margin-right:10px;
        }
        .actions a:hover{ text-decoration:underline; }
        .muted{ color:var(--muted); font-size:12px; margin-top:8px; }
        @media (max-width: 980px){
            .layout{ grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<div class="top">
    <div class="brand"><span class="dot"></span><span>STREAMING CHIC</span></div>
    <div class="menu">
        <a href="<%=ctx%>/inicio">Inicio</a>
        <a href="<%=ctx%>/peliculas">Películas</a>
        <a class="primary" href="<%=ctx%>/registrarPeliculas">CRUD</a>
        <a href="<%=ctx%>/logout" style="color:#ffb3d9;">Salir</a>
    </div>
</div>

<div class="wrap">

    <% if ("ok".equals(msg)) { %>
        <div class="msgok">✅ Cambios guardados correctamente.</div>
    <% } else if ("error".equals(msg)) { %>
        <div class="msgerr">❌ Ocurrió un error. Revisa consola o la conexión a BD.</div>
    <% } %>

    <div class="layout">
        <!-- FORM -->
        <div class="card">
            <h2><%= modoEdicion ? "Editar película" : "Nueva película" %></h2>

            <form action="<%=ctx%>/registrarPeliculas" method="post">
                <input type="hidden" name="accion" value="<%= modoEdicion ? "actualizar" : "crear" %>"/>
                <% if (modoEdicion) { %>
                    <input type="hidden" name="idPelicula" value="<%= edit.getIdPelicula() %>"/>
                <% } %>

                <label>Título</label>
                <input name="titulo" required value="<%= modoEdicion ? edit.getTitulo() : "" %>"/>

                <label>Año</label>
                <input type="number" name="anio" min="1900" max="2100" required
                       value="<%= modoEdicion ? edit.getAnio() : 2022 %>"/>

                <label>Categoría</label>
                <select name="idCategoria" required>
                    <option value="">— Selecciona —</option>
                    <%
                        int selected = (modoEdicion ? edit.getIdCategoria() : -1);
                        if (categorias != null) {
                            for (Categoria c : categorias) {
                    %>
                        <option value="<%= c.getIdCategoria() %>" <%= (c.getIdCategoria() == selected) ? "selected" : "" %>>
                            <%= c.getNombre() %>
                        </option>
                    <%
                            }
                        }
                    %>
                </select>

                <label>Descripción</label>
                <textarea name="descripcion" required><%= modoEdicion ? edit.getDescripcion() : "" %></textarea>

                <label>Portada (archivo dentro de /assets/img)</label>
                <input name="imagen" placeholder="Ej: drama1.jpg"
                       value="<%= modoEdicion ? editImagen : "" %>"/>
                <div class="muted">Coloca la imagen en: <b>Web Pages/assets/img/</b> y escribe aquí el nombre exacto.</div>

                <div class="btnrow">
                    <button class="btn primary" type="submit"><%= modoEdicion ? "Actualizar" : "Guardar" %></button>
                    <% if (modoEdicion) { %>
                        <a class="btn ghost" href="<%=ctx%>/registrarPeliculas">Cancelar</a>
                    <% } %>
                </div>
            </form>
        </div>

        <!-- LISTADO -->
        <div class="card">
            <h2>Catálogo registrado</h2>

            <table>
                <thead>
                <tr>
                    <th>Portada</th>
                    <th>Título</th>
                    <th>Año</th>
                    <th>Categoría</th>
                    <th>Descripción</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (peliculas == null || peliculas.isEmpty()) {
                %>
                    <tr><td colspan="6" style="color:#cfcfe0;">No hay películas registradas.</td></tr>
                <%
                    } else {
                        for (Pelicula p : peliculas) {

                            // ✅ SOLUCIÓN: construir src correctamente (soporta "assets/img/.." o "archivo.jpg")
                            String raw = (p.getImagen() == null) ? "" : p.getImagen().trim();
                            String src = "";

                            if (!raw.isEmpty()) {
                                if (raw.startsWith("http://") || raw.startsWith("https://")) {
                                    src = raw; // URL completa
                                } else if (raw.startsWith("assets/")) {
                                    src = ctx + "/" + raw; // ya viene assets/img/..
                                } else if (raw.startsWith("/assets/")) {
                                    src = ctx + raw; // ya viene /assets/img/..
                                } else {
                                    src = ctx + "/assets/img/" + raw; // solo nombre
                                }
                            }
                %>
                    <tr>
                        <td>
                            <% if (!src.isEmpty()) { %>
                                <img class="miniimg" src="<%=src%>" alt="img"/>
                            <% } else { %>
                                <div class="miniimg"></div>
                            <% } %>
                        </td>
                        <td><b><%= p.getTitulo() %></b></td>
                        <td><%= p.getAnio() %></td>
                        <td><span class="pill"><%= p.getCategoriaNombre() %></span></td>
                        <td style="color:#dcdcea;"><%= p.getDescripcion() %></td>
                        <td class="actions">
                            <a href="<%=ctx%>/registrarPeliculas?accion=editar&id=<%= p.getIdPelicula() %>">Editar</a>
                            <a href="<%=ctx%>/registrarPeliculas?accion=eliminar&id=<%= p.getIdPelicula() %>"
                               onclick="return confirm('¿Eliminar esta película?');">Eliminar</a>
                        </td>
                    </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
