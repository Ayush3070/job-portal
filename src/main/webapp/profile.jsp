<![CDATA[
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - JobPortal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <main>
        <section class="py-5">
            <div class="container">
                <c:if test="${not empty user}">
                    <!-- Profile Header -->
                    <div class="d-flex align-items-center mb-5">
                        <div class="flex-shrink-0">
                            <img src="https://via.placeholder.com/80" alt="Profile Avatar" class="rounded-circle">
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <h1>Welcome, ${user.fullName}!</h1>
                            <p class="text-muted">${user.email} • ${user.role == 'JOB_SEEKER' ? 'Job Seeker' : 'Admin'}</p>
                        </div>
                    </div>
                    
                    <!-- Statistics -->
                    <div class="row g-4 mb-5">
                        <div class="col-md-3">
                            <div class="stat-card bg-primary text-white text-center rounded">
                                <div class="stat-icon">
                                    <i class="bi bi-file-earmark-plus display-4"></i>
                                </div>
                                <div class="stat-number">${jobsApplied}</div>
                                <div class="stat-label">Jobs Applied</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-card bg-warning text-dark text-center rounded">
                                <div class="stat-icon">
                                    <i class="bi bi-hourglass-split display-4"></i>
                                </div>
                                <div class="stat-number">${underReview}</div>
                                <div class="stat-label">Under Review</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-card bg-info text-white text-center rounded">
                                <div class="stat-icon">
                                    <i class="bi bi-star display-4"></i>
                                </div>
                                <div class="stat-number">${shortlisted}</div>
                                <div class="stat-label">Shortlisted</div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stat-card bg-success text-white text-center rounded">
                                <div class="stat-icon">
                                    <i class="bi bi-check-circle display-4"></i>
                                </div>
                                <div class="stat-number">${selected}</div>
                                <div class="stat-label">Selected</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recommended Jobs -->
                    <div class="mb-5">
                        <h2 class="h4">Recommended Jobs</h2>
                        <div class="row g-4">
                            <c:forEach var="job" items="${recommendedJobs}">
                                <div class="col-md-6">
                                    <div class="job-card h-100 border shadow-sm">
                                        <div class="job-card-header d-flex align-items-start">
                                            <img src="https://via.placeholder.com/50" alt="${job.company} Logo" class="company-logo me-3">
                                            <div>
                                                <h5 class="job-title mb-1">${job.title}</h5>
                                                <p class="company-name text-muted mb-2">${job.company}</p>
                                            </div>
                                        </div>
                                        <div class="job-card-body">
                                            <p class="job-salary"><i class="bi bi-cash me-1"></i>${job.salary}</p>
                                            <p class="job-experience"><i class="bi bi-clock me-1"></i>${job.experience}</p>
                                            <div class="job-skills mb-2">
                                                <c:set var="skillsArray" value="${fn:split(job.skills, ', ')}"/>
                                                <c:forEach var="skill" items="${skillsArray}">
                                                    <span class="badge bg-primary me-1 mb-1">${skill}</span>
                                                </c:forEach>
                                            </div>
                                        </div>
                                        <div class="job-card-footer d-grid">
                                            <a href="${pageContext.request.contextPath}/job-details?id=${job.id}" class="btn btn-outline-primary">View Details</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    
                    <!-- Profile Completion -->
                    <div class="mb-5">
                        <h2 class="h4">Profile Completion</h2>
                        <div class="progress" style="height: 25px;">
                            <div class="progress-bar progress-bar-striped bg-success" role="progressbar" style="width: 80%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100">
                                80%
                            </div>
                        </div>
                        <p class="text-muted mt-2">Complete your profile to increase your chances of getting hired.</p>
                    </div>
                </c:if>
            </div>
        </section>
    </main>
    
    <%@ include file="footer.jsp" %>
</body>
</html>
]]>