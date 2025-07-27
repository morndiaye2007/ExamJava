package com.tonapp.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
public class Mouvement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    private Employe employe;
    private LocalDateTime dateHeure;
    @Enumerated(EnumType.STRING)
    private TypeMouvement type;
    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Employe getEmploye() { return employe; }
    public void setEmploye(Employe employe) { this.employe = employe; }
    public LocalDateTime getDateHeure() { return dateHeure; }
    public void setDateHeure(LocalDateTime dateHeure) { this.dateHeure = dateHeure; }
    public TypeMouvement getType() { return type; }
    public void setType(TypeMouvement type) { this.type = type; }
} 