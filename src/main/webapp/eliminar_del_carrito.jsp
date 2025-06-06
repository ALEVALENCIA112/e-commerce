<%-- eliminar_del_carrito.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.producto.bbdd.Carrito" %>
<%
    // Verificar si el usuario ha iniciado sesión como cliente
    Integer rolUsuario = (Integer) session.getAttribute("usuarioRol");
    if (rolUsuario == null || rolUsuario != 2) {
        response.sendRedirect("login.jsp"); // Redirigir si no es cliente
        return;
    }

    // Obtener el ID del producto a eliminar
    String idProductoEliminarStr = request.getParameter("id_producto");
    if (idProductoEliminarStr != null && !idProductoEliminarStr.isEmpty()) {
        try {
            int productoIdEliminar = Integer.parseInt(idProductoEliminarStr);

            // Obtener el carrito de la sesión
            Carrito carrito = (Carrito) session.getAttribute("carrito");

            if (carrito != null) {
                // Eliminar el ID del producto del carrito
                carrito.eliminarItem(productoIdEliminar);
                session.setAttribute("carrito", carrito); // Volver a guardar el carrito modificado

                // Opcional: Mostrar un mensaje de éxito
                String mensaje = "Producto con ID " + productoIdEliminar + " eliminado del carrito.";
                session.setAttribute("mensajeCarrito", mensaje);
            } else {
                String mensajeError = "El carrito no existe.";
                session.setAttribute("mensajeCarrito", mensajeError);
            }

        } catch (NumberFormatException e) {
            String mensajeError = "ID de producto no válido.";
            session.setAttribute("mensajeCarrito", mensajeError);
        }
    } else {
        String mensajeError = "No se proporcionó el ID del producto a eliminar.";
        session.setAttribute("mensajeCarrito", mensajeError);
    }

    // Redirigir de vuelta al carrito
    response.sendRedirect("carrito.jsp");
%>