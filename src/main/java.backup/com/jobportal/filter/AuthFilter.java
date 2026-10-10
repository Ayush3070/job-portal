package com.jobportal.filter;

import com.jobportal.model.User;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();

        // Allow access to login, register, and static resources without authentication
        boolean isLoginRequest = requestURI.endsWith("/login") || requestURI.contains("/login.jsp");
        boolean isRegisterRequest = requestURI.endsWith("/register") || requestURI.contains("/register.jsp");
        boolean isStaticResource = requestURI.contains("/css/") || requestURI.contains("/js/") || 
                                   requestURI.contains("/images/") || requestURI.contains("/webjars/");

        // Check if the user is logged in
        boolean isLoggedIn = session != null && session.getAttribute("user") != null;
        User user = isLoggedIn ? (User) session.getAttribute("user") : null;
        boolean isAdmin = user != null && "ADMIN".equalsIgnoreCase(user.getRole());

        // Allow access to public pages
        if (isLoginRequest || isRegisterRequest || isStaticResource) {
            chain.doFilter(request, response);
            return;
        }

        // If not logged in, redirect to login
        if (!isLoggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            return;
        }

        // Check for admin-only routes
        boolean isAdminRequest = requestURI.contains("/admin/");
        if (isAdminRequest && !isAdmin) {
            httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        // Otherwise, continue with the request
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}