package com.jobportal.controller;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.dao.JobDAO;
import com.jobportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSession;

import java.util.List;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private JobDAO jobDAO;
    private ApplicationDAO applicationDAO;

    @Override
    public void init() throws ServletException {
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

        // Get statistics
        int jobsApplied = applicationDAO.getApplicationsByUser(user.getId()).size();
        int underReview = 0;
        int shortlisted = 0;
        int selected = 0;

        // We could get more detailed stats by checking status, but for simplicity we'll calculate from the list
        for (com.jobportal.model.Application app : applicationDAO.getApplicationsByUser(user.getId())) {
            switch (app.getStatus()) {
                case "Under Review":
                    underReview++;
                    break;
                case "Shortlisted":
                    shortlisted++;
                    break;
                case "Selected":
                    selected++;
                    break;
                default:
                    break;
            }
        }

        // Get recommended jobs (for simplicity, we'll get some active jobs)
        var recommendedJobs = jobDAO.getAllJobs().stream().limit(3).toList();

        request.setAttribute("user", user);
        request.setAttribute("jobsApplied", jobsApplied);
        request.setAttribute("underReview", underReview);
        request.setAttribute("shortlisted", shortlisted);
        request.setAttribute("selected", selected);
        request.setAttribute("recommendedJobs", recommendedJobs);

        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
}