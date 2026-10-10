package com.jobportal.model;

import java.time.LocalDateTime;
import java.sql.Date;

public class Job {
    private int id;
    private String title;
    private String company;
    private String location;
    private String jobType;
    private String salary;
    private String experience;
    private String description;
    private String requirements;
    private String skills;
    private LocalDateTime postedDate;
    private Date deadline;
    private String status;

    // Constructors
    public Job() {}

    public Job(int id, String title, String company, String location, String jobType, String salary, String experience,
               String description, String requirements, String skills, LocalDateTime postedDate, Date deadline, String status) {
        this.id = id;
        this.title = title;
        this.company = company;
        this.location = location;
        this.jobType = jobType;
        this.salary = salary;
        this.experience = experience;
        this.description = description;
        this.requirements = requirements;
        this.skills = skills;
        this.postedDate = postedDate;
        this.deadline = deadline;
        this.status = status;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRequirements() {
        return requirements;
    }

    public void setRequirements(String requirements) {
        this.requirements = requirements;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public LocalDateTime getPostedDate() {
        return postedDate;
    }

    public void setPostedDate(LocalDateTime postedDate) {
        this.postedDate = postedDate;
    }

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Job{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", company='" + company + '\'' +
                ", location='" + location + '\'' +
                ", jobType='" + jobType + '\'' +
                ", salary='" + salary + '\'' +
                ", experience='" + experience + '\'' +
                ", description='" + description + '\'' +
                ", requirements='" + requirements + '\'' +
                ", skills='" + skills + '\'' +
                ", postedDate=" + postedDate +
                ", deadline=" + deadline +
                ", status='" + status + '\'' +
                '}';
    }
}