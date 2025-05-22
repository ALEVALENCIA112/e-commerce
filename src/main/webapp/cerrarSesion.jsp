<%-- cerrarSesion.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // Invalidar la sesión actual
    response.sendRedirect("login.jsp"); // Redirigir a la página de inicio de sesión
%>