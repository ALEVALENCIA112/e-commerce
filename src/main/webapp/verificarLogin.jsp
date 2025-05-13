<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.producto.bbdd.Conexion" %>
<%
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");

    Conexion con = new Conexion();
    ResultSet rs = null;
    try {
        if (con.getConexion() != null) {
            // 1. Consulta preparada para evitar inyección SQL
            String sql = "SELECT id_usuario, correo, clave, nombre FROM USUARIO WHERE correo = ?";
            PreparedStatement pstmt = con.getConexion().prepareStatement(sql);
            pstmt.setString(1, correo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String claveBD = rs.getString("clave");

                // 2. Comparar las contraseñas directamente
                if (claveBD.equals(clave)) {
                    // 3. Autenticación exitosa
                    session.setAttribute("usuarioId", rs.getInt("id_usuario"));
                    session.setAttribute("usuarioCorreo", rs.getString("correo"));
                    session.setAttribute("usuarioNombre", rs.getString("nombre"));
                    response.sendRedirect("registroUsuario.jsp"); // Redirigir a la página del portal
                } else {
                    // 4. Contraseña incorrecta
                    session.setAttribute("mensajeError", "La contraseña es incorrecta.");
                    response.sendRedirect("login.jsp");
                }
            } else {
                // 5. Usuario no encontrado
                session.setAttribute("mensajeError", "El correo electrónico no está registrado.");
                response.sendRedirect("login.jsp");
            }
        } else {
            // 6. Error al conectar con la base de datos
            session.setAttribute("mensajeError", "Error al conectar con la base de datos.");
            response.sendRedirect("login.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        // 7. Error al verificar el inicio de sesión
        session.setAttribute("mensajeError", "Ocurrió un error al verificar el inicio de sesión.");
        response.sendRedirect("login.jsp");
    } finally {
        try {
            if (rs != null) rs.close();
        } catch (SQLException e) {
            // Ignorar error al cerrar ResultSet
        }
        con.cerrarConexion();
    }
%>