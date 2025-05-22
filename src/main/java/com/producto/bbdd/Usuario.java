package com.producto.bbdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Usuario {

    private Connection con;

    public Usuario(Connection con) {
        this.con = con;
    }

    public boolean verificarUsuario(String correo, String clave) {
        Conexion con = new Conexion();
        try (Connection conn = con.getConexion();
             PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT correo, clave FROM usuario WHERE LOWER(correo) = LOWER(?)")) {

            String correoIngresado = correo.trim().toLowerCase();
            String claveIngresada = clave.trim();

            pstmt.setString(1, correoIngresado);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String claveBaseDeDatos = rs.getString("clave").trim();
                    return claveBaseDeDatos.equals(claveIngresada); // Compara las claves directamente
                } else {
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            con.cerrarConexion();
        }
    }

    public boolean ingresarEmpleado(int nperfil, int nestado, String ncedula, String nnombre, String ncorreo) throws SQLException {
        String sql = "INSERT INTO tb_usuario (id_per, id_est, cedula_us, nombre_us, correo_us, clave_us) VALUES (?, ?, ?, ?, ?, '654321')"; // Clave por defecto
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, nperfil);
            pstmt.setInt(2, nestado);
            pstmt.setString(3, ncedula);
            pstmt.setString(4, nnombre);
            pstmt.setString(5, ncorreo);
            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean verificarClave(String correo, String aclave) throws SQLException {
        String sql = "SELECT COUNT(*) FROM tb_usuario WHERE correo_us = ? AND clave_us = ?";
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, correo);
            pstmt.setString(2, aclave);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
                return false;
            }
        }
    }

    public boolean coincidirClaves(String nclave, String nrepetir) {
        return nclave.equals(nrepetir);
    }

    public boolean cambiarClave(String ncorreo, String nclave) throws SQLException {
        String sql = "UPDATE tb_usuario SET clave_us = ? WHERE correo_us = ?";
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, nclave);
            pstmt.setString(2, ncorreo);
            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean registrarCliente(String correo, String clave, String nombre) throws SQLException {
        String sql = "INSERT INTO usuario (correo, clave, nombre, id_rol) VALUES (?, ?, ?, 2)";
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setString(1, correo);
            pstmt.setString(2, clave); // Almacena la contraseña sin hashear
            pstmt.setString(3, nombre);
            return pstmt.executeUpdate() > 0;
        }
    }
}