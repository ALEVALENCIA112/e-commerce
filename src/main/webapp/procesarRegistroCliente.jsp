<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.producto.bbdd.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Procesando Registro...</title>
</head>
<body>
    <%
        // 1. Recibir los datos del formulario (incluyendo cedula y estado civil)
        String nombre = request.getParameter("txtNombre");
        String cedula = request.getParameter("txtCedula");
        String estadoCivil = request.getParameter("cmbEstado");
        String residencia = request.getParameter("rdResidencia");
        String foto = request.getParameter("fileFoto"); // Considerar cómo manejar la subida de archivos
        String fechaNacimiento = request.getParameter("mFecha");
        String colorFavorito = request.getParameter("cColor");
        String correo = request.getParameter("txtEmail");
        String clave = request.getParameter("txtClave");

        // 2. Conectar a la base de datos
        Conexion conexion = new Conexion();
        Connection conn = conexion.getConexion();
        Usuario usuario = new Usuario(conn); // Usa la clase Usuario que ya tienes

        try {
            // 3. Insertar el nuevo usuario en la tabla 'usuario' (incluyendo cedula y estado_civil)
            String sql = "INSERT INTO usuario (correo, clave, nombre, id_rol, cedula, estado_civil) VALUES (?, ?, ?, 2, ?, ?)"; // id_rol = 2 para Cliente
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, correo);
                pstmt.setString(2, clave); // ¡¡¡ADVERTENCIA: Clave en texto plano!!!
                pstmt.setString(3, nombre);
                pstmt.setString(4, cedula);
                pstmt.setString(5, estadoCivil);

                int filasAfectadas = pstmt.executeUpdate();

                if (filasAfectadas > 0) {
                    out.println("<h1>Registro Exitoso</h1>");
                    out.println("<p>¡Usuario registrado como Cliente!</p>");
                    // Puedes agregar un enlace para redirigir al login, por ejemplo:
                    out.println("<a href='login.jsp'>Iniciar Sesión</a>");
                } else {
                    out.println("<h1>Error al Registrar</h1>");
                    out.println("<p>No se pudo registrar al usuario. Por favor, intente de nuevo.</p>");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Imprime el error en la consola del servidor
            out.println("<h1>Error en la Base de Datos</h1>");
            out.println("<p>Ocurrió un error al interactuar con la base de datos: " + e.getMessage() + "</p>");
        } finally {
            // 4. Cerrar la conexión
            conexion.cerrarConexion();
        }
    %>
</body>
</html>