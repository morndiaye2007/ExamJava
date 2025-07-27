package com.tonapp.service;

import com.tonapp.dao.UtilisateurDao;
import com.tonapp.model.Utilisateur;

public class UtilisateurService {
    private UtilisateurDao utilisateurDao = new UtilisateurDao();

    public Utilisateur authentifier(String username, String password) {
        Utilisateur u = utilisateurDao.trouverParUsername(username);
        if (u != null && u.getPassword().equals(password)) { // En prod, compare hash !
            return u;
        }
        return null;
    }
} 