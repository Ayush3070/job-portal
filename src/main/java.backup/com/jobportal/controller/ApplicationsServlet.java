package com.jobportal.controller;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.dao.JobDAO;
import com.jobportal.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSession;

import java.util.List;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
@WebServlet("/applications")
public class ApplicationsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ApplicationDAO applicationDAO;
    private JobDAO jobDAO;

    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
        jobDAO = new JobDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        var applications = applicationDAO.getApplicationsByUser(user.getId());

        // Enrich applications with job and company details
        // In a real app, we might create a DTO, but for simplicity we'll set attributes in the request
        request.setAttribute("applications", applications);

        request.getRequestDispatcher("/applications.jsp").forward(request, response);
    }
}