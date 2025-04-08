package com.hib.model;
import jakarta.persistence.*;

import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "patient")
public class Patient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codepat")
    private Integer codePat;
    
    @Column(name = "nom", nullable = false, length = 100)
    private String nom;
    
    @Column(name = "prenom", nullable = false, length = 100)
    private String prenom;
    
    @Column(name = "sexe", length = 1)
    private Character sexe;
    
    @Column(name = "adresse", length = 255)
    private String adresse;
    
    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private Set<Visiter> visites = new HashSet<>();
    
    // Constructeurs
    public Patient() {}
    
    public Patient(String nom, String prenom, Character sexe, String adresse) {
        this.nom = nom;
        this.prenom = prenom;
        this.sexe = sexe;
        this.adresse = adresse;
    }
    
    // Getters et Setters
    public Integer getCodePat() { return codePat; }
    public void setCodePat(Integer codePat) { this.codePat = codePat; }
    
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    
    public Character getSexe() { return sexe; }
    public void setSexe(Character sexe) { this.sexe = sexe; }
    
    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }
    
    public Set<Visiter> getVisites() { return visites; }
    public void setVisites(Set<Visiter> visites) { this.visites = visites; }
}
