package com.tonapp.service;

import com.tonapp.dao.EmployeDao;
import com.tonapp.model.Employe;
import java.util.List;

public class EmployeService {
    private EmployeDao employeDao = new EmployeDao();

    public void ajouter(Employe e) { 
        // Générer automatiquement le matricule si non fourni
        if (e.getMatricule() == null || e.getMatricule().trim().isEmpty()) {
            e.setMatricule(employeDao.genererMatricule());
        }
        employeDao.ajouter(e); 
    }
    public void modifier(Employe e) { employeDao.modifier(e); }
    public void supprimer(Long id) { employeDao.supprimer(id); }
    public Employe trouverParId(Long id) { return employeDao.trouverParId(id); }
    public List<Employe> lister() { return employeDao.lister(); }
    public List<Employe> listerTous() { return employeDao.listerTous(); }
    public List<Employe> rechercher(String motCle) { return employeDao.rechercher(motCle); }
    public String genererMatricule() { return employeDao.genererMatricule(); }
} 