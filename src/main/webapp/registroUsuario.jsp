<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet, java.sql.SQLException, com.producto.bbdd.Conexion" %>
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
    <style>
        .form-container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-container table {
            width: 100%;
        }
        .form-container table td {
            padding: 8px;
        }
        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-container button {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-container button:hover {
            background-color: #45a049;
        }
        .error-message {
            color: red;
        }
        .success-message {
            color: green;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Registro de Usuarios</h1>
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
                <div class="form-container">
                    <h2>Registro de Usuarios Vendedores y Administradores</h2>
                    <form action="guardarUsuario.jsp" method="post">
                        <table>
                            <tr>
                                <td>Nombres y Apellidos:</td>
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
                                            ResultSet rsPerfil = null;
                                            try {
                                                if (con.getConexion() != null) {
                                                    String sqlPerfil = "SELECT id_per, descripcion_per FROM tb_perfil WHERE descripcion_per != 'Cliente'";
                                                    rsPerfil = con.ejecutarConsulta(sqlPerfil);
                                                    if (rsPerfil != null) {
                                                        while (rsPerfil.next()) {
                                                            out.println("<option value='" + rsPerfil.getInt("id_per") + "'>" + rsPerfil.getString("descripcion_per") + "</option>");
                                                        }
                                                    }
                                                } else {
                                                    out.println("<option value=''>Error al conectar</option>");
                                                }
                                            } catch (SQLException e) {
                                                out.println("<option value=''>Error: " + e.getMessage() + "</option>");
                                            } finally {
                                                try { if (rsPerfil != null) rsPerfil.close(); } catch (SQLException e) {}
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
                                        <%
                                            con = new Conexion(); // Re-instanciar la conexión
                                            ResultSet rsEstadoCivil = null;
                                            try {
                                                if (con.getConexion() != null) {
                                                    String sqlEstadoCivil = "SELECT id_est, descripcion_est FROM tb_estadocivil";
                                                    rsEstadoCivil = con.ejecutarConsulta(sqlEstadoCivil);
                                                    if (rsEstadoCivil != null) {
                                                        while (rsEstadoCivil.next()) {
                                                            out.println("<option value='" + rsEstadoCivil.getInt("id_est") + "'>" + rsEstadoCivil.getString("descripcion_est") + "</option>");
                                                        }
                                                    }
                                                } else {
                                                    out.println("<option value=''>Error al conectar</option>");
                                                }
                                            } catch (SQLException e) {
                                                out.println("<option value=''>Error: " + e.getMessage() + "</option>");
                                            } finally {
                                                try { if (rsEstadoCivil != null) rsEstadoCivil.close(); } catch (SQLException e) {}
                                                con.cerrarConexion();
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Correo Electrónico:</td>
                                <td><input type="email" name="correo" required></td>
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
                            session.removeAttribute("mensaje"); // Limpiar el mensaje
                        }
                        String error = (String) session.getAttribute("error");
                        if (error != null) {
                            out.println("<p class='error-message'>" + error + "</p>");
                            session.removeAttribute("error"); // Limpiar el error
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