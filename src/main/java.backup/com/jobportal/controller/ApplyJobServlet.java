package com.jobportal.controller;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.model.Application;
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
@WebServlet("/apply-job")
public class ApplyJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ApplicationDAO applicationDAO;

    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String jobIdParam = request.getParameter("jobId");
        String coverLetter = request.getParameter("coverLetter");
        // For resume, we would handle file upload, but for simplicity we'll just store a placeholder
        String resume = "resume.pdf"; // In a real app, you would handle file upload

        if (jobIdParam == null || jobIdParam.isEmpty() || coverLetter == null || coverLetter.isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/job-details.jsp").forward(request, response);
            return;
        }

        int jobId;
        try {
            jobId = Integer.parseInt(jobIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid job ID");
            request.getRequestDispatcher("/job-details.jsp").forward(request, response);
            return;
        }

        Application application = new Application();
        application.setUserId(user.getId());
        application.setJobId(jobId);
        application.setCoverLetter(coverLetter);
        application.setResume(resume);
        application.setStatus("Applied");

        boolean success = applicationDAO.applyForJob(application);

        if (success) {
            request.setAttribute("success", "Application submitted successfully!");
        } else {
            request.setAttribute("error", "You have already applied for this job or an error occurred.");
        }

        // Redirect back to job details with a message
        response.sendRedirect(request.getContextPath() + "/job-details?id=" + jobId + "&applied=" + success);
    }
}