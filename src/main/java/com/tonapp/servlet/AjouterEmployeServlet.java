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
        // Générer le prochain matricule pour l'afficher dans le formulaire
        String prochainMatricule = employeService.genererMatricule();
        req.setAttribute("prochainMatricule", prochainMatricule);
        req.getRequestDispatcher("/jsp/ajouterEmploye.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Traite l'ajout de l'employé
        String nom = req.getParameter("nom");
        String prenom = req.getParameter("prenom");
        String poste = req.getParameter("poste");
        
        Employe e = new Employe();
        e.setNom(nom);
        e.setPrenom(prenom);
        e.setPoste(poste);
        e.setActif(true); // Par défaut, l'employé est actif
        
        // Le matricule sera généré automatiquement dans le service
        employeService.ajouter(e);
        resp.sendRedirect(req.getContextPath() + "/employes/lister");
    }
} 