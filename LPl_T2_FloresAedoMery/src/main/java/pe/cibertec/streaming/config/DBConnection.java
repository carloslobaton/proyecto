package pe.cibertec.streaming.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // 👇 OJO: tu BD se llama bd_avalos (según tus capturas)
    private static final String URL =
            "jdbc:mysql://localhost:3306/bd_flores"
            + "?useSSL=false"
            + "&allowPublicKeyRetrieval=true"
            + "&serverTimezone=America/Lima";

    // ✅ Usa las mismas credenciales con las que entras en MySQL Workbench
    private static final String USER = "root";
    private static final String PASS = "mysql";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL Connector/J moderno
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError("No se pudo cargar el driver MySQL: " + e.getMessage());
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
