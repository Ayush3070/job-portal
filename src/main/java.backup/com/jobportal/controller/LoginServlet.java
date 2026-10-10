package com.jobportal.controller;

import com.jobportal.dao.UserDAO;
import com.jobportal.model.User;
import com.jobportal.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.time.LocalDateTime;

import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        User user = userDAO.loginUser(email, password);

        if (user != null) {
            // Check password using BCrypt
            if (BCrypt.checkpw(password, user.getPassword())) {
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                // Set session timeout to 30 minutes if remember me is not checked
                if (rememberMe == null) {
                    session.setMaxInactiveInterval(30 * 60); // 30 minutes
                } else {
                    // For remember me, we would typically use a cookie, but for simplicity we extend session
                    session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7 days
                }

                // Redirect based on role
                if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/dashboard");
                }
            } else {
                // Password mismatch
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else {
            // User not found
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Just show the login page (handled by login.jsp)
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}