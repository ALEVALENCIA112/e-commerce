<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.producto.bbdd.Conexion, java.sql.SQLException" %>
<%
    String nombre = request.getParameter("nombre");
    String cedula = request.getParameter("cedula");
    int perfil = Integer.parseInt(request.getParameter("perfil"));
    int estadoCivil = Integer.parseInt(request.getParameter("estadoCivil"));
    String correo = request.getParameter("correo");
    String clave = "654321"; // Clave por defecto

    Conexion con = new Conexion();
    try {
        if (con.getConexion() != null) {
            String sql = "INSERT INTO tb_usuario (id_per, id_est, cedula_us, nombre_us, correo_us, clave_us) VALUES (?, ?, ?, ?, ?, ?)";
            int filasAfectadas = con.ejecutarActualizacion(sql, perfil, estadoCivil, cedula, nombre, correo, clave);

            if (filasAfectadas > 0) {
                session.setAttribute("mensaje", "Usuario registrado con éxito.");
            } else {
                session.setAttribute("error", "Error al registrar el usuario.");
            }
        } else {
            session.setAttribute("error", "Error al conectar con la base de datos.");
        }
    } catch (SQLException e) {
        session.setAttribute("error", "Error al registrar el usuario: " + e.getMessage());
    } finally {
        con.cerrarConexion();
        response.sendRedirect("registroUsuario.jsp"); // Redirigir de vuelta a la página de registro
    }
%>