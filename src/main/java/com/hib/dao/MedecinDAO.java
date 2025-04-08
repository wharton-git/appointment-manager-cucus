package com.hib.dao;

import com.hib.model.Medecin;
import com.hib.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.util.List;

public class MedecinDAO {
    public void addMedecin(Medecin medecin) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(medecin);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
    }

    public Medecin findMedecinByCode(String codeMed) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Medecin.class, codeMed);
        }
    }

    public List<Medecin> findMedecinsByName(String nom) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Medecin> query = session.createQuery(
                "FROM Medecin WHERE nom LIKE :nom", Medecin.class);
            query.setParameter("nom", "%" + nom + "%");
            return query.list();
        }
    }

    public List<Medecin> findMedecinsByPrenom(String prenom) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Medecin> query = session.createQuery(
                "FROM Medecin WHERE prenom LIKE :prenom", Medecin.class);
            query.setParameter("prenom", "%" + prenom + "%");
            return query.list();
        }
    }

    public void updateMedecin(Medecin medecin) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(medecin);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
    }

    public void deleteMedecin(String codeMed) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Medecin medecin = session.get(Medecin.class, codeMed);
            if (medecin != null) {
                session.remove(medecin);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
    }

    public List<Medecin> getAllMedecins() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Medecin", Medecin.class).list();
        }
    }
}