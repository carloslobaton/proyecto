package pe.cibertec.streaming.dao.impl;

import java.sql.*;
import pe.cibertec.streaming.config.DBConnection;
import pe.cibertec.streaming.model.Usuario;

public class UsuarioDAOImpl implements UsuarioDAO {

    private static final String SQL_LOGIN =
            "SELECT id_usuario, usuario, password, nombre, correo, estado " +
            "FROM tb_usuario " +
            "WHERE usuario = ? AND password = ? AND estado = 1";

    @Override
    public Usuario login(String usuario, String password) {
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(SQL_LOGIN)) {

            ps.setString(1, usuario);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setIdUsuario(rs.getInt("id_usuario"));
                    u.setUsuario(rs.getString("usuario"));
                    u.setPassword(rs.getString("password"));
                    u.setNombre(rs.getString("nombre"));
                    u.setCorreo(rs.getString("correo"));
                    u.setEstado(rs.getInt("estado"));
                    return u;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
