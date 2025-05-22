<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.producto.bbdd.Conexion" %>
<%
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");

    Conexion con = new Conexion();
    ResultSet rs = null;
    try {
        if (con.getConexion() != null) {
            String sql = "SELECT id_usuario, correo, clave, nombre, id_rol FROM usuario WHERE correo = ?";
            PreparedStatement pstmt = con.getConexion().prepareStatement(sql);
            pstmt.setString(1, correo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String claveBD = rs.getString("clave");
                if (claveBD.equals(clave)) {
                    session.setAttribute("usuarioId", rs.getInt("id_usuario"));
                    session.setAttribute("usuarioCorreo", rs.getString("correo"));
                    session.setAttribute("usuarioNombre", rs.getString("nombre"));
                    int idRol = rs.getInt("id_rol");
                    session.setAttribute("usuarioRol", idRol); // Guardar el id_rol en la sesión
                    response.sendRedirect("dashboard.jsp"); // Redirigir al dashboard
                } else {
                    session.setAttribute("mensajeError", "La contraseña es incorrecta.");
                    response.sendRedirect("login.jsp");
                }
            } else {
                session.setAttribute("mensajeError", "El correo electrónico no está registrado.");
                response.sendRedirect("login.jsp");
            }
        } else {
            session.setAttribute("mensajeError", "Error al conectar con la base de datos.");
            response.sendRedirect("login.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        session.setAttribute("mensajeError", "Ocurrió un error al verificar el inicio de sesión.");
        response.sendRedirect("login.jsp");
    } finally {
        try {
            if (rs != null) rs.close();
        } catch (SQLException e) {
        }
        con.cerrarConexion();
    }
%>