package com.jobportal.controller;

import com.jobportal.dao.ApplicationDAO;
import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSession;

import java.util.List;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
@WebServlet("/job-details")
public class JobDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private JobDAO jobDAO;
    private ApplicationDAO applicationDAO;

    @Override
    public void init() throws ServletException {
        jobDAO = new JobDAO();
        applicationDAO = new ApplicationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/jobs");
            return;
        }

        int jobId;
        try {
            jobId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/jobs");
            return;
        }

        Job job = jobDAO.getJobById(jobId);
        if (job == null) {
            response.sendRedirect(request.getContextPath() + "/jobs");
            return;
        }

        HttpSession session = request.getSession(false);
        boolean hasApplied = false;
        if (session != null && session.getAttribute("user") != null) {
            com.jobportal.model.User user = (com.jobportal.model.User) session.getAttribute("user");
            hasApplied = applicationDAO.hasApplied(user.getId(), jobId);
        }

        request.setAttribute("job", job);
        request.setAttribute("hasApplied", hasApplied);

        request.getRequestDispatcher("/job-details.jsp").forward(request, response);
    }
}