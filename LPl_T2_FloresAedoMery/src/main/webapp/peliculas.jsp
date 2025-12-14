<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="pe.cibertec.streaming.model.Categoria"%>
<%@page import="pe.cibertec.streaming.model.Pelicula"%>

<%
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    List<Pelicula> peliculas = (List<Pelicula>) request.getAttribute("peliculas");
    Pelicula edit = (Pelicula) request.getAttribute("peliculaEdit");

    String msg = request.getParameter("msg");
    String ctx = request.getContextPath();

    boolean isEdit = (edit != null);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Películas (CRUD)</title>
    <style>
        body { margin:0; font-family: Arial, sans-serif; background:#0f0f10; color:#fff; }
        .topbar { display:flex; justify-content:space-between; align-items:center; padding:18px 28px; background:#101013; border-bottom:1px solid #222; }
        .brand { font-weight:800; letter-spacing:1px; color:#e50914; font-size:22px; }
        .menu a { color:#ddd; text-decoration:none; margin-left:18px; font-weight:600; }
        .menu a:hover { color:#fff; }
        .container { padding:24px 28px; max-width:1100px; margin:0 auto; }
        .card { background:#141417; border:1px solid #242429; border-radius:14px; padding:18px; box-shadow: 0 12px 26px rgba(0,0,0,.25); }
        .row { display:flex; gap:16px; flex-wrap:wrap; }
        .col { flex:1; min-width:260px; }
        label { display:block; font-size:13px; color:#bdbdbd; margin-bottom:6px; }
        input, textarea, select {
            width:100%; padding:10px 12px; border-radius:10px;
            border:1px solid #2b2b33; background:#0f0f12; color:#fff;
            outline:none;
        }
        textarea { min-height:90px; resize:vertical; }
        .actions { display:flex; gap:10px; margin-top:14px; }
        .btn {
            padding:10px 14px; border-radius:10px; border:0; cursor:pointer;
            font-weight:700;
        }
        .btn-primary { background:#e50914; color:#fff; }
        .btn-secondary { background:#2a2a33; color:#fff; }
        .btn-danger { background:#b00020; color:#fff; }
        .hint { font-size:12px; color:#9aa0a6; margin-top:8px; }
        table { width:100%; border-collapse:collapse; margin-top:18px; }
        th, td { padding:12px 10px; border-bottom:1px solid #2a2a2f; vertical-align:top; }
        th { text-align:left; color:#c9c9c9; font-size:13px; }
        .pill { display:inline-block; padding:4px 10px; border-radius:999px; background:#23232a; font-size:12px; color:#ddd; }
        .msgok { background:#103a1b; border:1px solid #1f7a35; padding:10px 12px; border-radius:10px; margin-bottom:14px; }
        .msgerr { background:#3a1010; border:1px solid #7a1f1f; padding:10px 12px; border-radius:10px; margin-bottom:14px; }
        .miniimg { width:70px; height:70px; object-fit:cover; border-radius:10px; border:1px solid #2a2a2f; background:#000; }
        .link { color:#9ad; text-decoration:none; font-weight:700; }
        .link:hover { color:#cfe6ff; }
        .form-inline { display:inline; }
    </style>
</head>

<body>
<div class="topbar">
    <div class="brand">T2</div>
    <div class="menu">
        
        <a href="<%=ctx%>/inicio">Inicio</a>
<a href="<%=ctx%>/peliculas">Películas</a>
<a href="<%=ctx%>/registrarPeliculas">Registrar Películas</a>
<a style="color:#ff4d4d" href="<%=ctx%>/logout">Cerrar sesión</a>
    </div>
</div>

<div class="container">

    <% if ("ok".equals(msg)) { %>
        <div class="msgok">✅ Operación realizada correctamente.</div>
    <% } else if ("error".equals(msg)) { %>
        <div class="msgerr">❌ Ocurrió un error en la operación. Revisa consola/DB.</div>
    <% } %>

    <div class="card">
        <h2 style="margin:0 0 12px 0;"><%= isEdit ? "Editar Película" : "Registrar Película" %></h2>

        <form method="post" action="<%=ctx%>/registrarPeliculas">
            <input type="hidden" name="action" value="<%= isEdit ? "update" : "create" %>"/>
            <% if (isEdit) { %>
                <input type="hidden" name="idPelicula" value="<%= edit.getIdPelicula() %>"/>
            <% } %>

            <div class="row">
                <div class="col">
                    <label>Título</label>
                    <input name="titulo" required
                           value="<%= isEdit ? edit.getTitulo() : "" %>"/>
                </div>

                <div class="col">
                    <label>Año</label>
                    <input name="anio" type="number" min="1900" max="2100" required
                           value="<%= isEdit ? edit.getAnio() : 2020 %>"/>
                </div>

                <div class="col">
                    <label>Categoría</label>
                    <select name="idCategoria" required>
                        <option value="">-- Seleccione --</option>
                        <% if (categorias != null) {
                               for (Categoria c : categorias) {
                                   int selected = (isEdit ? edit.getIdCategoria() : 0);
                        %>
                            <option value="<%=c.getIdCategoria()%>"
                                <%= (c.getIdCategoria() == selected) ? "selected" : "" %>>
                                <%=c.getNombre()%>
                            </option>
                        <%     }
                           } %>
                    </select>
                </div>
            </div>

            <div style="margin-top:12px;">
                <label>Descripción</label>
                <textarea name="descripcion" required><%= isEdit ? edit.getDescripcion() : "" %></textarea>
            </div>

            <div style="margin-top:12px;">
                <label>Imagen (solo nombre de archivo en /assets/img)</label>
                <input name="imagen" placeholder="Ej: rapidos.jpg"
                       value="<%= isEdit ? (edit.getImagen() == null ? "" : edit.getImagen()) : "" %>"/>
                <div class="hint">
                    Coloca la imagen en: <b>Web Pages/assets/img/</b> y aquí escribe el nombre exacto del archivo.
                </div>
            </div>

            <div class="actions">
                <button class="btn btn-primary" type="submit"><%= isEdit ? "Actualizar" : "Guardar" %></button>
                <% if (isEdit) { %>
                    <a class="btn btn-secondary" href="<%=ctx%>/registrarPeliculas" style="text-decoration:none; display:inline-block; text-align:center;">Cancelar</a>
                <% } %>
            </div>
        </form>
    </div>

    <div class="card" style="margin-top:18px;">
        <h2 style="margin:0 0 12px 0;">Listado de Películas</h2>

        <table>
            <thead>
            <tr>
                <th>Imagen</th>
                <th>Título</th>
                <th>Año</th>
                <th>Categoría</th>
                <th>Descripción</th>
                <th style="width:180px;">Acciones</th>
            </tr>
            </thead>
            <tbody>
            <% if (peliculas != null && !peliculas.isEmpty()) {
                   for (Pelicula p : peliculas) {
                       String img = p.getImagen();
                       String src = (img != null && !img.trim().isEmpty())
                               ? (ctx + "/assets/img/" + img.trim())
                               : "";
            %>
                <tr>
                    <td>
                        <% if (!src.isEmpty()) { %>
                            <img class="miniimg" src="<%=src%>" alt="img">
                        <% } else { %>
                            <div class="miniimg"></div>
                        <% } %>
                    </td>
                    <td><b><%=p.getTitulo()%></b></td>
                    <td><%=p.getAnio()%></td>
                    <td><span class="pill"><%=p.getCategoriaNombre()%></span></td>
                    <td style="color:#cfcfcf;"><%=p.getDescripcion()%></td>
                    <td>
                        <a class="link" href="<%=ctx%>/registrarPeliculas?action=edit&id=<%=p.getIdPelicula()%>">Editar</a>

                        &nbsp;|&nbsp;

                        <form class="form-inline" method="post" action="<%=ctx%>/registrarPeliculas"
                              onsubmit="return confirm('¿Eliminar esta película?');">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="id" value="<%=p.getIdPelicula()%>"/>
                            <button type="submit" class="btn btn-danger" style="padding:6px 10px;">Eliminar</button>
                        </form>
                    </td>
                </tr>
            <%     }
               } else { %>
                <tr><td colspan="6" style="color:#aaa;">No hay películas registradas.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>

</div>
</body>
</html>
