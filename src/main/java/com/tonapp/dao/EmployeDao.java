package com.tonapp.dao;

import com.tonapp.model.Employe;
import jakarta.persistence.*;
import java.util.List;

public class EmployeDao {
    private static EntityManagerFactory emf;
    
    static {
        emf = Persistence.createEntityManagerFactory("gestionPU");
    }
    
    private EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void ajouter(Employe e) { 
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(e);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    
    public void modifier(Employe e) { 
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(e);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    
    public void supprimer(Long id) {
        EntityManager em = getEntityManager();
        try {
            em.getTransaction().begin();
            Employe e = em.find(Employe.class, id);
            if (e != null) {
                // Au lieu de supprimer physiquement, on désactive l'employé
                e.setActif(false);
                em.merge(e);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    
    public Employe trouverParId(Long id) { 
        EntityManager em = getEntityManager();
        try {
            return em.find(Employe.class, id);
        } finally {
            em.close();
        }
    }
    
    public List<Employe> lister() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT e FROM Employe e WHERE e.actif = true ORDER BY e.nom", Employe.class).getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Employe> listerTous() {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT e FROM Employe e ORDER BY e.nom", Employe.class).getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Employe> rechercher(String motCle) {
        EntityManager em = getEntityManager();
        try {
            return em.createQuery("SELECT e FROM Employe e WHERE e.nom LIKE :mc OR e.matricule LIKE :mc", Employe.class)
                     .setParameter("mc", "%" + motCle + "%")
                     .getResultList();
        } finally {
            em.close();
        }
    }
    
    public String genererMatricule() {
        EntityManager em = getEntityManager();
        try {
            // Trouver le plus grand matricule existant
            String result = em.createQuery("SELECT MAX(e.matricule) FROM Employe e", String.class)
                             .getSingleResult();
            
            if (result == null) {
                // Aucun employé existant, commencer par EMP001
                return "EMP001";
            }
            
            // Extraire le numéro du matricule (ex: EMP001 -> 1)
            String numeroStr = result.substring(3); // Enlever "EMP"
            int numero = Integer.parseInt(numeroStr);
            
            // Incrémenter et formater avec des zéros
            numero++;
            return String.format("EMP%03d", numero);
        } catch (Exception e) {
            // En cas d'erreur, retourner un matricule par défaut
            return "EMP001";
        } finally {
            em.close();
        }
    }
} 