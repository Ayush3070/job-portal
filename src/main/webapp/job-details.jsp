<![CDATA[
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Details - JobPortal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <main>
        <section class="py-5">
            <div class="container">
                <c:if test="${not empty job}">
                    <div class="row g-5">
                        <!-- Job Details -->
                        <div class="col-lg-8">
                            <div class="job-detail-header mb-4">
                                <h1 class="display-5">${job.title}</h1>
                                <div class="d-flex align-items-start mb-3">
                                    <img src="https://via.placeholder.com/60" alt="${job.company} Logo" class="company-logo me-3">
                                    <div>
                                        <h2 class="h5 mb-1">${job.company}</h2>
                                        <div class="job-meta mb-2">
                                            <span class="badge bg-secondary me-1">${job.location}</span>
                                            <span class="badge bg-secondary me-1">${job.jobType}</span>
                                            <span class="badge bg-secondary">${job.salary}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="job-meta-details mb-4">
                                    <p><i class="bi bi-calendar me-2"></i> Posted: <fmt:formatDate value="${job.postedDate}" pattern="MMM dd, yyyy" /></p>
                                    <p><i class="bi bi-clock-history me-2"></i> Experience: ${job.experience}</p>
                                    <p><i class="bi bi-calendar-check me-2"></i> Deadline: <fmt:formatDate value="${job.deadline}" pattern="MMM dd, yyyy" /></p>
                                </div>
                                
                                <div class="job-description mb-5">
                                    <h3>Job Description</h3>
                                    <p>${job.description}</p>
                                </div>
                                
                                <div class="job-responsibilities mb-5">
                                    <h3>Responsibilities</h3>
                                    <p>${job.requirements}</p>
                                </div>
                                
                                <div class="job-skills-section mb-5">
                                    <h3>Required Skills</h3>
                                    <div class="skills-tags mb-3">
                                        <c:set var="skillsArray" value="${fn:split(job.skills, ', ')}"/>
                                        <c:forEach var="skill" items="${skillsArray}">
                                            <span class="badge bg-primary me-1 mb-1">${skill}</span>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Apply Section -->
                        <div class="col-lg-4">
                            <div class="card h-100 border-0 shadow-sm">
                                <div class="card-body">
                                    <c:if test="${not empty hasApplied && hasApplied}">
                                        <div class="alert alert-info">
                                            <i class="bi bi-check-circle me-2"></i> Application Submitted
                                        </div>
                                    </c:if>
                                    <c:if test="${empty hasApplied || !hasApplied}">
                                        <h3>Apply for this Job</h3>
                                        <p class="text-muted">Join our team and make an impact.</p>
                                        <form id="applyForm" action="${pageContext.request.contextPath}/apply-job" method="post">
                                            <input type="hidden" name="jobId" value="${job.id}">
                                            <div class="mb-3">
                                                <label for="coverLetter" class="form-label">Cover Letter</label>
                                                <textarea class="form-control" id="coverLetter" name="coverLetter" rows="4" placeholder="Tell us why you're a great fit for this role..." required></textarea>
                                            </div>
                                            <div class="mb-3">
                                                <label for="resume" class="form-label">Resume (PDF, Max 2MB)</label>
                                                <input type="file" class="form-control" id="resume" name="resume" accept=".pdf,.doc,.docx">
                                                <small class="text-muted">Please upload your resume in PDF format</small>
                                            </div>
                                            <div class="d-grid">
                                                <button type="submit" class="btn btn-primary py-2">Apply Now</button>
                                            </div>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty job}">
                    <div class="alert alert-danger">
                        Job not found or has been removed.
                    </div>
                    <a href="${pageContext.request.contextPath}/jobs" class="btn btn-primary mt-3">Back to Job Listings</a>
                </c:if>
            </div>
        </section>
    </main>
    
    <%@ include file="footer.jsp" %>
</body>
</html>
]]>