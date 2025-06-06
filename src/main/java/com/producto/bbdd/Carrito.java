// com/producto/bbdd/Carrito.java
package com.producto.bbdd;

import java.util.ArrayList;
import java.util.List;

public class Carrito {
    private List<Integer> items; // Por ahora, solo guardaremos los IDs de los productos

    public Carrito() {
        this.items = new ArrayList<>();
    }

    public List<Integer> getItems() {
        return items;
    }

    public void agregarItem(int productoId) {
        this.items.add(productoId);
    }

    public void eliminarItem(int productoId) {
        this.items.remove(Integer.valueOf(productoId)); // Necesitamos Integer.valueOf para remover por valor
    }

    // Podrías añadir métodos para obtener los productos completos del carrito
    // consultando la base de datos, calcular el total, etc.
}