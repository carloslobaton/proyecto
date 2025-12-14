package pe.cibertec.streaming.dao.impl;

import pe.cibertec.streaming.config.DBConnection;
import pe.cibertec.streaming.model.Categoria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAOImpl implements CategoriaDAO {

    @Override
    public List<Categoria> listarActivas() {
        List<Categoria> lista = new ArrayList<>();

        String sql = "SELECT id_categoria, nombre " +
                     "FROM tb_categoria " +
                     "WHERE estado = 1 " +
                     "ORDER BY nombre";

        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Categoria c = new Categoria();
                c.setIdCategoria(rs.getInt("id_categoria"));
                c.setNombre(rs.getString("nombre"));
                lista.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }
}
