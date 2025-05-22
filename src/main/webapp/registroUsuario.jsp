<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet, java.sql.SQLException, com.producto.bbdd.Conexion, java.sql.PreparedStatement, java.sql.Connection, java.util.ArrayList, java.util.List" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuarios</title>
    <link rel="stylesheet" type="text/css" href="estilos/estilos.css">
    <link rel="stylesheet" type="text/css" href="estilos/body.css">
    <link rel="stylesheet" type="text/css" href="estilos/header.css">
    <link rel="stylesheet" type="text/css" href="estilos/footer.css">
    <link rel="stylesheet" type="text/css" href="estilos/section.css">
    <link rel="stylesheet" type="text/css" href="estilos/aside.css">
    <link rel="stylesheet" type="text/css" href="estilos/registroUsuario.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Registro de Usuarios</h1>
        </header>
        <nav>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="cerrarSesion.jsp">Cerrar Sesión</a>
        </nav>
        <main>
            <section id="main-section">
                <div class="form-container">
                    <h2>Registro de Usuarios Vendedores y Administradores</h2>
                    <form action="guardarUsuario.jsp" method="post">
                        <table>
                            <tr>
                                <td>Nombre y Apellido:</td>
                                <td><input type="text" name="nombre" required></td>
                            </tr>
                            <tr>
                                <td>Cédula:</td>
                                <td><input type="text" name="cedula" required></td>
                            </tr>
                            <tr>
                                <td>Tipo de Perfil:</td>
                                <td>
                                    <select name="perfil" required>
                                        <%
                                            Conexion con = new Conexion();
                                            ResultSet rsRol = null;
                                            PreparedStatement pstmtRol = null;
                                            Connection conn = null;
                                            List<String[]> roles = new ArrayList<>();
                                            try {
                                                conn = con.getConexion();
                                                if (conn != null) {
                                                    String sqlRol = "SELECT id_rol, nombre_rol FROM rol";
                                                    pstmtRol = conn.prepareStatement(sqlRol, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                                    rsRol = pstmtRol.executeQuery();
                                                    if (rsRol != null) {
                                                        while (rsRol.next()) {
                                                            roles.add(new String[]{rsRol.getInt("id_rol") + "", rsRol.getString("nombre_rol")});
                                                        }
                                                    }

                                                    // Define the desired order
                                                    String[] orderedRoles = {"Administrador", "Cliente", "Vendedor"};

                                                    for (String desiredRoleName : orderedRoles) {
                                                        for (String[] role : roles) {
                                                            if (role[1].equals(desiredRoleName)) {
                                                                out.println("<option value='" + role[0] + "'>" + role[1] + "</option>");
                                                                break; // Move to the next desired role
                                                            }
                                                        }
                                                    }

                                                } else {
                                                    out.println("<option value=''>Error al conectar</option>");
                                                }
                                            } catch (SQLException e) {
                                                out.println("<option value=''>Error: " + e.getMessage() + "</option>");
                                            } finally {
                                                try { if (rsRol != null) rsRol.close(); } catch (SQLException e) {}
                                                try { if (pstmtRol != null) pstmtRol.close(); } catch (SQLException e) {}
                                                con.cerrarConexion();
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Estado Civil:</td>
                                <td>
                                    <select name="estadoCivil" required>
                                        <option value="Soltero">Soltero</option>
                                        <option value="Casado">Casado</option>
                                        <option value="Divorciado">Divorciado</option>
                                        <option value="Viudo">Viudo</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Correo Electrónico:</td>
                                <td><input type="email" name="correo" required></td>
                            </tr>
                            <tr>
                                <td>Clave:</td>
                                <td><input type="password" name="clave" required></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <button type="submit">Guardar Usuario</button>
                                    <button type="reset">Limpiar</button>
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%
                        String mensaje = (String) session.getAttribute("mensaje");
                        if (mensaje != null) {
                            out.println("<p class='success-message'>" + mensaje + "</p>");
                            session.removeAttribute("mensaje");
                        }
                        String error = (String) session.getAttribute("error");
                        if (error != null) {
                            out.println("<p class='error-message'>" + error + "</p>");
                            session.removeAttribute("error");
                        }
                    %>
                </div>
            </section>
        </main>
        <aside>
        </aside>
        <footer>
        </footer>
    </div>
</body>
</html>