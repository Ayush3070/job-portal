<![CDATA[
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JobPortal - Find Your Dream Job</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webjars/bootstrap-icons/1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">JobPortal</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/jobs">Find Jobs</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Companies</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp#about">About</a>
                    </li>
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/register.jsp">Register</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-person-circle"></i> ${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">My Profile</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/applications">My Applications</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                                </ul>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section bg-dark text-white text-center py-5">
        <div class="container">
            <h1 class="display-4 fw-bold">Find a Job You'll Love</h1>
            <p class="lead mb-4">Discover opportunities, connect with great companies, and take the next step in your career.</p>
            <div class="d-grid gap-2 d-sm-flex justify-content-sm-center mb-5">
                <a href="${pageContext.request.contextPath}/jobs" class="btn btn-primary btn-lg me-sm-2">Find Jobs</a>
                <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-outline-light btn-lg">Create Account</a>
            </div>
        </div>
    </section>

    <!-- Popular Categories -->
    <section class="categories-section py-5">
        <div class="container">
            <h2 class="text-center mb-5">Popular Categories</h2>
            <div class="row g-4">
                <div class="col-md-3 col-sm-6">
                    <div class="category-card bg-light p-4 text-center rounded">
                        <i class="bi bi-code-slash display-4 text-primary mb-3"></i>
                        <h5>Software Development</h5>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="category-card bg-light p-4 text-center rounded">
                        <i class="bi bi-bar-chart display-4 text-primary mb-3"></i>
                        <h5>Data Science</h5>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="category-card bg-light p-4 text-center rounded">
                        <i class="bi bi-robot display-4 text-primary mb-3"></i>
                        <h5>AI & ML</h5>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="category-card bg-light p-4 text-center rounded">
                        <i class="bi bi-shield-lock display-4 text-primary mb-3"></i>
                        <h5>Cybersecurity</h5>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="category-card bg-light p-4 text-center rounded">
                        <i class="bi bi-palette display-4 text-primary mb-3"></i>
                        <h5>UI/UX Design</h5>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="category-card bg-light p-4 text-center rounded">
                        <i class="bi bi-megaphone display-4 text-primary mb-3"></i>
                        <h5>Marketing</h5>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Jobs -->
    <section class="featured-jobs py-5 bg-light">
        <div class="container">
            <h2 class="text-center mb-5">Featured Jobs</h2>
            <div class="row g-4">
                <!-- Job cards will be populated by JavaScript or we can show a few here -->
                <div class="col-md-4">
                    <div class="job-card h-100">
                        <div class="job-card-header">
                            <img src="https://via.placeholder.com/50" alt="Company Logo" class="company-logo">
                            <div class="job-info">
                                <h5 class="job-title">Java Developer</h5>
                                <p class="company-name">Google</p>
                            </div>
                        </div>
                        <div class="job-card-body">
                            <p class="job-location"><i class="bi bi-geo-alt"></i> Mountain View, CA</p>
                            <p class="job-salary"><i class="bi bi-cash"></i> $120,000 - $150,000</p>
                            <p class="job-type"><i class="bi bi-briefcase"></i> Full-time</p>
                            <div class="job-skills">
                                <span class="badge bg-primary me-1">Java</span>
                                <span class="badge bg-primary me-1">Spring Boot</span>
                                <span class="badge bg-primary">Microservices</span>
                            </div>
                        </div>
                        <div class="job-card-footer">
                            <a href="#" class="btn btn-outline-primary w-100">View Details</a>
                        </div>
                    </div>
                </div>
                <!-- We'll add more job cards dynamically or just leave as static for now -->
                <div class="col-md-4">
                    <div class="job-card h-100">
                        <div class="job-card-header">
                            <img src="https://via.placeholder.com/50" alt="Company Logo" class="company-logo">
                            <div class="job-info">
                                <h5 class="job-title">Frontend Developer</h5>
                                <p class="company-name">Microsoft</p>
                            </div>
                        </div>
                        <div class="job-card-body">
                            <p class="job-location"><i class="bi bi-geo-alt"></i> Redmond, WA</p>
                            <p class="job-salary"><i class="bi bi-cash"></i> $110,000 - $140,000</p>
                            <p class="job-type"><i class="bi bi-briefcase"></i> Full-time</p>
                            <div class="job-skills">
                                <span class="badge bg-primary me-1">HTML</span>
                                <span class="badge bg-primary me-1">CSS</span>
                                <span class="badge bg-primary me-1">JavaScript</span>
                                <span class="badge bg-primary">React</span>
                            </div>
                        </div>
                        <div class="job-card-footer">
                            <a href="#" class="btn btn-outline-primary w-100">View Details</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="job-card h-100">
                        <div class="job-card-header">
                            <img src="https://via.placeholder.com/50" alt="Company Logo" class="company-logo">
                            <div class="job-info">
                                <h5 class="job-title">Data Analyst</h5>
                                <p class="company-name">TCS</p>
                            </div>
                        </div>
                        <div class="job-card-body">
                            <p class="job-location"><i class="bi bi-geo-alt"></i> New York, NY</p>
                            <p class="job-salary"><i class="bi bi-cash"></i> $80,000 - $100,000</p>
                            <p class="job-type"><i class="bi bi-briefcase"></i> Full-time</p>
                            <div class="job-skills">
                                <span class="badge bg-primary me-1">SQL</span>
                                <span class="badge bg-primary me-1">Python</span>
                                <span class="badge bg-primary">Tableau</span>
                            </div>
                        </div>
                        <div class="job-card-footer">
                            <a href="#" class="btn btn-outline-primary w-100">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Why JobPortal -->
    <section class="why-section py-5">
        <div class="container">
            <h2 class="text-center mb-5">Why Choose JobPortal?</h2>
            <div class="row g-4">
                <div class="col-md-3 col-sm-6">
                    <div class="why-card bg-white p-4 text-center rounded h-100 shadow-sm">
                        <i class="bi bi-arrow-up-circle display-4 text-success mb-3"></i>
                        <h5>Find Better Opportunities</h5>
                        <p>Access thousands of job listings from top companies</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="why-card bg-white p-4 text-center rounded h-100 shadow-sm">
                        <i class="bi bi-clock display-4 text-info mb-3"></i>
                        <h5>Easy Applications</h5>
                        <p>Apply to jobs with just a few clicks</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="why-card bg-white p-4 text-center rounded h-100 shadow-sm">
                        <i class="bi bi-graph-up display-4 text-warning mb-3"></i>
                        <h5>Track Applications</h5>
                        <p>Monitor your application status in real-time</p>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="why-card bg-white p-4 text-center rounded h-100 shadow-sm">
                        <i class="bi bi-people display-4 text-secondary mb-3"></i>
                        <h5>Connect With Companies</h5>
                        <p>Get noticed by recruiters and hiring managers</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h5>JobPortal</h5>
                    <p>Connecting talent with opportunity.</p>
                </div>
                <div class="col-md-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white text-decoration-none">Home</a></li>
                        <li><a href="#" class="text-white text-decoration-none">Find Jobs</a></li>
                        <li><a href="#" class="text-white text-decoration-none">About</a></li>
                        <li><a href="#" class="text-white text-decoration-none">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h5>Follow Us</h5>
                    <div class="social-icons">
                        <a href="#" class="text-white me-3"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="text-white me-3"><i class="bi bi-twitter"></i></a>
                        <a href="#" class="text-white me-3"><i class="bi bi-linkedin"></i></a>
                        <a href="#" class="text-white"><i class="bi bi-instagram"></i></a>
                    </div>
                </div>
            </div>
            <div class="text-center mt-3">
                <p class="mb-0">&copy; 2026 JobPortal. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
]]>