<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión - MANIMEC</title>
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
            <h1>Iniciar Sesión</h1>
        </header>
        <nav>
			<a href="index.html">Inicio</a> <a href="productos.jsp">Productos</a>
			<a href="categoria.jsp">Categorias</a> <a href="login.jsp">Login</a>
		</nav>
        <main>
            <section>
                <h2>Ingresa tus credenciales</h2>
                <%
                    String mensajeError = (String) session.getAttribute("mensajeError");
                    if (mensajeError != null) {
                        out.println("<p class='error-message'>" + mensajeError + "</p>");
                        session.removeAttribute("mensajeError"); // Limpiar el mensaje después de mostrarlo
                    }
                %>
                <form action="verificarLogin.jsp" method="post">
                    <label for="correo">Correo:</label><br>
                    <input type="email" id="correo" name="correo" required><br><br>
                    <label for="clave">Clave:</label><br>
                    <input type="password" id="clave" name="clave" required><br><br>
                    <input type="submit" value="Iniciar Sesión">
                </form>
                <p>¿No tienes cuenta? <a href="registro.jsp">Regístrate aquí</a></p>  </section>
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