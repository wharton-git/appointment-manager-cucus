package com.hib.util;

import org.hibernate.SessionFactory;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

public class HibernateUtil {
    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            // Configuration basée sur hibernate.cfg.xml
            StandardServiceRegistry standardRegistry = new StandardServiceRegistryBuilder()
                .configure("hibernate.cfg.xml")
                .build();

            // Création des métadonnées avec mapping explicite
            Metadata metadata = new MetadataSources(standardRegistry)
                .addAnnotatedClass(com.hib.model.Medecin.class)
                .addAnnotatedClass(com.hib.model.Patient.class)
                .addAnnotatedClass(com.hib.model.Visiter.class)
                .getMetadataBuilder()
                .build();

            return metadata.getSessionFactoryBuilder().build();
        } catch (Exception ex) {
            System.err.println("Erreur d'initialisation de SessionFactory: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    public static void shutdown() {
        if (sessionFactory != null) {
            sessionFactory.close();
        }
    }
}