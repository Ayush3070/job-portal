<![CDATA[
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Applications - JobPortal Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%@ include file="admin/sidebar.jsp" %>
    
    <div class="content p-4">
        <%@ include file="admin/header.jsp" %>
        
        <main class="mt-4">
            <div class="container-fluid">
                <h1 class="h3 mb-4">Manage Applications</h1>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success alert-dismissible fade show">
                        ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Applicant</th>
                                <th>Job</th>
                                <th>Company</th>
                                <th>Application Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="app" items="${applications}" varStatus="status">
                                <tr>
                                    <td>${status.index + 1}</td>
                                    <td>${app.applicantName}</td>
                                    <td>${app.jobTitle}</td>
                                    <td>${app.companyName}</td>
                                    <td><fmt:formatDate value="${app.applicationDate}" pattern="MMM dd, yyyy" /></td>
                                    <td>
                                        <select class="form-select form-select-sm status-select" data-application-id="${app.id}">
                                            <option value="Applied" <c:if test="${app.status == 'Applied'}">selected</c:if>>Applied</option>
                                            <option value="Under Review" <c:if test="${app.status == 'Under Review'}">selected</c:if>>Under Review</option>
                                            <option value="Shortlisted" <c:if test="${app.status == 'Shortlisted'}">selected</c:if>>Shortlisted</option>
                                            <option value="Rejected" <c:if test="${app.status == 'Rejected'}">selected</c:if>>Rejected</option>
                                            <option value="Selected" <c:if test="${app.status == 'Selected'}">selected</c:if>>Selected</option>
                                        </select>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-outline-primary view-app" data-application-id="${app.id}">
                                            <i class="bi bi-eye"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
        
        <%@ include file="admin/footer.jsp" %>
    </div>
    
    <script>
        // Handle status change
        document.querySelectorAll('.status-select').forEach(select => {
            select.addEventListener('change', function () {
                const applicationId = this.getAttribute('data-application-id');
                const status = this.value;
                
                // Send update request
                fetch('${pageContext.request.contextPath}/admin/applications', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `id=${applicationId}&status=${status}`
                })
                .then(response => response.text())
                .then(html => {
                    // Show success message
                    const alertDiv = document.createElement('div');
                    alertDiv.className = 'alert alert-success alert-dismissible fade show mt-3';
                    alertDiv.innerHTML = `
                        Application status updated successfully!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    `;
                    document.querySelector('.container-fluid').prepend(alertDiv);
                    
                    // Remove alert after 3 seconds
                    setTimeout(() => {
                        alertDiv.remove();
                    }, 3000);
                })
                .catch(error => {
                    console.error('Error:', error);
                    const alertDiv = document.createElement('div');
                    alertDiv.className = 'alert alert-danger alert-dismissible fade show mt-3';
                    alertDiv.innerHTML = `
                        Failed to update application status.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    `;
                    document.querySelector('.container-fluid').prepend(alertDiv);
                });
            });
        });
        
        // Handle view application (placeholder)
        document.querySelectorAll('.view-app').forEach(button => {
            button.addEventListener('click', function () {
                const applicationId = this.getAttribute('data-application-id');
                // In a real app, we would show a modal with application details
                alert('Viewing application details for application ID: ' + applicationId);
            });
        });
    </script>