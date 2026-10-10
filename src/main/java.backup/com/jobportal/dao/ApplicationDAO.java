package com.jobportal.dao;

import com.jobportal.model.Application;
import com.jobportal.util.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    // Apply for a job
    public boolean applyForJob(Application application) {
        // First check if the user has already applied for this job
        if (hasApplied(application.getUserId(), application.getJobId())) {
            return false; // Already applied
        }
        String sql = "INSERT INTO applications (user_id, job_id, cover_letter, resume, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, application.getUserId());
            stmt.setInt(2, application.getJobId());
            stmt.setString(3, application.getCoverLetter());
            stmt.setString(4, application.getResume());
            stmt.setString(5, application.getStatus());
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get applications by user ID
    public List<Application> getApplicationsByUser(int userId) {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.*, j.title as job_title, j.company as company_name FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.id WHERE a.user_id = ? ORDER BY a.application_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("id"));
                app.setUserId(rs.getInt("user_id"));
                app.setJobId(rs.getInt("job_id"));
                app.setCoverLetter(rs.getString("cover_letter"));
                app.setResume(rs.getString("resume"));
                app.setApplicationDate(rs.getTimestamp("application_date").toLocalDateTime());
                app.setStatus(rs.getString("status"));
                // We are not setting job title and company in the Application model, but we could extend it if needed.
                applications.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return applications;
    }

    // Get all applications (for admin)
    public List<Application> getAllApplications() {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.*, u.full_name as applicant_name, j.title as job_title, j.company as company_name FROM applications a " +
                     "JOIN users u ON a.user_id = u.id " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "ORDER BY a.application_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("id"));
                app.setUserId(rs.getInt("user_id"));
                app.setJobId(rs.getInt("job_id"));
                app.setCoverLetter(rs.getString("cover_letter"));
                app.setResume(rs.getString("resume"));
                app.setApplicationDate(rs.getTimestamp("application_date").toLocalDateTime());
                app.setStatus(rs.getString("status"));
                applications.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return applications;
    }

    // Update application status
    public boolean updateApplicationStatus(int applicationId, String status) {
        String sql = "UPDATE applications SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, applicationId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check if user has already applied for a job
    public boolean hasApplied(int userId, int jobId) {
        String sql = "SELECT COUNT(*) FROM applications WHERE user_id = ? AND job_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, jobId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get applications for a specific job (for admin)
    public List<Application> getApplicationsByJob(int jobId) {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.*, u.full_name as applicant_name FROM applications a " +
                     "JOIN users u ON a.user_id = u.id WHERE a.job_id = ? ORDER BY a.application_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, jobId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("id"));
                app.setUserId(rs.getInt("user_id"));
                app.setJobId(rs.getInt("job_id"));
                app.setCoverLetter(rs.getString("cover_letter"));
                app.setResume(rs.getString("resume"));
                app.setApplicationDate(rs.getTimestamp("application_date").toLocalDateTime());
                app.setStatus(rs.getString("status"));
                applications.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return applications;
    }
}