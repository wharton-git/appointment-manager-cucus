package com.hib.model;

import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "medecin")
public class Medecin {
   @Id
    @Column(name = "codemed", length = 50)
    private String codeMed;
    
    @Column(name = "nom", nullable = false, length = 100)
    private String nom;
    
    @Column(name = "prenom", nullable = false, length = 100)
    private String prenom;
    
    @Column(name = "grade", length = 50)
    private String grade;
    
    @OneToMany(mappedBy = "medecin", cascade = CascadeType.ALL)
    private Set<Visiter> visites = new HashSet<>();
    
    public Medecin() {}
    
    public Medecin(String codeMed, String nom, String prenom, String grade) {
        this.codeMed = codeMed;
        this.nom = nom;
        this.prenom = prenom;
        this.grade = grade;
    }
    
    public String getCodeMed() { return codeMed; }
    public void setCodeMed(String codeMed) { this.codeMed = codeMed; }
    
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    
    public String getGrade() { return grade; }
    public void setGrade(String grade) { this.grade = grade; }
    
    public Set<Visiter> getVisites() { return visites; }
    public void setVisites(Set<Visiter> visites) { this.visites = visites; }
}