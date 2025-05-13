package com.producto.bbdd;

import java.sql.*;

public class Conexion {

	private Connection con;
	private String url = "jdbc:postgresql://localhost:5432/bd_mobiliario";
	private String user = "postgres";
	private String password = "1234";
	private String driver = "org.postgresql.Driver";

	public Conexion() {
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			if (con == null) {
				throw new SQLException("Error al conectar a la base de datos.");
			}
		} catch (ClassNotFoundException e) {
			System.err.println("Driver de PostgreSQL no encontrado: " + e.getMessage());
		} catch (SQLException e) {
			System.err.println("Error de conexión a la base de datos: " + e.getMessage());
		}
	}

	public Connection getConexion() {
		return con;
	}

	public void cerrarConexion() {
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException e) {
			System.err.println("Error al cerrar la conexión: " + e.getMessage());
		}
	}

	// Usar PreparedStatement para prevenir inyección SQL
	public int ejecutarActualizacion(String sql, Object... parametros) throws SQLException {
		try (PreparedStatement pstmt = con.prepareStatement(sql)) {
			establecerParametros(pstmt, parametros);
			return pstmt.executeUpdate();
		}
	}

	public ResultSet ejecutarConsulta(String sql, Object... parametros) throws SQLException {
	    try {
	        PreparedStatement pstmt = con.prepareStatement(sql);
	        establecerParametros(pstmt, parametros);
	        ResultSet rs = pstmt.executeQuery(); // Guardar el ResultSet en una variable
	        return rs;
	    } catch (SQLException e) {
	        System.err.println("Error en la consulta SQL: " + e.getMessage() + " - SQL: " + sql); // Imprimir la consulta
	        return null;
	    }
	}

	private void establecerParametros(PreparedStatement pstmt, Object... parametros) throws SQLException {
		if (parametros != null) {
			for (int i = 0; i < parametros.length; i++) {
				pstmt.setObject(i + 1, parametros[i]);
			}
		}
	}

	public static void main(String[] args) {
		Conexion conn = new Conexion();
		if (conn.getConexion() != null) {
			System.out.println("Conexión exitosa!");
			conn.cerrarConexion();
		}
	}
}