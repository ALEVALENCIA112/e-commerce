<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manimec</title>
<link rel="stylesheet" type="text/css" href="estilos/body.css">
<link rel="stylesheet" type="text/css" href="estilos/header.css">
<link rel="stylesheet" type="text/css" href="estilos/footer.css">
<link rel="stylesheet" type="text/css" href="estilos/section.css">
<link rel="stylesheet" type="text/css" href="estilos/aside.css">
</head>
<body>
	<div class="container">
		<div class="border-container">
			<header>
				<h1>MANIMEC</h1>
				<h2>Muebles de calidad hechos con el mejor material</h2>
				<h3>Nos dedicamos a la creación de muebles en madera melaminica
					personalizados al gusto de cada persona</h3>

			</header>
		</div>

		<nav>

			<!-- <li> works for vertical align -->
			<!-- <ul> gives space for de nav -->
			<a href="index.html">Inicio</a> <a href="productos.jsp">Productos</a>
			<a href="categoria.jsp">Categorias</a> <a href="login.jsp">Login</a>

		</nav>

		<div class="inner-container-wrapper">

			<div class="inner-container">
				<section id="main-section">

					<form action="respuesta.jsp" method="post">

						<table border="1">
							<tr>
								<td>Nombre</td>
								<td><input type="text" name="txtnombre" /></td>
							</tr>
							<tr>
								<td>Cedula</td>
								<td><input type="text" name="txtcedula" maxlength="10" /></td>
							</tr>
							<tr>
								<td>Estado</td>
								<td><input type="text" name="txtestado" /></td>
							</tr>


							<tr>
								<td><input type="submit" name="btnenviar" id="btnenviar"
									value="EnviarRegistro" /></td>
								<td><input type="reset" /></td>
							</tr>

						</table>

					</form>

				</section>
			</div>

			<div class="inner-container">
				<!-- Content for the second inner container -->
				<aside>
					<h4>¿Dónde nos encontramos localizados?</h4>
					<iframe
						src="https://www.google.com/maps/d/embed?mid=1mJO3G0VHxNMk4XyZfGQmvqp0b4J3snI"
						width="600" height="450" style="border: 0;" allowfullscreen=""
						loading="lazy"> </iframe>

					<h3>
						Horario de atención:<br>Lunes a viernes de 09:00 a 17:00<br>
						Sabados de 10:00 a 16:00<br> Dirección: Pasaje S12c y Serapio
						Japerabi<br>Contáctanos al +593 98 211 0035
					</h3>
				</aside>

			</div>

		</div>

		<div class="border-container">
			<!-- Content for the footer container -->
			<footer>
				<div class="social-media-buttons">
					<a href="https://www.facebook.com" target="_blank"> <img
						src="img/facebook-button.png" alt="Facebook" class="social-icon"
						style="width: 50px; height: 50px;">
					</a> <a href="https://www.instagram.com" target="_blank"> <img
						src="img/instagram-button.png" alt="Instagram" class="social-icon"
						style="width: 50px; height: 50px;">
					</a> <a href="https://www.tiktok.com" target="_blank"> <img
						src="img/tiktok-button.jpg" alt="TikTok" class="social-icon"
						style="width: 50px; height: 50px;">
					</a>
				</div>
			</footer>

		</div>
	</div>
</body>
</html>
