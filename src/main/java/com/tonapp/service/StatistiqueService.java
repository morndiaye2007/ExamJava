package com.tonapp.service;

import com.tonapp.dao.EmployeDao;
import com.tonapp.dao.MouvementDao;
import com.tonapp.model.*;
import java.time.LocalDate;
import java.util.List;

public class StatistiqueService {
    private EmployeDao employeDao = new EmployeDao();
    private MouvementDao mouvementDao = new MouvementDao();

    // Nombre d'employés présents actuellement
    public long compterEmployesPresents() {
        List<Employe> employes = employeDao.lister();
        long count = 0;
        for (Employe e : employes) {
            Mouvement dernier = mouvementDao.dernierMouvement(e);
            if (dernier != null && dernier.getType() == TypeMouvement.ENTREE) {
                count++;
            }
        }
        return count;
    }

    // Nombre d'entrées aujourd'hui
    public long compterEntreesAujourdhui() {
        LocalDate today = LocalDate.now();
        return mouvementDao.filtrer(null, today, TypeMouvement.ENTREE).size();
    }

    // Nombre de sorties aujourd'hui
    public long compterSortiesAujourdhui() {
        LocalDate today = LocalDate.now();
        return mouvementDao.filtrer(null, today, TypeMouvement.SORTIE).size();
    }
} 