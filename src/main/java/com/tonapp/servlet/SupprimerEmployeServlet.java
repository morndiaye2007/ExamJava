package com.tonapp.servlet;

import com.tonapp.service.EmployeService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/employes/supprimer")
public class SupprimerEmployeServlet extends HttpServlet {
    private EmployeService employeService = new EmployeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/employes/lister");
            return;
        }

        try {
            Long id = Long.parseLong(idStr);
            employeService.supprimer(id);
            req.setAttribute("message", "Employé désactivé avec succès");
        } catch (Exception e) {
            req.setAttribute("message", "Erreur lors de la désactivation: " + e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/employes/lister");
    }
} 