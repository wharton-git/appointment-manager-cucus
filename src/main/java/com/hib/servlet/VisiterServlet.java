package com.hib.servlet;

import com.hib.dao.*;
import com.hib.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/visites")
public class VisiterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private VisiterDAO visiterDAO = new VisiterDAO();
    private MedecinDAO medecinDAO = new MedecinDAO();
    private PatientDAO patientDAO = new PatientDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action) || "update".equals(action)) {
                String codeMed = request.getParameter("codeMed");
                int codePat = Integer.parseInt(request.getParameter("codePat"));
                Date date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("date"));
                
                // Vérification de l'existence des entités liées
                Medecin medecin = medecinDAO.findMedecinByCode(codeMed);
                if (medecin == null) {
                    throw new ServletException("Médecin avec code " + codeMed + " introuvable");
                }
                
                Patient patient = patientDAO.findPatientById(codePat);
                if (patient == null) {
                    throw new ServletException("Patient avec code " + codePat + " introuvable");
                }
                
                Visiter visite = new Visiter();
                visite.setMedecin(medecin);
                visite.setPatient(patient);
                visite.setDate(date);
                
                if ("update".equals(action)) {
                    int codeVis = Integer.parseInt(request.getParameter("codeVis"));
                    visite.setCodeVis(codeVis);
                }
                
                if ("add".equals(action)) {
                    visiterDAO.addVisite(visite);
                } else {
                    visiterDAO.updateVisite(visite);
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de l'opération: " + e.getMessage());
        }
        
        response.sendRedirect("visites");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("search".equals(action)) {
                String searchType = request.getParameter("searchType");
                String searchValue = request.getParameter("searchValue");
                
                if ("code".equals(searchType)) {
                    int codeVis = Integer.parseInt(searchValue);
                    request.setAttribute("visite", visiterDAO.findVisiteByCode(codeVis));
                } else if ("medecin".equals(searchType)) {
                    request.setAttribute("visites", visiterDAO.findVisitesByMedecinName(searchValue));
                } else {
                    request.setAttribute("visites", visiterDAO.findVisitesByPatientName(searchValue));
                }
            } else if ("edit".equals(action)) {
                int codeVis = Integer.parseInt(request.getParameter("codeVis"));
                request.setAttribute("visite", visiterDAO.findVisiteByCode(codeVis));
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        
        // Charger les données nécessaires
        if (request.getAttribute("visites") == null) {
            request.setAttribute("visites", visiterDAO.getAllVisites());
        }
        
        // Toujours charger médecins et patients pour les formulaires
        request.setAttribute("medecins", medecinDAO.getAllMedecins());
        request.setAttribute("patients", patientDAO.getAllPatients());
        
        request.getRequestDispatcher("/visiter.jsp").forward(request, response);
    }
}