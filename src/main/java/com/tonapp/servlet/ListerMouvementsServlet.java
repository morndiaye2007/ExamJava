package com.tonapp.servlet;

import com.tonapp.service.MouvementService;
import com.tonapp.service.EmployeService;
import com.tonapp.model.Mouvement;
import com.tonapp.model.TypeMouvement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/mouvements/lister")
public class ListerMouvementsServlet extends HttpServlet {
    private MouvementService mouvementService = new MouvementService();
    private EmployeService employeService = new EmployeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String employeIdStr = req.getParameter("employeId");
        String dateStr = req.getParameter("date");
        String typeStr = req.getParameter("type");

        Long employeId = (employeIdStr != null && !employeIdStr.isEmpty()) ? Long.parseLong(employeIdStr) : null;
        LocalDate date = (dateStr != null && !dateStr.isEmpty()) ? LocalDate.parse(dateStr) : null;
        TypeMouvement type = (typeStr != null && !typeStr.isEmpty()) ? TypeMouvement.valueOf(typeStr) : null;

        List<Mouvement> mouvements = mouvementService.filtrer(employeId, date, type);
        req.setAttribute("mouvements", mouvements);
        req.setAttribute("employes", employeService.lister());
        
        // Ajouter les formateurs de date
        req.setAttribute("dateFormatter", DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        req.setAttribute("timeFormatter", DateTimeFormatter.ofPattern("HH:mm:ss"));
        
        req.getRequestDispatcher("/jsp/listeMouvements.jsp").forward(req, resp);
    }
} 