package pe.cibertec.streaming.dao.impl;

import pe.cibertec.streaming.model.Usuario;

public interface UsuarioDAO {
    Usuario login(String usuario, String password);
}
