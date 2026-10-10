package com.jobportal.controller;

import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;
import com.jobportal.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.List;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
@WebServlet("/admin/jobs")
public class AdminJobServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private JobDAO jobDAO;

    @Override
    public void init() throws ServletException {
        jobDAO = new JobDAO();
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

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if ("delete".equals(action) && idParam != null) {
            int jobId;
            try {
                jobId = Integer.parseInt(idParam);
                boolean success = jobDAO.deleteJob(jobId);
                if (success) {
                    request.setAttribute("success", "Job deleted successfully");
                } else {
                    request.setAttribute("error", "Failed to delete job");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid job ID");
            }
        }

        List<Job> jobs = jobDAO.getAllJobs();
        request.setAttribute("jobs", jobs);
        request.getRequestDispatcher("/admin/jobs.jsp").forward(request, response);
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

        String action = request.getParameter("action");
        if ("add".equals(action) || "update".equals(action)) {
            Job job = new Job();
            job.setTitle(request.getParameter("title"));
            job.setCompany(request.getParameter("company"));
            job.setLocation(request.getParameter("location"));
            job.setJobType(request.getParameter("jobType"));
            job.setSalary(request.getParameter("salary"));
            job.setExperience(request.getParameter("experience"));
            job.setDescription(request.getParameter("description"));
            job.setRequirements(request.getParameter("requirements"));
            job.setSkills(request.getParameter("skills"));
            String deadlineParam = request.getParameter("deadline");
            if (deadlineParam != null && !deadlineParam.isEmpty()) {
                job.setDeadline(java.sql.Date.valueOf(deadlineParam));
            }
            job.setStatus(request.getParameter("status"));

            if ("add".equals(action)) {
                boolean success = jobDAO.addJob(job);
                if (success) {
                    request.setAttribute("success", "Job added successfully");
                } else {
                    request.setAttribute("error", "Failed to add job");
                }
            } else if ("update".equals(action)) {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    try {
                        int jobId = Integer.parseInt(idParam);
                        job.setId(jobId);
                        boolean success = jobDAO.updateJob(job);
                        if (success) {
                            request.setAttribute("success", "Job updated successfully");
                        } else {
                            request.setAttribute("error", "Failed to update job");
                        }
                    } catch (NumberFormatException e) {
                        request.setAttribute("error", "Invalid job ID");
                    }
                } else {
                    request.setAttribute("error", "Job ID is required for update");
                }
            }
        }

        // Refresh the job list
        List<Job> jobs = jobDAO.getAllJobs();
        request.setAttribute("jobs", jobs);
        request.getRequestDispatcher("/admin/jobs.jsp").forward(request, response);
    }
}