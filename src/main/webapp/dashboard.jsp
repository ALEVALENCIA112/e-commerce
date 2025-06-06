<%-- dashboard.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String correoUsuario = (String) session.getAttribute("usuarioCorreo");
    Integer rolUsuario = (Integer) session.getAttribute("usuarioRol");

    if (correoUsuario == null || rolUsuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
     <link rel="stylesheet" type="text/css" href="estilos/estilos.css">
     <link rel="stylesheet" type="text/css" href="estilos/body.css">
     <link rel="stylesheet" type="text/css" href="estilos/header.css">
     <link rel="stylesheet" type="text/css" href="estilos/footer.css">
     <link rel="stylesheet" type="text/css" href="estilos/section.css">
     <link rel="stylesheet" type="text/css" href="estilos/aside.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Bienvenido</h1>
        </header>
        <nav>
            <% if (rolUsuario == 1) { %>
                 <a href="registroUsuario.jsp">Registro de Usuarios</a>
            <% } else if (rolUsuario == 2) { %>
                 <a href="productos.jsp">Productos</a>
                 <a href="categoria.jsp">Categorias</a>
                 <a href="carrito.jsp">Carrito de Compras</a> <% } else if (rolUsuario == 3) { %>
                 <a href="cambiarContrasena.jsp">Cambiar Contraseña</a>
                 <a href="gestion.jsp">Gestion Productos</a>
            <% } %>
            <a href="cerrarSesion.jsp">Cerrar Sesión</a>
         </nav>
        <main>
            <section>
                <h2>Bienvenido, <%= correoUsuario %></h2>
                <p>Tu rol es: <%= rolUsuario %></p>
                </section>
        </main>
        <aside>
            </aside>
        <footer>
            </footer>
    </div>
</body>
</html>