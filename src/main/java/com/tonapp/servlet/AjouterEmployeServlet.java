package com.tonapp.servlet;

import com.tonapp.service.EmployeService;
import com.tonapp.model.Employe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/employes/ajouter")
public class AjouterEmployeServlet extends HttpServlet {
    private EmployeService employeService = new EmployeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Affiche le formulaire d'ajout
        req.getRequestDispatcher("/jsp/ajouterEmploye.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Traite l'ajout de l'employé
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String matricule = req.getParameter("matricule");
        String poste = req.getParameter("poste");
        Employe e = new Employe();
        e.setNom(nom);
        e.setPrenom(prenom);
        e.setMatricule(matricule);
        e.setPoste(poste);
        employeService.ajouter(e);
        resp.sendRedirect(req.getContextPath() + "/employes/lister");
    }
} 