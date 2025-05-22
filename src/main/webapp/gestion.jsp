<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.producto.bbdd.Producto, com.producto.bbdd.ProductoDAO, jakarta.servlet.http.HttpServletRequest" %>
<%!
    String getParameterOrDefault(HttpServletRequest request, String paramName, String defaultValue) {
        String value = request.getParameter(paramName);
        return (value != null) ? value : defaultValue;
    }
%>
<%
    ProductoDAO productoDAO = new ProductoDAO();
    String mensaje = "";
    String accion = getParameterOrDefault(request, "accion", "");
    String form = getParameterOrDefault(request, "form", "");
    String idEditarStr = getParameterOrDefault(request, "id", "");
    Producto productoAEditar = null;

    // Obtener producto para editar (si se solicita)
    if ("editar".equals(form) && !idEditarStr.isEmpty()) {
        try {
            int id = Integer.parseInt(idEditarStr);
            productoAEditar = productoDAO.obtenerProducto(id);
            if (productoAEditar == null) {
                mensaje = "Producto no encontrado.";
            }
        } catch (NumberFormatException e) {
            mensaje = "ID de producto no válido.";
        }
    }

    // Procesar acciones CRUD
    if ("agregar".equals(accion)) {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String precioStr = request.getParameter("precio");
        String stockStr = request.getParameter("stock");
        String categoriaIdStr = request.getParameter("categoriaId");

        if (nombre != null && descripcion != null && precioStr != null && stockStr != null && categoriaIdStr != null) {
            try {
                double precio = Double.parseDouble(precioStr);
                int stock = Integer.parseInt(stockStr);
                int categoriaId = Integer.parseInt(categoriaIdStr);
                Producto nuevoProducto = new Producto(nombre, descripcion, precio, stock, categoriaId);
                if (productoDAO.agregarProducto(nuevoProducto)) {
                    mensaje = "Producto agregado con éxito.";
                } else {
                    mensaje = "Error al agregar el producto.";
                }
            } catch (NumberFormatException e) {
                mensaje = "Por favor, ingrese valores numéricos válidos.";
            }
        } else {
            mensaje = "Por favor, complete todos los campos.";
        }
    } else if ("editar".equals(accion)) {
        String idProductoStr = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String precioStr = request.getParameter("precio");
        String stockStr = request.getParameter("stock");
        String categoriaIdStr = request.getParameter("categoriaId");

        if (idProductoStr != null && nombre != null && descripcion != null && precioStr != null && stockStr != null && categoriaIdStr != null) {
            try {
                int idProducto = Integer.parseInt(idProductoStr);
                double precio = Double.parseDouble(precioStr);
                int stock = Integer.parseInt(stockStr);
                int categoriaId = Integer.parseInt(categoriaIdStr);
                Producto productoActualizado = new Producto(idProducto, nombre, descripcion, precio, stock, categoriaId);
                if (productoDAO.actualizarProducto(productoActualizado)) {
                    mensaje = "Producto actualizado con éxito.";
                } else {
                    mensaje = "Error al actualizar el producto.";
                }
            } catch (NumberFormatException e) {
                mensaje = "Por favor, ingrese valores numéricos válidos.";
            }
        } else {
            mensaje = "Por favor, complete todos los campos.";
        }
    } else if ("eliminar".equals(accion)) {
        String idProductoStr = request.getParameter("id");
        if (idProductoStr != null) {
            try {
                int idProducto = Integer.parseInt(idProductoStr);
                if (productoDAO.eliminarProducto(idProducto)) {
                    mensaje = "Producto eliminado con éxito.";
                } else {
                    mensaje = "Error al eliminar el producto.";
                }
            } catch (NumberFormatException e) {
                mensaje = "ID de producto no válido.";
            }
        } else {
            mensaje = "ID de producto no proporcionado.";
        }
    }

    // Obtener la lista de productos para mostrar
    List<Producto> productos = null;
    try {
        productos = productoDAO.listarProductos();
    } catch (Exception e) {
        mensaje = "Error al obtener la lista de productos: " + e.getMessage();
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Productos - MANIMEC</title>
    <link rel="stylesheet" type="text/css" href="estilos/estilos.css">
    <link rel="stylesheet" type="text/css" href="estilos/body.css">
    <link rel="stylesheet" type="text/css" href="estilos/header.css">
    <link rel="stylesheet" type="text/css" href="estilos/footer.css">
    <link rel="stylesheet" type="text/css" href="estilos/section.css">
    <link rel="stylesheet" type="text/css" href="estilos/aside.css">
    <style>
        .gestion-container {
            width: 90%;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .gestion-container h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .gestion-container table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .gestion-container th, .gestion-container td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .gestion-container th {
            background-color: #f2f2f2;
        }
        .gestion-container .actions a {
            margin-right: 10px;
            text-decoration: none;
        }
        .gestion-container .add-button {
            display: block;
            margin-bottom: 15px;
            padding: 10px 15px;
            background-color: #5cb85c;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            width: 150px;
        }
        .gestion-container .add-button:hover {
            background-color: #4cae4c;
        }
        .form-container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-container h3 {
            text-align: center;
            margin-bottom: 20px;
        }
        .form-container table {
            width: 100%;
        }
        .form-container table td {
            padding: 8px;
        }
        .form-container input[type="text"],
        .form-container input[type="number"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            margin-bottom: 10px;
        }
        .form-container button {
            padding: 10px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-container button:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
        }
        .success-message {
            color: green;
        }
        #agregarForm {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #eee;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        #agregarForm h3 {
            margin-top: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Gestión de Productos - MANIMEC</h1>
        </header>
        <nav>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="cambiarContrasena.jsp">Cambiar Contraseña</a>
            <a href="cerrarSesion.jsp">Cerrar Sesión</a>
        </nav>
        <main>
            <section class="gestion-container">
                <h2>Gestión de Productos</h2>
                <a href="?form=agregar" class="add-button">Agregar Nuevo Producto</a>
                <% if (!mensaje.isEmpty()) { %>
                    <p class="<%= mensaje.startsWith("Error") ? "error-message" : "success-message" %>"><%= mensaje %></p>
                <% } %>
                <% if (productos != null && !productos.isEmpty()) { %>
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Categoría ID</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Producto producto : productos) { %>
                                <tr>
                                    <td><%= producto.getIdProducto() %></td>
                                    <td><%= producto.getNombreProd() %></td>
                                    <td><%= producto.getDescripcionProd() %></td>
                                    <td><%= producto.getPrecioProd() %></td>
                                    <td><%= producto.getStockProd() %></td>
                                    <td><%= producto.getIdCategoria() %></td>
                                    <td class="actions">
                                        <a href="?form=editar&id=<%= producto.getIdProducto() %>">Editar</a>
                                        <a href="?accion=eliminar&id=<%= producto.getIdProducto() %>" onclick="return confirm('¿Estás seguro de eliminar este producto?')">Eliminar</a>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <p>No hay productos registrados.</p>
                <% } %>
            </section>

            <% if ("agregar".equals(form)) { %>
                <section id="agregarForm" class="form-container">
                    <h3>Agregar Nuevo Producto</h3>
                    <form method="post" action="?accion=agregar">
                        <table>
                            <tr>
                                <td>Nombre:</td>
                                <td><input type="text" name="nombre" required></td>
                            </tr>
                            <tr>
                                <td>Descripción:</td>
                                <td><input type="text" name="descripcion" required></td>
                            </tr>
                            <tr>
                                <td>Precio:</td>
                                <td><input type="number" name="precio" step="0.01" required></td>
                            </tr>
                            <tr>
                                <td>Stock:</td>
                                <td><input type="number" name="stock" required></td>
                            </tr>
                            <tr>
                                <td>Categoría ID:</td>
                                <td><input type="number" name="categoriaId" required></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <button type="submit">Guardar Producto</button>
                                </td>
                            </tr>
                        </table>
                    </form>
                </section>
            <% } else if ("editar".equals(form) && productoAEditar != null) { %>
                <section class="form-container">
                    <h3>Editar Producto</h3>
                    <form method="post" action="?accion=editar&id=<%= productoAEditar.getIdProducto() %>">
                        <table>
                            <tr>
                                <td>Nombre:</td>
                                <td><input type="text" name="nombre" value="<%= productoAEditar.getNombreProd() %>" required></td>
                            </tr>
                            <tr>
                                <td>Descripción:</td>
                                <td><input type="text" name="descripcion" value="<%= productoAEditar.getDescripcionProd() %>" required></td>
                            </tr>
                            <tr>
                                <td>Precio:</td>
                                <td><input type="number" name="precio" step="0.01" value="<%= productoAEditar.getPrecioProd() %>" required></td>
                            </tr>
                            <tr>
                                <td>Stock:</td>
                                <td><input type="number" name="stock" value="<%= productoAEditar.getStockProd() %>" required></td>
                            </tr>
                            <tr>
                                <td>Categoría ID:</td>
                                <td><input type="number" name="categoriaId" value="<%= productoAEditar.getIdCategoria() %>" required></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: center;">
                                    <button type="submit">Actualizar Producto</button>
                                </td>
                            </tr>
                        </table>
                    </form>
                </section>
            <% } %>
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