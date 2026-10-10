package com.jobportal.controller;

import com.jobportal.dao.JobDAO;
import com.jobportal.model.Job;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.List;
@WebServlet("/jobs")
public class JobListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private JobDAO jobDAO;

    @Override
    public void init() throws ServletException {
        jobDAO = new JobDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String location = request.getParameter("location");
        String jobType = request.getParameter("jobType");
        String experience = request.getParameter("experience");
        String pageParam = request.getParameter("page");

        int page = 1;
        int recordsPerPage = 6;
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) { }
        }

        List<Job> jobs;
        int totalRecords;

        if (keyword == null || keyword.isEmpty() &&
            location == null || location.isEmpty() &&
            jobType == null || jobType.isEmpty() &&
            experience == null || experience.isEmpty()) {
            // No filters, get all jobs
            jobs = jobDAO.getAllJobs();
            totalRecords = jobs.size();
            // Apply pagination manually
            int fromIndex = (page - 1) * recordsPerPage;
            int toIndex = Math.min(fromIndex + recordsPerPage, jobs.size());
            jobs = jobs.subList(fromIndex, toIndex);
        } else {
            // With filters
            jobs = jobDAO.searchJobs(keyword, location, jobType, experience);
            totalRecords = jobDAO.getJobCount(keyword, location, jobType, experience);
            // Apply pagination manually
            int fromIndex = (page - 1) * recordsPerPage;
            int toIndex = Math.min(fromIndex + recordsPerPage, jobs.size());
            if (fromIndex < jobs.size()) {
                jobs = jobs.subList(fromIndex, toIndex);
            } else {
                jobs = java.util.Collections.emptyList();
            }
        }

        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        request.setAttribute("jobs", jobs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("keyword", keyword);
        request.setAttribute("location", location);
        request.setAttribute("jobType", jobType);
        request.setAttribute("experience", experience);

        request.getRequestDispatcher("/jobs.jsp").forward(request, response);
    }
}