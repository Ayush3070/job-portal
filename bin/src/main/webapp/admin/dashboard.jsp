<![CDATA[
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - JobPortal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="d-flex">
        <%@ include file="admin/sidebar.jsp" %>
        
        <div class="content p-4">
            <%@ include file="admin/header.jsp" %>
            
            <main class="mt-4">
                <div class="container-fluid">
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title">Total Users</h5>
                                    <p class="card-text display-4">${totalUsers}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title">Total Jobs</h5>
                                    <p class="card-text display-4">${totalJobs}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title">Total Applications</h5>
                                    <p class="card-text display-4">${totalApplications}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card h-100">
                                <div class="card-body">
                                    <h5 class="card-title">Pending Applications</h5>
                                    <p class="card-text display-4">${pendingApplications}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Charts would go here if we implemented them -->
                    <div class="row">
                        <div class="col-md-8">
                            <div class="card h-100">
                                <div class="card-header">
                                    <h5 class="card-title">Applications Over Time</h5>
                                </div>
                                <div class="card-body">
                                    <canvas id="applicationsChart" height="100"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card h-100">
                                <div class="card-header">
                                    <h5 class="card-title">Application Status Distribution</h5>
                                </div>
                                <div class="card-body">
                                    <canvas id="statusChart" height="100"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            
            <%@ include file="admin/footer.jsp" %>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <!-- Chart.js would be included here if we used it -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Chart initialization code would go here
        console.log("Charts would be initialized here");
    </script>
</body>
</html>
]]>