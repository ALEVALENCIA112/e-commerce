<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Registro de Usuario</title>
        <link rel="stylesheet" type="text/css" href="estilos/estilos.css">
    </head>
    <body>
        <div class="container">
            <header>
                <h1>Registro de Usuario</h1>
            </header>
            <nav>
			<a href="index.html">Inicio</a>
		</nav>
            <main>
                <section>
                    <form action="respuesta.jsp" method="post">
                        <fieldset>
                            <legend>Información Personal</legend>
                            <table>
                                <tr>
                                    <td><label for="nombre">Nombre:</label></td>
                                    <td><input type="text" id="nombre" name="txtNombre" required></td>
                                </tr>
                                <tr>
                                    <td><label for="cedula">Cédula:</label></td>
                                    <td><input type="text" id="cedula" name="txtCedula" required maxlength="10"></td>
                                </tr>
                                <tr>
                                    <td><label for="estado">Estado Civil:</label></td>
                                    <td>
                                        <select id="estado" name="cmbEstado">
                                            <option value="Soltero">Soltero</option>
                                            <option value="Casado">Casado</option>
                                            <option value="Divorciado">Divorciado</option>
                                            <option value="Viudo">Viudo</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Lugar de Residencia:</td>
                                    <td>
                                        <input type="radio" id="residenciaSur" name="rdResidencia" value="Sur"> <label for="residenciaSur">Sur</label><br>
                                        <input type="radio" id="residenciaNorte" name="rdResidencia" value="Norte"> <label for="residenciaNorte">Norte</label><br>
                                        <input type="radio" id="residenciaCentro" name="rdResidencia" value="Centro"> <label for="residenciaCentro">Centro</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label for="foto">Foto:</label></td>
                                    <td><input type="file" id="foto" name="fileFoto" accept=".jpg, .jpeg, .png"></td>
                                </tr>
                                <tr>
                                    <td><label for="fecha">Mes y Año de Nacimiento:</label></td>
                                    <td><input type="month" id="fecha" name="mFecha"></td>
                                </tr>
                                <tr>
                                    <td><label for="color">Color Favorito:</label></td>
                                    <td><input type="color" id="color" name="cColor"></td>
                                </tr>
                                <tr>
                                    <td><label for="email">Correo:</label></td>
                                    <td><input type="email" id="email" name="txtEmail" required></td>
                                </tr>
                                <tr>
                                    <td><label for="clave">Clave:</label></td>
                                    <td><input type="password" id="clave" name="txtClave" required></td>
                                </tr>
                                <tr>
                                    <td><input type="submit" value="Registrar"></td>
                                    <td><input type="reset" value="Limpiar"></td>
                                </tr>
                            </table>
                        </fieldset>
                    </form>
                </section>
            </main>
            <footer>
                <p>&copy; 2024 Manimec</p>
            </footer>
        </div>
    </body>
    </html>