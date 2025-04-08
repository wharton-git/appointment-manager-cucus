package com.hib.servlet;

import com.hib.dao.PatientDAO;
import com.hib.model.Patient;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/patients")
public class PatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private PatientDAO patientDAO = new PatientDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                Patient patient = new Patient(
                    request.getParameter("nom"),
                    request.getParameter("prenom"),
                    request.getParameter("sexe").charAt(0),
                    request.getParameter("adresse")
                );
                patientDAO.addPatient(patient);
            } else if ("update".equals(action)) {
                Integer codePat = Integer.parseInt(request.getParameter("codePat"));
                Patient patient = patientDAO.findPatientById(codePat);
                if (patient != null) {
                    patient.setNom(request.getParameter("nom"));
                    patient.setPrenom(request.getParameter("prenom"));
                    patient.setSexe(request.getParameter("sexe").charAt(0));
                    patient.setAdresse(request.getParameter("adresse"));
                    patientDAO.updatePatient(patient);
                }
            } else if ("delete".equals(action)) {
                Integer codePat = Integer.parseInt(request.getParameter("codePat"));
                patientDAO.deletePatient(codePat);
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        
        response.sendRedirect("patients");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("search".equals(action)) {
                String searchType = request.getParameter("searchType");
                String searchValue = request.getParameter("searchValue");
                
                if ("code".equals(searchType)) {
                    Integer codePat = Integer.parseInt(searchValue);
                    request.setAttribute("patient", patientDAO.findPatientById(codePat));
                } else if ("nom".equals(searchType)) {
                    request.setAttribute("patients", patientDAO.findPatientsByName(searchValue));
                } else {
                    request.setAttribute("patients", patientDAO.findPatientsByPrenom(searchValue));
                }
            } else if ("edit".equals(action)) {
                Integer codePat = Integer.parseInt(request.getParameter("codePat"));
                request.setAttribute("patient", patientDAO.findPatientById(codePat));
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        
        if (request.getAttribute("patients") == null) {
            request.setAttribute("patients", patientDAO.getAllPatients());
        }
        
        request.getRequestDispatcher("/patient.jsp").forward(request, response);
    }
}