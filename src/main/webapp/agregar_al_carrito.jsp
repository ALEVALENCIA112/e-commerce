<%-- agregar_al_carrito.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.producto.bbdd.Carrito" %>
<%
    // Verificar si el usuario ha iniciado sesión (solo clientes deberían poder añadir al carrito)
    Integer rolUsuario = (Integer) session.getAttribute("usuarioRol");
    if (rolUsuario == null || rolUsuario != 2) {
        response.sendRedirect("login.jsp"); // Redirigir a la página de login si no es cliente
        return;
    }

    // Obtener el ID del producto a añadir
    String idProductoStr = request.getParameter("id_producto");
    if (idProductoStr != null && !idProductoStr.isEmpty()) {
        try {
            int productoId = Integer.parseInt(idProductoStr);

            // Obtener el carrito de la sesión
            Carrito carrito = (Carrito) session.getAttribute("carrito");
            if (carrito == null) {
                // Si no existe un carrito en la sesión, crear uno nuevo
                carrito = new Carrito();
                session.setAttribute("carrito", carrito);
            }

            // Añadir el ID del producto al carrito
            carrito.agregarItem(productoId);

            // Opcional: Mostrar un mensaje de éxito
            String mensaje = "Producto con ID " + productoId + " añadido al carrito.";
            session.setAttribute("mensajeCarrito", mensaje);

        } catch (NumberFormatException e) {
            String mensajeError = "ID de producto no válido.";
            session.setAttribute("mensajeCarrito", mensajeError);
        }
    } else {
        String mensajeError = "No se proporcionó el ID del producto.";
        session.setAttribute("mensajeCarrito", mensajeError);
    }

    // Redirigir de vuelta a la página de productos o a donde el usuario estaba
    String referer = request.getHeader("referer");
    if (referer != null && !referer.isEmpty()) {
        response.sendRedirect(referer);
    } else {
        response.sendRedirect("productos.jsp"); // Si no hay referer, volver a la página de productos
    }
%>