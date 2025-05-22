package com.producto.bbdd;

public class Producto {
    private int idProducto;
    private String nombreProd;
    private String descripcionProd;
    private double precioProd;
    private int stockProd;
    private int idCategoria;

    // Constructores
    public Producto() {
    }

    public Producto(String nombreProd, String descripcionProd, double precioProd, int stockProd, int idCategoria) {
        this.nombreProd = nombreProd;
        this.descripcionProd = descripcionProd;
        this.precioProd = precioProd;
        this.stockProd = stockProd;
        this.idCategoria = idCategoria;
    }

    public Producto(int idProducto, String nombreProd, String descripcionProd, double precioProd, int stockProd, int idCategoria) {
        this.idProducto = idProducto;
        this.nombreProd = nombreProd;
        this.descripcionProd = descripcionProd;
        this.precioProd = precioProd;
        this.stockProd = stockProd;
        this.idCategoria = idCategoria;
    }

    // Getters y Setters
    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombreProd() {
        return nombreProd;
    }

    public void setNombreProd(String nombreProd) {
        this.nombreProd = nombreProd;
    }

    public String getDescripcionProd() {
        return descripcionProd;
    }

    public void setDescripcionProd(String descripcionProd) {
        this.descripcionProd = descripcionProd;
    }

    public double getPrecioProd() {
        return precioProd;
    }

    public void setPrecioProd(double precioProd) {
        this.precioProd = precioProd;
    }

    public int getStockProd() {
        return stockProd;
    }

    public void setStockProd(int stockProd) {
        this.stockProd = stockProd;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }
}