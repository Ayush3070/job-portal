package com.jobportal.model;

import java.time.LocalDateTime;

public class Application {
    private int id;
    private int userId;
    private int jobId;
    private String coverLetter;
    private String resume;
    private LocalDateTime applicationDate;
    private String status;

    // Constructors
    public Application() {}

    public Application(int id, int userId, int jobId, String coverLetter, String resume, LocalDateTime applicationDate, String status) {
        this.id = id;
        this.userId = userId;
        this.jobId = jobId;
        this.coverLetter = coverLetter;
        this.resume = resume;
        this.applicationDate = applicationDate;
        this.status = status;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public String getCoverLetter() {
        return coverLetter;
    }

    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }

    public String getResume() {
        return resume;
    }

    public void setResume(String resume) {
        this.resume = resume;
    }

    public LocalDateTime getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(LocalDateTime applicationDate) {
        this.applicationDate = applicationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Application{" +
                "id=" + id +
                ", userId=" + userId +
                ", jobId=" + jobId +
                ", coverLetter='" + coverLetter + '\'' +
                ", resume='" + resume + '\'' +
                ", applicationDate=" + applicationDate +
                ", status='" + status + '\'' +
                '}';
    }
}