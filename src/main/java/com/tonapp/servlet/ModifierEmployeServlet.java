package com.tonapp.servlet;

import com.tonapp.service.EmployeService;
import com.tonapp.model.Employe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/employes/modifier")
public class ModifierEmployeServlet extends HttpServlet {
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
            Employe employe = employeService.trouverParId(id);
            if (employe == null) {
                req.setAttribute("message", "Employé non trouvé");
                req.getRequestDispatcher("/employes/lister").forward(req, resp);
                return;
            }
            req.setAttribute("employe", employe);
            req.getRequestDispatcher("/jsp/modifierEmploye.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("message", "ID d'employé invalide");
            req.getRequestDispatcher("/employes/lister").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String matricule = req.getParameter("matricule");
        String poste = req.getParameter("poste");
        String actifStr = req.getParameter("actif");

        if (idStr == null || idStr.isEmpty()) {
            req.setAttribute("message", "ID d'employé manquant");
            req.getRequestDispatcher("/employes/lister").forward(req, resp);
            return;
        }

        try {
            Long id = Long.parseLong(idStr);
            boolean actif = "on".equals(actifStr);

            Employe employe = new Employe();
            employe.setId(id);
            employe.setNom(nom);
            employe.setPrenom(prenom);
            employe.setMatricule(matricule);
            employe.setPoste(poste);
            employe.setActif(actif);

            employeService.modifier(employe);
            req.setAttribute("message", "Employé modifié avec succès");
            resp.sendRedirect(req.getContextPath() + "/employes/lister");
        } catch (Exception e) {
            req.setAttribute("message", "Erreur lors de la modification: " + e.getMessage());
            req.getRequestDispatcher("/employes/lister").forward(req, resp);
        }
    }
} 