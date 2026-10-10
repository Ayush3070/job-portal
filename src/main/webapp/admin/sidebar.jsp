<![CDATA[
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="bg-dark sidebar">
    <div class="sidebar-sticky">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().endsWith("/admin/dashboard") ? "active" : "" %>" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="bi bi-speedometer2 me-2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().contains("/admin/jobs") ? "active" : "" %>" href="${pageContext.request.contextPath}/admin/jobs">
                    <i class="bi bi-briefcase me-2"></i> Jobs
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().contains("/admin/applications") ? "active" : "" %>" href="${pageContext.request.contextPath}/admin/applications">
                    <i class="bi bi-file-earmark-text me-2"></i> Applications
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().contains("/admin/users") ? "active" : "" %>" href="${pageContext.request.contextPath}/admin/users">
                    <i class="bi bi-people me-2"></i> Users
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/settings">
                    <i class="bi bi-gear me-2"></i> Settings
                </a>
            </li>
        </ul>
    </div>
</aside>
<style>
    .sidebar {
        width: 250px;
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        padding-top: 20px;
    }
    .sidebar .nav-link {
        color: rgba(255,255,255,0.7);
        padding: 10px 15px;
    }
    .sidebar .nav-link:hover {
        color: white;
        background-color: rgba(255,255,255,0.1);
    }
    .sidebar .nav-link.active {
        color: white;
        background-color: rgba(255,255,255,0.2);
        border-left: 3px solid #0d6efd;
    }
    .content {
        margin-left: 250px;
        width: calc(100% - 250px);
        min-height: 100vh;
    }
    @media (max-width: 768px) {
        .sidebar {
            width: 100%;
            height: auto;
            position: relative;
        }
        .content {
            margin-left: 0;
            width: 100%;
        }
    }
</style>
]]>