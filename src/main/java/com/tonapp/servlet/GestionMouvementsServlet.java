package com.tonapp.servlet;

import com.tonapp.service.MouvementService;
import com.tonapp.service.EmployeService;
import com.tonapp.model.TypeMouvement;
import com.tonapp.model.Employe;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/mouvements/gestion")
public class GestionMouvementsServlet extends HttpServlet {
    private MouvementService mouvementService = new MouvementService();
    private EmployeService employeService = new EmployeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Employe> employes = employeService.lister();
        
        // Pour chaque employé, déterminer s'il est présent ou absent
        for (Employe employe : employes) {
            boolean estPresent = mouvementService.estEmployePresent(employe.getId());
            req.setAttribute("employe_" + employe.getId() + "_present", estPresent);
        }
        
        req.setAttribute("employes", employes);
        req.getRequestDispatcher("/jsp/gestionMouvements.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String employeIdStr = req.getParameter("employeId");
        String message = "";

        if (action != null && employeIdStr != null) {
            try {
                Long employeId = Long.parseLong(employeIdStr);
                TypeMouvement type = "entree".equals(action) ? TypeMouvement.ENTREE : TypeMouvement.SORTIE;

                if (mouvementService.peutEnregistrerMouvement(employeId, type)) {
                    mouvementService.enregistrerMouvement(employeId, type);
                    message = type == TypeMouvement.ENTREE ? 
                        "Entrée enregistrée avec succès !" : 
                        "Sortie enregistrée avec succès !";
                } else {
                    message = type == TypeMouvement.ENTREE ? 
                        "Erreur : L'employé doit sortir avant de pouvoir entrer à nouveau." :
                        "Erreur : L'employé doit entrer avant de pouvoir sortir.";
                }
            } catch (Exception e) {
                message = "Erreur lors de l'enregistrement : " + e.getMessage();
            }
        }

        List<Employe> employes = employeService.lister();
        
        // Pour chaque employé, déterminer s'il est présent ou absent
        for (Employe employe : employes) {
            boolean estPresent = mouvementService.estEmployePresent(employe.getId());
            req.setAttribute("employe_" + employe.getId() + "_present", estPresent);
        }
        
        req.setAttribute("employes", employes);
        req.setAttribute("message", message);
        req.getRequestDispatcher("/jsp/gestionMouvements.jsp").forward(req, resp);
    }
} 