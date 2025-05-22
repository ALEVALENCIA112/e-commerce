<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.producto.bbdd.Conexion" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Guardar Usuario</title>
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
            <h1>Guardar Usuario</h1>
        </header>
        <nav>
            <a href="index.html">Inicio</a>
            <a href="productos.jsp">Productos</a>
            <a href="categoria.jsp">Categorias</a>
            <a href="login.jsp">Login</a>
            <a href="registroUsuario.jsp">Registro de Usuarios</a>
        </nav>
        <main>
            <section id="main-section">
                <%
                    String nombre = request.getParameter("nombre");
                    String cedula = request.getParameter("cedula");
                    int perfil = Integer.parseInt(request.getParameter("perfil"));
                    String estadoCivil = request.getParameter("estadoCivil"); // Recibir como String
                    String correo = request.getParameter("correo");
                    String clave = request.getParameter("clave"); // Get the password from the form

                    Conexion con = new Conexion();
                    try {
                        if (con.getConexion() != null) {
                            String sql = "INSERT INTO usuario (nombre, cedula, id_rol, estado_civil, correo, clave) VALUES (?, ?, ?, ?, ?, ?)";
                            int filasAfectadas = con.ejecutarActualizacion(sql, nombre, cedula, perfil, estadoCivil, correo, clave);

                            if (filasAfectadas > 0) {
                                session.setAttribute("mensaje", "Usuario registrado con éxito.");
                            } else {
                                session.setAttribute("error", "Error al registrar el usuario.");
                            }
                        } else {
                            session.setAttribute("error", "Error al conectar a la base de datos.");
                        }
                    } catch (SQLException e) {
                        session.setAttribute("error", "Error: " + e.getMessage());
                        e.printStackTrace(); // Log the exception
                    } finally {
                        con.cerrarConexion();
                        response.sendRedirect("registroUsuario.jsp");
                    }
                %>
            </section>
        </main>
        <aside>
            </aside>
        <footer>
            </footer>
    </div>
</body>
</html>