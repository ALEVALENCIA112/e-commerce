package com.producto.bbdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EstadoCivil {

    private Connection con;

    public EstadoCivil(Connection con) {
        this.con = con;
    }

    public String mostrarEstadoCivil() throws SQLException {
        StringBuilder sb = new StringBuilder();
        String sql = "SELECT descripcion_est FROM tb_estadocivil";
        try (PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                sb.append(rs.getString("descripcion_est")).append(",");
            }
            if (sb.length() > 0) {
                sb.deleteCharAt(sb.length() - 1); // Eliminar la última coma
            }
            return sb.toString();
        }
    }
}