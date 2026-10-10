package com.jobportal.util;

import java.io.IOException;
import java.net.Socket;

public class MySQLPortTest {
    public static void main(String[] args) {
        try (Socket socket = new Socket("localhost", 3306)) {
            System.out.println("Port 3306 is open - MySQL server might be running");
        } catch (IOException e) {
            System.err.println("Port 3306 is not open or MySQL server not reachable: " + e.getMessage());
        }
    }
}
