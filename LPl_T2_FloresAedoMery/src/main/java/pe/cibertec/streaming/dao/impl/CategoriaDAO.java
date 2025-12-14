package pe.cibertec.streaming.dao.impl;

import java.util.List;
import pe.cibertec.streaming.model.Categoria;

public interface CategoriaDAO {
    List<Categoria> listarActivas();
}
