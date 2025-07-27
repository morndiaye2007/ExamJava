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

@WebServlet("/mouvements/sortie")
public class EnregistrerSortieServlet extends HttpServlet {
    private MouvementService mouvementService = new MouvementService();
    private EmployeService employeService = new EmployeService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String message;
        try {
            Long employeId = Long.parseLong(req.getParameter("employeId"));
            if (mouvementService.peutEnregistrerMouvement(employeId, TypeMouvement.SORTIE)) {
                mouvementService.enregistrerMouvement(employeId, TypeMouvement.SORTIE);
                message = "Sortie enregistrée avec succès !";
            } else {
                message = "Erreur : L'employé doit entrer avant de pouvoir sortir à nouveau.";
            }
        } catch (Exception e) {
            message = "Erreur lors de l'enregistrement : " + e.getMessage();
        }
        List<Employe> employes = employeService.lister();
        req.setAttribute("employes", employes);
        req.setAttribute("message", message);
        req.getRequestDispatcher("/jsp/enregistrerMouvement.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Employe> employes = employeService.lister();
        req.setAttribute("employes", employes);
        req.getRequestDispatcher("/jsp/enregistrerMouvement.jsp").forward(req, resp);
    }
} 