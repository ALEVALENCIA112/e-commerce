<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet, java.sql.SQLException, com.producto.bbdd.Conexion"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos - MANIMEC</title>
    <link rel="stylesheet" type="text/css" href="estilos/body.css">
    <link rel="stylesheet" type="text/css" href="estilos/header.css">
    <link rel="stylesheet" type="text/css" href="estilos/footer.css">
    <link rel="stylesheet" type="text/css" href="estilos/section.css">
    <link rel="stylesheet" type="text/css" href="estilos/aside.css">
    <link rel="stylesheet" type="text/css" href="estilos/estilos.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>MANIMEC</h1>
            <h2>Muebles de calidad hechos con el mejor material</h2>
            <h3>Nos dedicamos a la creación de muebles en madera melaminica personalizados al gusto de cada persona</h3>
        </header>
        <nav>
            <a href="index.html">Inicio</a>
            <a href="productos.jsp">Productos</a>
            <a href="categoria.jsp">Categorias</a>
            <a href="login.jsp">Login</a>
        </nav>
        <main>
            <section id="main-section">
                <h2>Productos</h2>
                <div class="product-list">
                    <%
                        Conexion con = new Conexion();
                        ResultSet rs = null;
                        String categoriaIdStr = request.getParameter("categoria");
                        Integer categoriaId = null;
                        String sql;
                        boolean hayProductos = false;

                        try {
                            if (con.getConexion() != null) {
                                if (categoriaIdStr != null && !categoriaIdStr.isEmpty()) {
                                    try {
                                        categoriaId = Integer.parseInt(categoriaIdStr);
                                        sql = "SELECT nombre, descripcion, precio, stock FROM PRODUCTO WHERE id_categoria = ?";
                                        rs = con.ejecutarConsulta(sql, categoriaId);
                                    } catch (NumberFormatException e) {
                                        out.println("<div class='error-message'>Categoría no válida. Se mostrarán todos los productos.</div>");
                                        sql = "SELECT nombre, descripcion, precio, stock FROM PRODUCTO";
                                        rs = con.ejecutarConsulta(sql);
                                    }
                                } else {
                                    sql = "SELECT nombre, descripcion, precio, stock FROM PRODUCTO";
                                    rs = con.ejecutarConsulta(sql);
                                }

                                if (rs != null) {
                                    hayProductos = rs.isBeforeFirst();
                                    if (!hayProductos) {
                    %>
                                        <div class="error-message">No se encontraron productos para esta categoría.</div>
                    <%
                                    } else {
                                        while (rs.next()) {
                                            String nombre = rs.getString("nombre");
                                            String descripcion = rs.getString("descripcion");
                                            double precio = rs.getDouble("precio");
                                            int stock = rs.getInt("stock");
                                            String imagen = "img/" + nombre.toLowerCase().replaceAll(" ", "_") + ".jpeg";
                    %>
                                            <div class="product-item">
                                                <img src="<%= imagen %>" alt="<%= nombre %>" onerror="this.src='img/mueble_2.jpeg'" class="product-image">
                                                <h4 ><%= nombre %></h4>
                                                <p ><%= descripcion %></p>
                                                <p >Precio: $<%= String.format("%.2f", precio) %></p>
                                                <p >Disponibles: <%= stock %> unidades</p>
                                                <button >Añadir al carrito</button>
                                            </div>
                    <%
                                        }
                                    }
                                } else {
                    %>
                                    <div class="error-message">Error al obtener los productos.</div>
                    <%
                                }
                            } else {
                    %>
                                    <div class="error-message">Error al conectar con la base de datos.</div>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                    %>
                                <div class="error-message">Error: <%= e.getMessage() %></div>
                    <%
                        } finally {
                            try { if (rs != null) rs.close(); } catch (SQLException e) {}
                            con.cerrarConexion();
                        }
                    %>
                </div>
            </section>
        </main>
        <aside>
            <h4>Datos del desarrollador</h4>
            <p>Nombre: Alejandro Valencia<br>Estudiante de 5to nivel en Ing. en Computación<br>Nivel de inglés B1</p>
            <h3>Perfil de Linkedin:</h3>
            <a href="https://www.linkedin.com/in/alejandro-valencia-4b8241323/">https://www.linkedin.com/in/alejandro-valencia-4b8241323/</a>
            <h4>¿Dónde nos encontramos localizados?</h4>
            <iframe src="https://www.google.com/maps/d/embed?mid=1mJO3G0VHxNMk4XyZfGQmvqp0b4J3snI" width="60%" height="50%" style="border: 0;" allowfullscreen="" loading="lazy"></iframe>
            <h3>
                Horario de atención:<br>Lunes a viernes de 09:00 a 17:00<br>
                Sábados de 10:00 a 16:00<br>Dirección: Pasaje S12c y Serapio Japerabi<br>Contáctanos al +593 98 211 0035
            </h3>
        </aside>
        <footer>
            <div class="social-media-buttons">
                <a href="https://www.facebook.com" target="_blank">
                    <img src="img/facebook-button.png" alt="Facebook" class="social-icon">
                </a>
                <a href="https://www.instagram.com" target="_blank">
                    <img src="img/instagram-button.png" alt="Instagram" class="social-icon">
                </a>
                <a href="https://www.tiktok.com" target="_blank">
                    <img src="img/tiktok-button.jpg" alt="TikTok" class="social-icon">
                </a>
            </div>
        </footer>
    </div>
</body>
</html>