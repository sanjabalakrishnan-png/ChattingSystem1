package com.chatting.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.chatting.util.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                // Store logged-in user name in session
                request.getSession().setAttribute("username", username);

                response.sendRedirect("chat.jsp");

            } else {

                response.getWriter().println("Invalid username or password");

            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
            response.getWriter().println("Database connection error");

        }
    }
}