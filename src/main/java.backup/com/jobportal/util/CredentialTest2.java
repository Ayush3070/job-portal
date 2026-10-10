package com.jobportal.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CredentialTest2 {
    private static final String URL = "jdbc:mysql://localhost:3306/";

    public static void main(String[] args) {
        String[] users = {"root", "Gauri"};
        String[] passwords = {"", "Gauri@1830", "password", "root", "admin"};

        for (String user : users) {
            for (String pass : passwords) {
                try {
                    Connection conn = DriverManager.getConnection(URL, user, pass);
                    System.out.println("Connected to MySQL server as user=" + user + ", password=" + pass);
                    try {
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SHOW DATABASES");
                        System.out.println("Databases:");
                        while (rs.next()) {
                            System.out.println("  " + rs.getString(1));
                        }
                        rs.close();
                        stmt.close();
                    } catch (SQLException e) {
                        System.err.println("Error showing databases: " + e.getMessage());
                    }
                    conn.close();
                    return;
                } catch (SQLException e) {
                    // System.out.println("Failed: user=" + user + ", password=" + pass + " - " + e.getMessage());
                }
            }
        }
        System.out.println("All credential attempts failed.");
    }
}
