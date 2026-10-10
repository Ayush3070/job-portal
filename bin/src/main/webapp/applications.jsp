<![CDATA[
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Applications - JobPortal</title>
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
                    <h1 class="display-5">My Applications</h1>
                    <p class="text-muted">Track your job application status</p>
                </header>
                
                <c:if test="${not empty applications && !empty applications}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Job Title</th>
                                    <th>Company</th>
                                    <th>Location</th>
                                    <th>Application Date</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="app" items="${applications}">
                                    <tr>
                                        <td>
                                            <strong>${app.jobTitle}</strong>
                                        </td>
                                        <td>
                                            ${app.companyName}
                                        </td>
                                        <td>
                                            ${app.location}
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${app.applicationDate}" pattern="MMM dd, yyyy" />
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${app.status == 'Applied'}">
                                                    <span class="badge bg-primary">${app.status}</span>
                                                </c:when>
                                                <c:when test="${app.status == 'Under Review'}">
                                                    <span class="badge bg-warning text-dark">${app.status}</span>
                                                </c:when>
                                                <c:when test="${app.status == 'Shortlisted'}">
                                                    <span class="badge bg-info text-white">${app.status}</span>
                                                </c:when>
                                                <c:when test="${app.status == 'Selected'}">
                                                    <span class="badge bg-success">${app.status}</span>
                                                </c:when>
                                                <c:when test="${app.status == 'Rejected'}">
                                                    <span class="badge bg-danger">${app.status}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">${app.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <a href="${pageContext.request.contextPath}/job-details?id=${app.jobId}" class="btn btn-sm btn-outline-primary">View Job</a>
                                                <a href="${pageContext.request.contextPath}/job-details?id=${app.jobId}" class="btn btn-sm btn-outline-secondary">View Application</a>
                                                <!-- In a real app, we would have a withdraw button -->
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                
                <c:if test="${empty applications}">
                    <div class="alert alert-info">
                        You haven't applied for any jobs yet. Start exploring opportunities!
                    </div>
                    <a href="${pageContext.request.contextPath}/jobs" class="btn btn-primary mt-3">Find Jobs</a>
                </c:if>
            </div>
        </section>
    </main>
    
    <%@ include file="footer.jsp" %>
</body>
</html>
]]>