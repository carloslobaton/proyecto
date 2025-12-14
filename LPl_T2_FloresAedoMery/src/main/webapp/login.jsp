<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    String msg = request.getParameter("msg"); // opcional: msg=error, msg=logout, etc.
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Acceso | Streaming Chic</title>
    <style>
        :root{
            --bg1:#0b0b12;
            --bg2:#141428;
            --card: rgba(255,255,255,.06);
            --stroke: rgba(255,255,255,.10);
            --txt:#f2f2f6;
            --muted:#b9b9c7;
            --pink:#ff4da6;
            --lila:#a78bfa;
            --mint:#34d399;
            --shadow: 0 18px 40px rgba(0,0,0,.40);
            --radius: 22px;
        }
        *{ box-sizing:border-box; }
        body{
            margin:0;
            font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial;
            color:var(--txt);
            min-height:100vh;
            background:
                radial-gradient(1200px 600px at 20% 10%, rgba(167,139,250,.18), transparent 55%),
                radial-gradient(1000px 500px at 80% 20%, rgba(255,77,166,.16), transparent 55%),
                linear-gradient(180deg, var(--bg1), var(--bg2));
            display:flex;
            align-items:center;
            justify-content:center;
            padding:28px;
        }
        .shell{
            width:min(980px, 100%);
            display:grid;
            grid-template-columns: 1.1fr .9fr;
            gap:18px;
        }
        .panel, .card{
            background:var(--card);
            border:1px solid var(--stroke);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            backdrop-filter: blur(10px);
        }
        .panel{
            padding:26px;
            position:relative;
            overflow:hidden;
        }
        .brand{
            display:flex;
            align-items:center;
            gap:10px;
            font-weight:900;
            letter-spacing:2px;
            text-transform:uppercase;
        }
        .dot{
            width:12px;height:12px;border-radius:999px;
            background: linear-gradient(135deg, var(--pink), var(--lila));
            box-shadow: 0 0 0 6px rgba(255,77,166,.12);
        }
        .headline{
            margin-top:18px;
            font-size:34px;
            line-height:1.05;
            font-weight:900;
        }
        .sub{
            margin-top:10px;
            color:var(--muted);
            max-width:44ch;
            font-size:14px;
        }
        .badges{
            display:flex; flex-wrap:wrap; gap:10px;
            margin-top:18px;
        }
        .badge{
            padding:8px 12px;
            border-radius:999px;
            border:1px solid rgba(255,255,255,.14);
            background: rgba(0,0,0,.18);
            color:#e7e7f3;
            font-size:12px;
        }
        .badge b{ color:#fff; }
        .glow{
            position:absolute;
            inset:-200px -200px auto auto;
            width:520px; height:520px;
            background: radial-gradient(circle at 30% 30%, rgba(255,77,166,.30), transparent 60%),
                        radial-gradient(circle at 70% 70%, rgba(167,139,250,.28), transparent 60%);
            filter: blur(18px);
            transform: rotate(18deg);
            pointer-events:none;
        }

        .card{ padding:22px; }
        .title{
            font-size:22px;
            font-weight:900;
            margin:0 0 10px 0;
        }
        label{
            display:block;
            font-size:12px;
            color:var(--muted);
            margin:12px 0 6px;
        }
        input{
            width:100%;
            padding:12px 12px;
            border-radius:14px;
            border:1px solid rgba(255,255,255,.14);
            background: rgba(0,0,0,.22);
            color:var(--txt);
            outline:none;
        }
        input:focus{
            border-color: rgba(167,139,250,.55);
            box-shadow: 0 0 0 4px rgba(167,139,250,.16);
        }
        .btn{
            margin-top:14px;
            width:100%;
            border:0;
            padding:12px 14px;
            border-radius:14px;
            cursor:pointer;
            font-weight:900;
            color:#0b0b12;
            background: linear-gradient(135deg, var(--pink), var(--lila));
        }
        .btn:hover{ filter: brightness(1.05); }
        .hint{
            margin-top:12px;
            color:var(--muted);
            font-size:12px;
            line-height:1.4;
        }
        .msgok, .msgerr{
            border-radius:14px;
            padding:10px 12px;
            margin-bottom:10px;
            font-size:13px;
        }
        .msgok{
            background: rgba(52,211,153,.14);
            border:1px solid rgba(52,211,153,.30);
            color:#dff7ee;
        }
        .msgerr{
            background: rgba(255,77,166,.12);
            border:1px solid rgba(255,77,166,.28);
            color:#ffe0f0;
        }

        @media (max-width: 860px){
            .shell{ grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<div class="shell">
    <div class="panel">
        <div class="glow"></div>
        <div class="brand">
            <span class="dot"></span>
            <span>STREAMING CHIC</span>
        </div>

        <div class="headline">Tu catálogo, con estilo ✨</div>
        <div class="sub">
            Accede para explorar el listado tipo Netflix/HBO y gestionar el CRUD de películas
            con categorías.
        </div>

        <div class="badges">
            <div class="badge">✅ Login con BD</div>
            <div class="badge">🎬 Listado tipo streaming</div>
            <div class="badge">🧩 CRUD + categorías</div>
            <div class="badge">💎 Diseño “chic”</div>
        </div>

        <div class="hint" style="margin-top:16px;">
            <b>Usuarios de prueba:</b><br>
            <b>mery</b> / <b>mery2025</b><br>
            <b>flores</b> / <b>flores789</b>
        </div>
    </div>

    <div class="card">
        <h2 class="title">Iniciar sesión</h2>

        <% if ("logout".equals(msg)) { %>
            <div class="msgok">✅ Sesión cerrada correctamente.</div>
        <% } else if ("error".equals(msg)) { %>
            <div class="msgerr">❌ Usuario o contraseña incorrectos.</div>
        <% } %>

        <form method="post" action="<%=ctx%>/login">
            <label>Usuario</label>
            <input name="usuario" placeholder="Ej: mery" required>

            <label>Contraseña</label>
            <input name="password" type="password" placeholder="••••••••" required>

            <button class="btn" type="submit">Entrar</button>

            <div class="hint">
                Tip: si te sale error, revisa que tu BD sea <b>bd_flores</b> y que tu
                <b>DBConnection.java</b> apunte a esa BD.
            </div>
        </form>
    </div>
</div>

</body>
</html>
