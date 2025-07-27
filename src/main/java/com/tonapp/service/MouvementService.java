package com.tonapp.service;

import com.tonapp.dao.MouvementDao;
import com.tonapp.dao.EmployeDao;
import com.tonapp.model.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

public class MouvementService {
    private MouvementDao mouvementDao = new MouvementDao();
    private EmployeDao employeDao = new EmployeDao();

    public boolean peutEnregistrerMouvement(Long employeId, TypeMouvement type) {
        Employe employe = employeDao.trouverParId(employeId);
        Mouvement dernier = mouvementDao.dernierMouvement(employe);
        if (dernier == null) return type == TypeMouvement.ENTREE;
        return dernier.getType() != type;
    }

    public void enregistrerMouvement(Long employeId, TypeMouvement type) {
        Employe employe = employeDao.trouverParId(employeId);
        Mouvement m = new Mouvement();
        m.setEmploye(employe);
        m.setType(type);
        m.setDateHeure(LocalDateTime.now());
        mouvementDao.ajouter(m);
    }

    public List<Mouvement> lister() { return mouvementDao.lister(); }
    public List<Mouvement> listerParEmploye(Long employeId) { return mouvementDao.listerParEmploye(employeId); }
    public List<Mouvement> filtrer(Long employeId, LocalDate date, TypeMouvement type) {
        return mouvementDao.filtrer(employeId, date, type);
    }
} 