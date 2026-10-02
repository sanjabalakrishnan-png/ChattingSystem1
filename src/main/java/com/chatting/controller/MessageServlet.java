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

@WebServlet("/message")
public class MessageServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String sender = request.getParameter("sender");
        String receiver = request.getParameter("receiver");
        String message = request.getParameter("message");

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO messages " +
                         "(sender, receiver, message) VALUES (?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, sender);
            ps.setString(2, receiver);
            ps.setString(3, message);

            ps.executeUpdate();

            ps.close();
            con.close();

            response.getWriter().println("Message sent successfully");

        } catch (Exception e) {

            e.printStackTrace();
            response.getWriter().println("Error saving message");

        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String sender = request.getParameter("sender");
        String receiver = request.getParameter("receiver");

        response.setContentType("text/html");

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT sender, receiver, message, message_time " +
                         "FROM messages " +
                         "WHERE (sender = ? AND receiver = ?) " +
                         "OR (sender = ? AND receiver = ?) " +
                         "ORDER BY message_time ASC";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, sender);
            ps.setString(2, receiver);
            ps.setString(3, receiver);
            ps.setString(4, sender);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                response.getWriter().println(
                    "<p><b>" +
                    rs.getString("sender") +
                    "</b> : " +
                    rs.getString("message") +
                    " <small>(" +
                    rs.getString("message_time") +
                    ")</small></p>"
                );
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {

            e.printStackTrace();
            response.getWriter().println("Error retrieving messages");

        }
    }
}