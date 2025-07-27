package com.tonapp.servlet;

import com.tonapp.service.EmployeService;
import com.tonapp.model.Employe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/employes/lister")
public class ListerEmployesServlet extends HttpServlet {
    private EmployeService employeService = new EmployeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Employe> employes = employeService.listerTous();
        req.setAttribute("employes", employes);
        req.getRequestDispatcher("/jsp/listeEmployes.jsp").forward(req, resp);
    }
} 