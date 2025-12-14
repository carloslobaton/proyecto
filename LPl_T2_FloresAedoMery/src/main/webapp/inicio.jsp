<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();

    // Intento “tolerante” por si tus nombres de sesión varían
    String nombre = (String) session.getAttribute("nombre");
    if (nombre == null) nombre = (String) session.getAttribute("nombreUsuario");
    if (nombre == null) nombre = "Usuario";

    String usuario = (String) session.getAttribute("usuario");
    if (usuario == null) usuario = (String) session.getAttribute("user");
    if (usuario == null) usuario = "—";

    String correo = (String) session.getAttribute("correo");
    if (correo == null) correo = (String) session.getAttribute("email");
    if (correo == null) correo = "—";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inicio | Streaming Chic</title>
    <style>
        :root{
            --bg1:#070711;
            --bg2:#15152a;
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
                radial-gradient(900px 500px at 15% 10%, rgba(255,77,166,.14), transparent 60%),
                radial-gradient(900px 500px at 85% 15%, rgba(167,139,250,.16), transparent 60%),
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
        .brand{
            display:flex; align-items:center; gap:10px;
            font-weight:900; letter-spacing:2px;
        }
        .dot{
            width:12px;height:12px;border-radius:999px;
            background: linear-gradient(135deg, var(--pink), var(--lila));
            box-shadow: 0 0 0 6px rgba(167,139,250,.10);
        }
        .chip{
            display:flex; align-items:center; gap:10px;
            padding:10px 12px;
            border-radius:999px;
            border:1px solid rgba(255,255,255,.14);
            background: rgba(0,0,0,.18);
            color:#eaeaf7;
            font-size:13px;
        }
        .logout{
            margin-left:10px;
            text-decoration:none;
            font-weight:900;
            color:#0b0b12;
            padding:10px 14px;
            border-radius:999px;
            background: linear-gradient(135deg, var(--pink), var(--lila));
        }
        .wrap{
            max-width: 1100px;
            margin: 0 auto;
            padding: 24px 18px 40px;
        }
        .hero{
            display:flex;
            justify-content:space-between;
            align-items:flex-end;
            gap:14px;
            margin-top:10px;
        }
        h1{
            margin:0;
            font-size:34px;
            line-height:1.08;
            font-weight:950;
        }
        .sub{
            margin:10px 0 0;
            color:var(--muted);
            max-width:70ch;
            font-size:14px;
        }
        .grid{
            margin-top:18px;
            display:grid;
            grid-template-columns: 1fr 1fr;
            gap:14px;
        }
        .card{
            background:var(--card);
            border:1px solid var(--stroke);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding:18px;
            backdrop-filter: blur(10px);
        }
        .title{
            margin:0 0 10px;
            font-weight:900;
            font-size:16px;
        }
        .muted{ color:var(--muted); font-size:13px; }
        .btnrow{ display:flex; gap:10px; flex-wrap:wrap; margin-top:12px; }
        .btn{
            text-decoration:none;
            font-weight:900;
            padding:10px 14px;
            border-radius:14px;
            border:1px solid rgba(255,255,255,.14);
            background: rgba(0,0,0,.18);
            color: var(--txt);
        }
        .btn.primary{
            border:0;
            color:#0b0b12;
            background: linear-gradient(135deg, var(--pink), var(--lila));
        }
        @media (max-width: 860px){
            .grid{ grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<div class="top">
    <div class="brand">
        <span class="dot"></span>
        <span>STREAMING CHIC</span>
    </div>

    <div style="display:flex; align-items:center; gap:10px;">
        <div class="chip">👤 <b><%= nombre %></b></div>
        <a class="logout" href="<%=ctx%>/logout">Cerrar sesión</a>
    </div>
</div>

<div class="wrap">
    <div class="hero">
        <div>
            <h1>Panel de inicio</h1>
            <p class="sub">
                Sesión activa. Desde aquí puedes navegar al listado tipo streaming y al mantenimiento del catálogo (CRUD).
            </p>
        </div>
    </div>

    <div class="grid">
        <div class="card">
            <div class="title">Tu sesión</div>
            <div class="muted">Usuario: <b><%= usuario %></b></div>
            <div class="muted">Correo: <b><%= correo %></b></div>

            <div class="btnrow">
                <a class="btn primary" href="<%=ctx%>/peliculas">Ver Películas (tipo Netflix)</a>
                <a class="btn" href="<%=ctx%>/registrarPeliculas">Administrar Películas (CRUD)</a>
            </div>
        </div>

        <div class="card">
            <div class="title">Tips rápidos</div>
            <div class="muted">• Las películas se asocian a una categoría obligatoriamente.</div>
            <div class="muted">• La portada se toma desde <b>assets/img/</b> (según portada_url).</div>
            <div class="muted">• Si algo no lista, revisa la conexión y tu tabla <b>tb_pelicula</b>.</div>
        </div>
    </div>
</div>

</body>
</html>
