package com.hib.dao;

import com.hib.model.Visiter;
import com.hib.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.util.List;

public class VisiterDAO {
    public void addVisite(Visiter visite) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(visite);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
    }

    public Visiter findVisiteByCode(int codeVis) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Visiter.class, codeVis);
        }
    }

    public List<Visiter> findVisitesByMedecinName(String nomMedecin) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Visiter> query = session.createQuery(
                "SELECT v FROM Visiter v WHERE v.medecin.nom LIKE :nom", Visiter.class);
            query.setParameter("nom", "%" + nomMedecin + "%");
            return query.list();
        }
    }

    public List<Visiter> findVisitesByPatientName(String nomPatient) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Visiter> query = session.createQuery(
                "SELECT v FROM Visiter v WHERE v.patient.nom LIKE :nom", Visiter.class);
            query.setParameter("nom", "%" + nomPatient + "%");
            return query.list();
        }
    }

    public void updateVisite(Visiter visite) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(visite);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
    }

    public void deleteVisite(int codeVis) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Visiter visite = session.get(Visiter.class, codeVis);
            if (visite != null) {
                session.remove(visite);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
    }

    public List<Visiter> getAllVisites() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Visiter", Visiter.class).list();
        }
    }
    
    public List<Visiter> searchVisitesGlobally(String keyword) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = """
                FROM Visiter v 
                WHERE 
                    cast(v.codeVis as string) like :kw 
                    OR lower(v.medecin.nom) like :kw 
                    OR lower(v.medecin.prenom) like :kw
                    OR lower(v.patient.nom) like :kw 
                    OR lower(v.patient.prenom) like :kw
            """;

            Query<Visiter> query = session.createQuery(hql, Visiter.class);
            query.setParameter("kw", "%" + keyword.toLowerCase() + "%");

            return query.list();
        }
    }

}