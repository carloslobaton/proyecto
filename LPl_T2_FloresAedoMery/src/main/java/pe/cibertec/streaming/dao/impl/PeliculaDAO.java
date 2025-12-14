package pe.cibertec.streaming.dao.impl;

import java.util.List;
import pe.cibertec.streaming.model.Pelicula;

public interface PeliculaDAO {
    List<Pelicula> listarConCategoria();
    Pelicula buscarPorId(int id);
    boolean insertar(Pelicula p);
    boolean actualizar(Pelicula p);
    boolean eliminar(int id);
}
