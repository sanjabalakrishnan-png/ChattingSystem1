package com.chatting.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/chatting_system";

    private static final String USER = "root";

    private static final String PASSWORD ="Sanju@123456";

    public static Connection getConnection() {

        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );

            System.out.println("Database connected successfully!");

        } catch (Exception e) {

            e.printStackTrace();
        }

        return con;
    }
}