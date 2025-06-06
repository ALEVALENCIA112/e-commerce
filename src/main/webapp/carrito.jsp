<%-- carrito.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.producto.bbdd.Carrito" %>
<%@ page import="com.producto.bbdd.ProductoDAO" %>
<%@ page import="com.producto.bbdd.Producto" %>
<%@ page import="java.util.ArrayList" %>
<%
    // Verificar si el usuario ha iniciado sesión como cliente
    Integer rolUsuario = (Integer) session.getAttribute("usuarioRol");
    if (rolUsuario == null || rolUsuario != 2) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Obtener el carrito de la sesión
    Carrito carrito = (Carrito) session.getAttribute("carrito");
    List<Integer> itemsEnCarrito = null;
    if (carrito != null) {
        itemsEnCarrito = carrito.getItems();
    } else {
        itemsEnCarrito = new ArrayList<>(); // Carrito vacío
    }

    ProductoDAO productoDAO = new ProductoDAO();
    List<Producto> productosEnCarrito = new ArrayList<>();
    if (itemsEnCarrito != null && !itemsEnCarrito.isEmpty()) {
        for (Integer productoId : itemsEnCarrito) {
            Producto producto = productoDAO.obtenerProducto(productoId);
            if (producto != null) {
                productosEnCarrito.add(producto);
            }
        }
    }

    String mensajeCarrito = (String) session.getAttribute("mensajeCarrito");
    if (mensajeCarrito != null) {
        // Mostrar el mensaje y luego limpiarlo de la sesión
        out.println("<p>" + mensajeCarrito + "</p>");
        session.removeAttribute("mensajeCarrito");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrito de Compras - MANIMEC</title>
    <link rel="stylesheet" type="text/css" href="estilos/estilos.css">
    <link rel="stylesheet" type="text/css" href="estilos/body.css">
    <link rel="stylesheet" type="text/css" href="estilos/header.css">
    <link rel="stylesheet" type="text/css" href="estilos/footer.css">
    <link rel="stylesheet" type="text/css" href="estilos/section.css">
    <link rel="stylesheet" type="text/css" href="estilos/aside.css">
    <style>
        .cart-container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .cart-item {
            border-bottom: 1px solid #eee;
            padding: 10px 0;
            display: flex;
            align-items: center;
        }
        .cart-item:last-child {
            border-bottom: none;
        }
        .cart-item img {
            max-height: 80px;
            margin-right: 15px;
        }
        .cart-item-details {
            flex-grow: 1;
        }
        .remove-button {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            margin-left: 10px;
        }
        .remove-button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Carrito de Compras - MANIMEC</h1>
        </header>
        <nav>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="productos.jsp">Productos</a>
            <a href="categoria.jsp">Categorias</a>
            <a href="cerrarSesion.jsp">Cerrar Sesión</a>
        </nav>
        <main>
            <section class="cart-container">
                <h2>Tu Carrito de Compras</h2>
                <% if (productosEnCarrito.isEmpty()) { %>
                    <p>Tu carrito está vacío.</p>
                <% } else { %>
                    <% for (Producto producto : productosEnCarrito) { %>
                        <div class="cart-item">
                            <% String imagenCarrito = "img/" + producto.getNombreProd().toLowerCase().replaceAll(" ", "_") + ".jpeg"; %>
                            <img src="<%= imagenCarrito %>" alt="<%= producto.getNombreProd() %>" onerror="this.src='img/mueble_2.jpeg'">
                            <div class="cart-item-details">
                                <h4><%= producto.getNombreProd() %></h4>
                                <p><%= producto.getDescripcionProd() %></p>
                                <p>Precio: $<%= String.format("%.2f", producto.getPrecioProd()) %></p>
                                <form action="eliminar_del_carrito.jsp" method="post">
                                    <input type="hidden" name="id_producto" value="<%= producto.getIdProducto() %>">
                                    <button type="submit" class="remove-button">Eliminar</button>
                                </form>
                            </div>
                        </div>
                    <% } %>
                    <% } %>
            </section>
        </main>
        <aside></aside>
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