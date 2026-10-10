package com.jobportal.controller;

import com.jobportal.dao.UserDAO;
import com.jobportal.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");
        String skills = request.getParameter("skills");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Update basic info
        currentUser.setFullName(fullName);
        currentUser.setEmail(email);
        currentUser.setPhone(phone);
        currentUser.setLocation(location);
        currentUser.setSkills(skills);

        // If password is provided, update it
        boolean passwordUpdated = false;
        if (password != null && !password.isEmpty()) {
            if (password.equals(confirmPassword)) {
                // Hash the new password
                String hashedPassword = org.mindrot.jbcrypt.BCrypt.hashpw(password, org.mindrot.jbcrypt.BCrypt.gensalt(10));
                currentUser.setPassword(hashedPassword);
                passwordUpdated = true;
            } else {
                request.setAttribute("error", "Passwords do not match");
                request.getRequestDispatcher("/profile.jsp").forward(request, response);
                return;
            }
        }

        // Update in database
        boolean success = userDAO.updateUser(currentUser);
        if (passwordUpdated) {
            // Also update password separately
            userDAO.updatePassword(currentUser.getId(), currentUser.getPassword());
        }

        if (success) {
            session.setAttribute("user", currentUser); // Update session
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile");
        }

        request.setAttribute("user", currentUser);
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
}