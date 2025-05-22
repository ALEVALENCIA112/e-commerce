<%-- cambiarContrasena.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.producto.bbdd.Conexion" %>
<%
    String correoUsuario = (String) session.getAttribute("usuarioCorreo");
    if (correoUsuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String mensaje = null;
    String error = null;

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String nuevaClave = request.getParameter("nuevaClave");
        String confirmarClave = request.getParameter("confirmarClave");

        if (nuevaClave != null && nuevaClave.equals(confirmarClave)) {
            Conexion con = new Conexion();
            try {
                String sql = "UPDATE usuario SET clave = ? WHERE correo = ?";
                PreparedStatement pstmt = con.getConexion().prepareStatement(sql);
                pstmt.setString(1, nuevaClave);
                pstmt.setString(2, correoUsuario);
                int filasAfectadas = pstmt.executeUpdate();
                if (filasAfectadas > 0) {
                    mensaje = "Contraseña cambiada con éxito.";
                } else {
                    error = "Error al cambiar la contraseña.";
                }
            } catch (SQLException e) {
                error = "Error al actualizar la contraseña: " + e.getMessage();
                e.printStackTrace();
            } finally {
                con.cerrarConexion();
            }
        } else {
            error = "Las contraseñas no coinciden.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Cambiar Contraseña</title>
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
            <h1>Cambiar Contraseña</h1>
        </header>
        <nav>
             <a href="dashboard.jsp">Dashboard</a>
             <a href="gestion.jsp">Gestion Productos</a>             
             <a href="cerrarSesion.jsp">Cerrar Sesión</a>
        </nav>
        <main>
            <section>
                <% if (mensaje != null) { %>
                    <p class="success-message"><%= mensaje %></p>
                <% } %>
                <% if (error != null) { %>
                    <p class="error-message"><%= error %></p>
                <% } %>

                <form method="post">
                    Nueva Contraseña: <input type="password" name="nuevaClave" required><br>
                    Confirmar Contraseña: <input type="password" name="confirmarClave" required><br><br>
                    <input type="submit" value="Cambiar Contraseña">
                </form>
            </section>
        </main>
        <aside>
            </aside>
        <footer>
            </footer>
    </div>
</body>
</html>