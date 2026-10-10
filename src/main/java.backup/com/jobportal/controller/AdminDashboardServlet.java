package com.jobportal.controller;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.dao.JobDAO;
import com.jobportal.dao.UserDAO;
import com.jobportal.model.User;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private JobDAO jobDAO;
    private ApplicationDAO applicationDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        jobDAO = new JobDAO();
        applicationDAO = new ApplicationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        // Get statistics
        int totalUsers = userDAO.getAllUsers().size();
        int totalJobs = jobDAO.getAllJobs().size();
        int totalApplications = applicationDAO.getAllApplications().size();
        int pendingApplications = 0;
        for (com.jobportal.model.Application app : applicationDAO.getAllApplications()) {
            if ("Applied".equals(app.getStatus()) || "Under Review".equals(app.getStatus())) {
                pendingApplications++;
            }
        }

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalJobs", totalJobs);
        request.setAttribute("totalApplications", totalApplications);
        request.setAttribute("pendingApplications", pendingApplications);

        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}