package com.jobportal.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class CredentialTest {
    private static final String URL = "jdbc:mysql://localhost:3306/job_portal";

    public static void main(String[] args) {
        String[] users = {"root", "Gauri"};
        String[] passwords = {"", "Gauri@1830", "password", "root", "admin"};

        for (String user : users) {
            for (String pass : passwords) {
                try {
                    Connection conn = DriverManager.getConnection(URL, user, pass);
                    System.out.println("SUCCESS: user=" + user + ", password=" + pass);
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
