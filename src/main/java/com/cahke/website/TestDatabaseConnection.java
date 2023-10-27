package com.cahke.website;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TestDatabaseConnection {
    public static void main(String[] args) {
        String url = "jdbc:h2:file:/home/rekcahle/test";

        try {
            Connection connection = DriverManager.getConnection(url);
            System.out.println("Conexão bem-sucedida!");
            connection.close();
        } catch (SQLException e) {
            System.err.println("Erro ao conectar ao banco de dados: " + e.getMessage());
        }
    }
}
