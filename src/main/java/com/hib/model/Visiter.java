package com.hib.model;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "visiter")
public class Visiter {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int codeVis;

    @ManyToOne
    @JoinColumn(name = "codemed", referencedColumnName = "codemed", nullable = false)
    private Medecin medecin;

    @ManyToOne
    @JoinColumn(name = "codepat", referencedColumnName = "codepat", nullable = false)
    private Patient patient;

    @Temporal(TemporalType.DATE)
    private Date date;

    // Constructeurs
    public Visiter() {}

    public Visiter(int codeVis, Medecin medecin, Patient patient, Date date) {
        this.codeVis = codeVis;
        this.medecin = medecin;
        this.patient = patient;
        this.date = date;
    }

    // Getters et Setters
    public int getCodeVis() { return codeVis; }
    public void setCodeVis(int codeVis) { this.codeVis = codeVis; }

    public Medecin getMedecin() { return medecin; }
    public void setMedecin(Medecin medecin) { this.medecin = medecin; }

    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
}