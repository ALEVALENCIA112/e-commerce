package com.producto.bbdd;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    private Conexion con;

    public ProductoDAO() {
        con = new Conexion();
    }
    
    public List<Producto> listarProductos() {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT id_producto, nombre, descripcion, precio, stock, id_categoria FROM producto ORDER BY id_producto ASC"; // Agregamos ORDER BY
        try (Connection connection = con.getConexion();
             PreparedStatement pstmt = connection.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("id_producto"));
                producto.setNombreProd(rs.getString("nombre"));
                producto.setDescripcionProd(rs.getString("descripcion"));
                producto.setPrecioProd(rs.getDouble("precio"));
                producto.setStockProd(rs.getInt("stock"));
                producto.setIdCategoria(rs.getInt("id_categoria"));
                productos.add(producto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }

    public Producto obtenerProducto(int id) {
        Producto producto = null;
        String sql = "SELECT id_producto, nombre, descripcion, precio, stock, id_categoria FROM producto WHERE id_producto = ?"; // Asegúrate de que los nombres de las columnas son correctos
        try (Connection connection = con.getConexion();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    producto = new Producto();
                    producto.setIdProducto(rs.getInt("id_producto"));
                    producto.setNombreProd(rs.getString("nombre")); // Asegúrate de que los nombres de las columnas son correctos
                    producto.setDescripcionProd(rs.getString("descripcion")); // Asegúrate de que los nombres de las columnas son correctos
                    producto.setPrecioProd(rs.getDouble("precio")); // Asegúrate de que los nombres de las columnas son correctos
                    producto.setStockProd(rs.getInt("stock")); // Asegúrate de que los nombres de las columnas son correctos
                    producto.setIdCategoria(rs.getInt("id_categoria"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Imprime el error en la consola del servidor
            // Considera lanzar una excepción personalizada o loggear el error apropiadamente
        }
        return producto;
    }

    public boolean agregarProducto(Producto producto) {
        String sql = "INSERT INTO producto (nombre, descripcion, precio, stock, id_categoria) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = con.getConexion();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setString(1, producto.getNombreProd());
            pstmt.setString(2, producto.getDescripcionProd());
            pstmt.setDouble(3, producto.getPrecioProd());
            pstmt.setInt(4, producto.getStockProd());
            pstmt.setInt(5, producto.getIdCategoria());

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace(); // Imprime el error en la consola del servidor
            return false;
        }
    }

    public boolean actualizarProducto(Producto producto) {
        String sql = "UPDATE producto SET nombre = ?, descripcion = ?, precio = ?, stock = ?, id_categoria = ? WHERE id_producto = ?";
        try (Connection connection = con.getConexion();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setString(1, producto.getNombreProd());
            pstmt.setString(2, producto.getDescripcionProd());
            pstmt.setDouble(3, producto.getPrecioProd());
            pstmt.setInt(4, producto.getStockProd());
            pstmt.setInt(5, producto.getIdCategoria());
            pstmt.setInt(6, producto.getIdProducto());

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace(); // Imprime el error en la consola del servidor
            return false;
        }
    }

    public boolean eliminarProducto(int id) {
        String sql = "DELETE FROM producto WHERE id_producto = ?";
        try (Connection connection = con.getConexion();
             PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setInt(1, id);

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace(); // Imprime el error en la consola del servidor
            return false;
        }
    }
}