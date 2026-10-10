<![CDATA[
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Jobs - JobPortal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <main>
        <section class="py-5">
            <div class="container">
                <header class="mb-5">
                    <h1 class="display-5">Find Your Next Opportunity</h1>
                    <p class="text-muted">Search through thousands of job listings</p>
                </header>
                
                <!-- Search and Filters -->
                <div class="row g-4 mb-5">
                    <div class="col-md-4">
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                            <input type="text" class="form-control" placeholder="Search by title, company, or skill" name="keyword" value="${param.keyword}">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="location">
                            <option value="">All Locations</option>
                            <option value="New York" <c:if test="${param.location == 'New York'}">selected</c:if>>New York</option>
                            <option value="San Francisco" <c:if test="${param.location == 'San Francisco'}">selected</c:if>>San Francisco</option>
                            <option value="Seattle" <c:if test="${param.location == 'Seattle'}">selected</c:if>>Seattle</option>
                            <option value="Austin" <c:if test="${param.location == 'Austin'}">selected</c:if>>Austin</option>
                            <option value="Boston" <c:if test="${param.location == 'Boston'}">selected</c:if>>Boston</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="jobType">
                            <option value="">All Types</option>
                            <option value="Full-time" <c:if test="${param.jobType == 'Full-time'}">selected</c:if>>Full-time</option>
                            <option value="Part-time" <c:if test="${param.jobType == 'Part-time'}">selected</c:if>>Part-time</option>
                            <option value="Contract" <c:if test="${param.jobType == 'Contract'}">selected</c:if>>Contract</option>
                            <option value="Internship" <c:if test="${param.jobType == 'Internship'}">selected</c:if>>Internship</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="experience">
                            <option value="">All Experience</option>
                            <option value="0-1 years" <c:if test="${param.experience == '0-1 years'}">selected</c:if>>0-1 years</option>
                            <option value="1-3 years" <c:if test="${param.experience == '1-3 years'}">selected</c:if>>1-3 years</option>
                            <option value="3-5 years" <c:if test="${param.experience == '3-5 years'}">selected</c:if>>3-5 years</option>
                            <option value="5+ years" <c:if test="${param.experience == '5+ years'}">selected</c:if>>5+ years</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-grid">
                        <button type="submit" class="btn btn-primary">Search Jobs</button>
                    </div>
                </div>
                
                <!-- Jobs Grid -->
                <div class="row g-4">
                    <c:forEach var="job" items="${jobs}">
                        <div class="col-md-4">
                            <div class="job-card h-100 border shadow-sm">
                                <div class="job-card-header d-flex align-items-start">
                                    <img src="https://via.placeholder.com/50" alt="${job.company} Logo" class="company-logo me-3">
                                    <div>
                                        <h5 class="job-title mb-1">${job.title}</h5>
                                        <p class="company-name text-muted mb-2">${job.company}</p>
                                        <div class="job-meta mb-2">
                                            <span class="badge bg-secondary me-1">${job.jobType}</span>
                                            <span class="badge bg-secondary">${job.location}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="job-card-body">
                                    <p class="job-salary"><i class="bi bi-cash me-1"></i>${job.salary}</p>
                                    <p class="job-experience"><i class="bi bi-clock me-1"></i>${job.experience}</p>
                                    <div class="job-skills mb-3">
                                        <c:set var="skillsArray" value="${fn:split(job.skills, ', ')}"/>
                                        <c:forEach var="skill" items="${skillsArray}">
                                            <span class="badge bg-primary me-1 mb-1">${skill}</span>
                                        </c:forEach>
                                    </div>
                                    <p class="job-posted text-small text-muted">
                                        <i class="bi bi-calendar me-1"></i> Posted <fmt:formatDate value="${job.postedDate}" pattern="MMM dd, yyyy" />
                                    </p>
                                </div>
                                <div class="job-card-footer d-grid">
                                    <a href="${pageContext.request.contextPath}/job-details?id=${job.id}" class="btn btn-primary">View Details</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <!-- Show message if no jobs found -->
                    <c:if test="${empty jobs}">
                        <div class="col-12">
                            <div class="alert alert-info">
                                No jobs found matching your criteria. Try adjusting your search filters.
                            </div>
                        </div>
                    </c:if>
                </div>
                
                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Page navigation" class="mt-5">
                        <ul class="pagination justify-content-center">
                            <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                <a class="page-link" href="${pageContext.request.contextPath}/jobs?page=${currentPage - 1}<c:if test="${not empty param.keyword}">&keyword=${param.keyword}</c:if><c:if test="${not empty param.location}">&location=${param.location}</c:if><c:if test="${not empty param.jobType}">&jobType=${param.jobType}</c:if><c:if test="${not empty param.experience}">&experience=${param.experience}</c:if>">Previous</a>
                            </li>
                            <c:forEach var="pageNum" begin="1" end="${totalPages}">
                                <li class="page-item <c:if test="${pageNum == currentPage}">active</c:if>">
                                    <a class="page-link" href="${pageContext.request.contextPath}/jobs?page=${pageNum}<c:if test="${not empty param.keyword}">&keyword=${param.keyword}</c:if><c:if test="${not empty param.location}">&location=${param.location}</c:if><c:if test="${not empty param.jobType}">&jobType=${param.jobType}</c:if><c:if test="${not empty param.experience}">&experience=${param.experience}</c:if>">${pageNum}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                <a class="page-link" href="${pageContext.request.contextPath}/jobs?page=${currentPage + 1}<c:if test="${not empty param.keyword}">&keyword=${param.keyword}</c:if><c:if test="${not empty param.location}">&location=${param.location}</c:if><c:if test="${not empty param.jobType}">&jobType=${param.jobType}</c:if><c:if test="${not empty param.experience}">&experience=${param.experience}</c:if>">Next</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </section>
    </main>
    
    <%@ include file="footer.jsp" %>
</body>
</html>
]]>