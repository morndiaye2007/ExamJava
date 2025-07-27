package com.tonapp.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());
        boolean loggedIn = (req.getSession(false) != null && req.getSession(false).getAttribute("user") != null);

        boolean loginRequest = path.equals("/login") || path.startsWith("/jsp/login.jsp") || path.equals("/logout");

        if (loggedIn || loginRequest || path.startsWith("/css") || path.startsWith("/js")) {
            chain.doFilter(request, response);
        } else {
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
} 