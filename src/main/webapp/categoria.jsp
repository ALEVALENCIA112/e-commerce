<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.ResultSet, java.sql.SQLException, com.producto.bbdd.Conexion"%>
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
</head>
<body>
	<div class="container">
		<header>
			<h1>MANIMEC</h1>
			<h2>Muebles de calidad hechos con el mejor material</h2>
			<h3>Nos dedicamos a la creación de muebles en madera melaminica
				personalizados al gusto de cada persona</h3>
		</header>
		<nav>
			<a href="index.html">Inicio</a> <a href="productos.jsp">Productos</a>
			<a href="categoria.jsp">Categorias</a> <a href="login.jsp">Login</a>
		</nav>
		<main>

			<section id="main-section">
				<h2>Filtrar Productos por Categoría</h2>
				<form action="productos.jsp" method="get">
					<label for="categoria">Selecciona una Categoría:</label> <select
						name="categoria" id="categoria">
						<option value="">Todas las Categorías</option>
						<%
						Conexion con = new Conexion();
						ResultSet rs = null;
						try {
							if (con.getConexion() != null) {
								String sql = "SELECT id_categoria, nombre FROM CATEGORIA";
								rs = con.ejecutarConsulta(sql);

								if (rs != null) {
							while (rs.next()) {
								int idCategoria = rs.getInt("id_categoria");
								String nombreCategoria = rs.getString("nombre");
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
						<option value="" disabled>Error:
							<%=e.getMessage()%></option>
						<%
						} finally {
						try {
							if (rs != null)
								rs.close();
						} catch (SQLException e) {
						}
						con.cerrarConexion();
						}
						%>
					</select> <input type="submit" value="Filtrar">
				</form>

			</section>


		</main>
		<aside>
			<h4>Datos del desarrollador</h4>
			<p>
				Nombre: Alejandro Valencia<br>Estudiante de 5to nivel en Ing.
				en Computación<br>Nivel de inglés B1
			</p>
			<h3>Perfil de Linkedin:</h3>
			<a href="https://www.linkedin.com/in/alejandro-valencia-4b8241323/">https://www.linkedin.com/in/alejandro-valencia-4b8241323/</a>
			<h4>¿Dónde nos encontramos localizados?</h4>
			<iframe
				src="https://www.google.com/maps/d/embed?mid=1mJO3G0VHxNMk4XyZfGQmvqp0b4J3snI"
				width="60%" height="50%" style="border: 0;" allowfullscreen=""
				loading="lazy"></iframe>
			<h3>
				Horario de atención:<br>Lunes a viernes de 09:00 a 17:00<br>
				Sábados de 10:00 a 16:00<br>Dirección: Pasaje S12c y Serapio
				Japerabi<br>Contáctanos al +593 98 211 0035
			</h3>
		</aside>
		<footer>
			<div class="social-media-buttons">
				<a href="https://www.facebook.com" target="_blank"> <img
					src="img/facebook-button.png" alt="Facebook" class="social-icon">
				</a> <a href="https://www.instagram.com" target="_blank"> <img
					src="img/instagram-button.png" alt="Instagram" class="social-icon">
				</a> <a href="https://www.tiktok.com" target="_blank"> <img
					src="img/tiktok-button.jpg" alt="TikTok" class="social-icon">
				</a>
			</div>
		</footer>
	</div>
</body>
</html>