package com.jobportal.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySQLRootTest {
    public static void main(String[] args) {
        String url = "jdbc:mysql://127.0.0.1:3306/";
        String user = "root";
        String password = "";

        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connected as root with no password!");
            conn.close();
        } catch (SQLException e) {
            System.err.println("Failed to connect as root with no password: " + e.getMessage());
        }

        // Try with password
        password = "root";
        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connected as root with password 'root'!");
            conn.close();
        } catch (SQLException e) {
            System.err.println("Failed to connect as root with password 'root': " + e.getMessage());
        }

        // Try with user 'Gauri' and password from DBConnection
        user = "Gauri";
        password = "Gauri@1830";
        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connected as Gauri with password from DBConnection!");
            conn.close();
        } catch (SQLException e) {
            System.err.println("Failed to connect as Gauri: " + e.getMessage());
        }
    }
}