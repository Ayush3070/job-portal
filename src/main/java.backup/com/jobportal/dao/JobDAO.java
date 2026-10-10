package com.jobportal.dao;

import com.jobportal.model.Job;
import com.jobportal.util.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    // Add a new job
    public boolean addJob(Job job) {
        String sql = "INSERT INTO jobs (title, company, location, job_type, salary, experience, description, requirements, skills, deadline, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, job.getTitle());
            stmt.setString(2, job.getCompany());
            stmt.setString(3, job.getLocation());
            stmt.setString(4, job.getJobType());
            stmt.setString(5, job.getSalary());
            stmt.setString(6, job.getExperience());
            stmt.setString(7, job.getDescription());
            stmt.setString(8, job.getRequirements());
            stmt.setString(9, job.getSkills());
            stmt.setDate(10, job.getDeadline() != null ? job.getDeadline() : null);
            stmt.setString(11, job.getStatus());
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all jobs
    public List<Job> getAllJobs() {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT * FROM jobs WHERE status = 'ACTIVE' ORDER BY posted_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Job job = new Job();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setCompany(rs.getString("company"));
                job.setLocation(rs.getString("location"));
                job.setJobType(rs.getString("job_type"));
                job.setSalary(rs.getString("salary"));
                job.setExperience(rs.getString("experience"));
                job.setDescription(rs.getString("description"));
                job.setRequirements(rs.getString("requirements"));
                job.setSkills(rs.getString("skills"));
                job.setPostedDate(rs.getTimestamp("posted_date").toLocalDateTime());
                job.setDeadline(rs.getDate("deadline"));
                job.setStatus(rs.getString("status"));
                jobs.add(job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return jobs;
    }

    // Get job by ID
    public Job getJobById(int id) {
        String sql = "SELECT * FROM jobs WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Job job = new Job();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setCompany(rs.getString("company"));
                job.setLocation(rs.getString("location"));
                job.setJobType(rs.getString("job_type"));
                job.setSalary(rs.getString("salary"));
                job.setExperience(rs.getString("experience"));
                job.setDescription(rs.getString("description"));
                job.setRequirements(rs.getString("requirements"));
                job.setSkills(rs.getString("skills"));
                job.setPostedDate(rs.getTimestamp("posted_date").toLocalDateTime());
                job.setDeadline(rs.getDate("deadline"));
                job.setStatus(rs.getString("status"));
                return job;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update job
    public boolean updateJob(Job job) {
        String sql = "UPDATE jobs SET title = ?, company = ?, location = ?, job_type = ?, salary = ?, experience = ?, description = ?, requirements = ?, skills = ?, deadline = ?, status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, job.getTitle());
            stmt.setString(2, job.getCompany());
            stmt.setString(3, job.getLocation());
            stmt.setString(4, job.getJobType());
            stmt.setString(5, job.getSalary());
            stmt.setString(6, job.getExperience());
            stmt.setString(7, job.getDescription());
            stmt.setString(8, job.getRequirements());
            stmt.setString(9, job.getSkills());
            stmt.setDate(10, job.getDeadline() != null ? job.getDeadline() : null);
            stmt.setString(11, job.getStatus());
            stmt.setInt(12, job.getId());
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete job
    public boolean deleteJob(int id) {
        String sql = "DELETE FROM jobs WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Search jobs
    public List<Job> searchJobs(String keyword, String location, String jobType, String experience) {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT * FROM jobs WHERE status = 'ACTIVE' AND (title LIKE ? OR company LIKE ? OR skills LIKE ?)";
        if (location != null && !location.isEmpty()) {
            sql += " AND location LIKE ?";
        }
        if (jobType != null && !jobType.isEmpty()) {
            sql += " AND job_type LIKE ?";
        }
        if (experience != null && !experience.isEmpty()) {
            sql += " AND experience LIKE ?";
        }
        sql += " ORDER BY posted_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            stmt.setString(paramIndex++, "%" + keyword + "%");
            stmt.setString(paramIndex++, "%" + keyword + "%");
            stmt.setString(paramIndex++, "%" + keyword + "%");
            if (location != null && !location.isEmpty()) {
                stmt.setString(paramIndex++, "%" + location + "%");
            }
            if (jobType != null && !jobType.isEmpty()) {
                stmt.setString(paramIndex++, "%" + jobType + "%");
            }
            if (experience != null && !experience.isEmpty()) {
                stmt.setString(paramIndex++, "%" + experience + "%");
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Job job = new Job();
                job.setId(rs.getInt("id"));
                job.setTitle(rs.getString("title"));
                job.setCompany(rs.getString("company"));
                job.setLocation(rs.getString("location"));
                job.setJobType(rs.getString("job_type"));
                job.setSalary(rs.getString("salary"));
                job.setExperience(rs.getString("experience"));
                job.setDescription(rs.getString("description"));
                job.setRequirements(rs.getString("requirements"));
                job.setSkills(rs.getString("skills"));
                job.setPostedDate(rs.getTimestamp("posted_date").toLocalDateTime());
                job.setDeadline(rs.getDate("deadline"));
                job.setStatus(rs.getString("status"));
                jobs.add(job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return jobs;
    }

    // Get count of jobs (for pagination)
    public int getJobCount(String keyword, String location, String jobType, String experience) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM jobs WHERE status = 'ACTIVE' AND (title LIKE ? OR company LIKE ? OR skills LIKE ?)";
        if (location != null && !location.isEmpty()) {
            sql += " AND location LIKE ?";
        }
        if (jobType != null && !jobType.isEmpty()) {
            sql += " AND job_type LIKE ?";
        }
        if (experience != null && !experience.isEmpty()) {
            sql += " AND experience LIKE ?";
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            stmt.setString(paramIndex++, "%" + keyword + "%");
            stmt.setString(paramIndex++, "%" + keyword + "%");
            stmt.setString(paramIndex++, "%" + keyword + "%");
            if (location != null && !location.isEmpty()) {
                stmt.setString(paramIndex++, "%" + location + "%");
            }
            if (jobType != null && !jobType.isEmpty()) {
                stmt.setString(paramIndex++, "%" + jobType + "%");
            }
            if (experience != null && !experience.isEmpty()) {
                stmt.setString(paramIndex++, "%" + experience + "%");
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}