package com.tonapp.dao;

import com.tonapp.model.Utilisateur;
import jakarta.persistence.*;
import java.util.List;

public class UtilisateurDao {
    private static EntityManagerFactory emf;
    
    static {
        emf = Persistence.createEntityManagerFactory("gestionPU");
    }
    
    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public Utilisateur trouverParUsername(String username) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT u FROM Utilisateur u WHERE u.username = :username", Utilisateur.class)
                     .setParameter("username", username)
                     .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
} 