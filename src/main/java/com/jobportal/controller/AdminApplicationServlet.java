package com.jobportal.controller;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.dao.JobDAO;
import com.jobportal.dao.UserDAO;
import com.jobportal.model.Application;
import com.jobportal.model.User;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
@WebServlet("/admin/applications")
public class AdminApplicationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ApplicationDAO applicationDAO;
    private JobDAO jobDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
        jobDAO = new JobDAO();
        userDAO = new UserDAO();
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

        List<Application> applications = applicationDAO.getAllApplications();
        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/admin/applications.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

        String idParam = request.getParameter("id");
        String status = request.getParameter("status");

        if (idParam != null && !idParam.isEmpty() && status != null && !status.isEmpty()) {
            int applicationId;
            try {
                applicationId = Integer.parseInt(idParam);
                boolean success = applicationDAO.updateApplicationStatus(applicationId, status);
                if (success) {
                    request.setAttribute("success", "Application status updated successfully");
                } else {
                    request.setAttribute("error", "Failed to update application status");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid application ID");
            }
        }

        // Refresh the application list
        List<Application> applications = applicationDAO.getAllApplications();
        request.setAttribute("applications", applications);
        request.getRequestDispatcher("/admin/applications.jsp").forward(request, response);
    }
}
