package com.producto.bbdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Perfil {

    private Connection con;

    public Perfil(Connection con) {
        this.con = con;
    }

    public String mostrarPerfil() throws SQLException {
        StringBuilder sb = new StringBuilder();
        String sql = "SELECT descripcion_per FROM tb_perfil WHERE descripcion_per != 'Cliente'";
        try (PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                sb.append(rs.getString("descripcion_per")).append(",");
            }
            if (sb.length() > 0) {
                sb.deleteCharAt(sb.length() - 1); // Eliminar la última coma
            }
            return sb.toString();
        }
    }
}