<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet, java.sql.SQLException, com.producto.bbdd.Conexion"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Categorías - MANIMEC</title>
    <link rel="stylesheet" type="text/css" href="estilos/estilos.css">
    <link rel="stylesheet" type="text/css" href="estilos/body.css">
    <link rel="stylesheet" type="text/css" href="estilos/header.css">
    <link rel="stylesheet" type="text/css" href="estilos/footer.css">
    <link rel="stylesheet" type="text/css" href="estilos/section.css">
    <link rel="stylesheet" type="text/css" href="estilos/aside.css">
    <style>
        .product-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .product-item {
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }
        .product-image {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }
        .error-message {
            color: red;
            margin-top: 10px;
        }
    </style>
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
                <h2>Filtrar Productos por Categoría</h2>
                <form action="productos.jsp" method="get">
                    <label for="categoria">Selecciona una Categoría:</label>
                    <select name="categoria" id="categoria">
                        <option value="">Todas las Categorías</option>
                        <%
                            Conexion conCategorias = new Conexion();
                            ResultSet rsCategorias = null;
                            try {
                                if (conCategorias.getConexion() != null) {
                                    String sqlCategorias = "SELECT id_categoria, nombre FROM CATEGORIA";
                                    rsCategorias = conCategorias.ejecutarConsulta(sqlCategorias);

                                    if (rsCategorias != null) {
                                        while (rsCategorias.next()) {
                                            int idCategoria = rsCategorias.getInt("id_categoria");
                                            String nombreCategoria = rsCategorias.getString("nombre");
                        %>
                                            <option value="<%=idCategoria%>"><%=nombreCategoria%></option>
                        <%
                                        }
                                    } else {
                        %>
                                        <option value="" disabled>No hay categorías disponibles</option>
                        <%
                                    }
                                } else {
                        %>
                                    <option value="" disabled>Error de conexión</option>
                        <%
                                }
                            } catch (SQLException e) {
                        %>
                                <option value="" disabled>Error: <%=e.getMessage()%></option>
                        <%
                            } finally {
                                try { if (rsCategorias != null) rsCategorias.close(); } catch (SQLException e) {}
                                conCategorias.cerrarConexion();
                            }
                        %>
                    </select>
                    <input type="submit" value="Filtrar">
                </form>

                <%
                    String categoriaSeleccionadaStr = request.getParameter("categoria");
                    if (categoriaSeleccionadaStr != null && !categoriaSeleccionadaStr.isEmpty()) {
                        Conexion conProductos = new Conexion();
                        ResultSet rsProductos = null;
                        try {
                            if (conProductos.getConexion() != null) {
                                String sqlProductos = "SELECT id_producto, nombre, descripcion, precio, stock FROM PRODUCTO WHERE id_categoria = ?";
                                rsProductos = conProductos.ejecutarConsulta(sqlProductos, Integer.parseInt(categoriaSeleccionadaStr));
                %>
                                <h2>Productos en la Categoría</h2>
                                <div class="product-list">
                                    <%
                                        while (rsProductos.next()) {
                                            int idProducto = rsProductos.getInt("id_producto");
                                            String nombreProducto = rsProductos.getString("nombre");
                                            String descripcionProducto = rsProductos.getString("descripcion");
                                            double precioProducto = rsProductos.getDouble("precio");
                                            int stockProducto = rsProductos.getInt("stock");
                                            String imagenProducto = "img/" + nombreProducto.toLowerCase().replaceAll(" ", "_") + ".jpeg";
                                    %>
                                        <div class="product-item">
                                            <img src="<%= imagenProducto %>" alt="<%= nombreProducto %>" onerror="this.src='img/mueble_2.jpeg'" class="product-image">
                                            <h4><%= nombreProducto %></h4>
                                            <p><%= descripcionProducto %></p>
                                            <p>Precio: $<%= String.format("%.2f", precioProducto) %></p>
                                            <p>Disponibles: <%= stockProducto %> unidades</p>
                                            <form action="agregar_al_carrito.jsp" method="post">
                                                <input type="hidden" name="id_producto" value="<%= idProducto %>">
                                                <button type="submit">Añadir al carrito</button>
                                            </form>
                                        </div>
                                    <%
                                        }
                                    %>
                                </div>
                <%
                            } else {
                %>
                                <div class="error-message">Error al conectar con la base de datos para productos.</div>
                <%
                            }
                        } catch (SQLException e) {
                %>
                            <div class="error-message">Error al obtener productos por categoría: <%= e.getMessage() %></div>
                <%
                        } finally {
                            try { if (rsProductos != null) rsProductos.close(); } catch (SQLException e) {}
                            conProductos.cerrarConexion();
                        }
                    }
                %>

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