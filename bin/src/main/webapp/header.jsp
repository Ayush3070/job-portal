<![CDATA[
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Check if user is logged in for header
    var user = (com.jobportal.model.User) session.getAttribute("user");
%>
<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">JobPortal</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link <%= request.getRequestURI().endsWith(\"/index.jsp\") || request.getRequestURI().endsWith(\"/\") ? \"active\" : \"\" %>" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= request.getRequestURI().contains(\"/jobs\") ? \"active\" : \"\" %>" href="${pageContext.request.contextPath}/jobs">Find Jobs</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= request.getRequestURI().contains(\"/admin\") ? \"active\" : \"\" %>" href="${pageContext.request.contextPath}/admin/dashboard">Companies</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= request.getRequestURI().contains(\"/index.jsp#about\") ? \"active\" : \"\" %>" href="${pageContext.request.contextPath}/index.jsp#about">About</a>
                    </li>
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <li class="nav-item">
                                <a class="nav-link <%= request.getRequestURI().endsWith(\"/login.jsp\") ? \"active\" : \"\" %>" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link <%= request.getRequestURI().endsWith(\"/register.jsp\") ? \"active\" : \"\" %>" href="${pageContext.request.contextPath}/register.jsp">Register</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-person-circle"></i> ${user.fullName}
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
</header>
]]>