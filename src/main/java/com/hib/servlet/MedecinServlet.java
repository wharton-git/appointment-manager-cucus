package com.hib.servlet;

import com.hib.dao.MedecinDAO;
import com.hib.model.Medecin;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/medecins")
public class MedecinServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private MedecinDAO medecinDAO = new MedecinDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("add".equals(action)) {
                Medecin medecin = new Medecin(
                    request.getParameter("codeMed"),
                    request.getParameter("nom"),
                    request.getParameter("prenom"),
                    request.getParameter("grade")
                );
                medecinDAO.addMedecin(medecin);
            } else if ("update".equals(action)) {
                Medecin medecin = medecinDAO.findMedecinByCode(request.getParameter("codeMed"));
                if (medecin != null) {
                    medecin.setNom(request.getParameter("nom"));
                    medecin.setPrenom(request.getParameter("prenom"));
                    medecin.setGrade(request.getParameter("grade"));
                    medecinDAO.updateMedecin(medecin);
                }
            } else if ("delete".equals(action)) {
                medecinDAO.deleteMedecin(request.getParameter("codeMed"));
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        
        response.sendRedirect("medecins");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("search".equals(action)) {
                
                if ("search".equals(action)) {
                    String keyword = request.getParameter("searchValue");
                    request.setAttribute("medecins", medecinDAO.searchMedecinsGlobally(keyword));
                } else if ("edit".equals(action)) {
                    request.setAttribute("medecin", medecinDAO.findMedecinByCode(request.getParameter("codeMed")));
                }

            } else if ("edit".equals(action)) {
                request.setAttribute("medecin", medecinDAO.findMedecinByCode(request.getParameter("codeMed")));
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        
        if (request.getAttribute("medecins") == null) {
            request.setAttribute("medecins", medecinDAO.getAllMedecins());
        }
        
        request.getRequestDispatcher("/medecin.jsp").forward(request, response);
    }
}