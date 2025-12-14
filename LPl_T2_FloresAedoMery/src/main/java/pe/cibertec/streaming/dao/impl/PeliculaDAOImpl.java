package pe.cibertec.streaming.dao.impl;

import pe.cibertec.streaming.config.DBConnection;
import pe.cibertec.streaming.model.Pelicula;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PeliculaDAOImpl implements PeliculaDAO {

    @Override
    public List<Pelicula> listarConCategoria() {
        List<Pelicula> lista = new ArrayList<>();

        // OJO: en BD es portada_url, lo aliasamos como "imagen" para no tocar tu modelo/JSP
        String sql =
                "SELECT p.id_pelicula, p.titulo, p.descripcion, p.anio, " +
                "       p.portada_url AS imagen, " +
                "       p.id_categoria, c.nombre AS categoria_nombre " +
                "FROM tb_pelicula p " +
                "JOIN tb_categoria c ON c.id_categoria = p.id_categoria " +
                "ORDER BY p.id_pelicula DESC";

        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Pelicula p = new Pelicula();
                p.setIdPelicula(rs.getInt("id_pelicula"));
                p.setTitulo(rs.getString("titulo"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setAnio(rs.getInt("anio"));
                p.setImagen(rs.getString("imagen")); // <- viene de portada_url AS imagen
                p.setIdCategoria(rs.getInt("id_categoria"));
                p.setCategoriaNombre(rs.getString("categoria_nombre"));
                lista.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    @Override
    public Pelicula buscarPorId(int id) {
        // OJO: portada_url AS imagen
        String sql =
                "SELECT id_pelicula, titulo, descripcion, anio, " +
                "       portada_url AS imagen, id_categoria " +
                "FROM tb_pelicula WHERE id_pelicula = ?";

        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Pelicula p = new Pelicula();
                    p.setIdPelicula(rs.getInt("id_pelicula"));
                    p.setTitulo(rs.getString("titulo"));
                    p.setDescripcion(rs.getString("descripcion"));
                    p.setAnio(rs.getInt("anio"));
                    p.setImagen(rs.getString("imagen")); // <- portada_url
                    p.setIdCategoria(rs.getInt("id_categoria"));
                    return p;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean insertar(Pelicula p) {
        // OJO: en BD es portada_url (NO NULL)
        String sql =
                "INSERT INTO tb_pelicula (titulo, descripcion, anio, portada_url, id_categoria) " +
                "VALUES (?,?,?,?,?)";

        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, p.getTitulo());
            ps.setString(2, p.getDescripcion());
            ps.setInt(3, p.getAnio());
            ps.setString(4, p.getImagen());       // <- lo guardamos en portada_url
            ps.setInt(5, p.getIdCategoria());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean actualizar(Pelicula p) {
        String sql =
                "UPDATE tb_pelicula " +
                "SET titulo=?, descripcion=?, anio=?, portada_url=?, id_categoria=? " +
                "WHERE id_pelicula=?";

        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, p.getTitulo());
            ps.setString(2, p.getDescripcion());
            ps.setInt(3, p.getAnio());
            ps.setString(4, p.getImagen());       // <- portada_url
            ps.setInt(5, p.getIdCategoria());
            ps.setInt(6, p.getIdPelicula());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean eliminar(int id) {
        String sql = "DELETE FROM tb_pelicula WHERE id_pelicula=?";

        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}