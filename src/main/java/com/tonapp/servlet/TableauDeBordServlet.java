package com.tonapp.servlet;

import com.tonapp.service.StatistiqueService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/dashboard")
public class TableauDeBordServlet extends HttpServlet {
    private StatistiqueService statistiqueService = new StatistiqueService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long presents = statistiqueService.compterEmployesPresents();
        long entrees = statistiqueService.compterEntreesAujourdhui();
        long sorties = statistiqueService.compterSortiesAujourdhui();

        req.setAttribute("presents", presents);
        req.setAttribute("entrees", entrees);
        req.setAttribute("sorties", sorties);

        req.getRequestDispatcher("/jsp/dashboard.jsp").forward(req, resp);
    }
} 