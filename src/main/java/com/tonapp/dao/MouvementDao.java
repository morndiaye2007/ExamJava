package com.tonapp.dao;

import com.tonapp.model.*;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

public class MouvementDao {
    private static EntityManagerFactory emf;
    
    static {
        emf = Persistence.createEntityManagerFactory("gestionPU");
    }
    
    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void ajouter(Mouvement m) { 
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(m);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public List<Mouvement> lister() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT m FROM Mouvement m ORDER BY m.dateHeure DESC", Mouvement.class)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Mouvement> listerParEmploye(Long employeId) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT m FROM Mouvement m WHERE m.employe.id = :id ORDER BY m.dateHeure DESC", Mouvement.class)
                     .setParameter("id", employeId)
                     .getResultList();
        } finally {
            em.close();
        }
    }

    public Mouvement dernierMouvement(Employe employe) {
        EntityManager em = getEntityManager();
        try {
            List<Mouvement> result = em.createQuery(
                "SELECT m FROM Mouvement m WHERE m.employe = :employe ORDER BY m.dateHeure DESC", Mouvement.class)
                .setParameter("employe", employe)
                .setMaxResults(1)
                .getResultList();
            return result.isEmpty() ? null : result.get(0);
        } finally {
            em.close();
        }
    }

    public List<Mouvement> filtrer(Long employeId, LocalDate date, TypeMouvement type) {
        EntityManager em = getEntityManager();
        try {
            String jpql = "SELECT m FROM Mouvement m WHERE 1=1";
            if (employeId != null) jpql += " AND m.employe.id = :employeId";
            if (date != null) jpql += " AND FUNCTION('DATE', m.dateHeure) = :date";
            if (type != null) jpql += " AND m.type = :type";
            jpql += " ORDER BY m.dateHeure DESC";
            TypedQuery<Mouvement> query = em.createQuery(jpql, Mouvement.class);
            if (employeId != null) query.setParameter("employeId", employeId);
            if (date != null) query.setParameter("date", date);
            if (type != null) query.setParameter("type", type);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
} 