<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Gestion des Visites</title>
    <style>
        table { border-collapse: collapse; width: 100%; } 
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; } 
        tr:nth-child(even) { background-color: #f2f2f2; }
        .error { color: red; }
    </style>
</head>
<body>
    <h1>Gestion des Visites</h1>
    
    <c:if test="${not empty error}">
        <p class="error">Erreur : ${error}</p>
    </c:if>
    
    <!-- Formulaire de recherche -->
    <form action="visites" method="get">
        <input type="hidden" name="action" value="search">
        <select name="searchType">
            <option value="code">Code</option>
            <option value="medecin">Médecin</option>
            <option value="patient">Patient</option>
        </select>
        <input type="text" name="searchValue" required>
        <button type="submit">Rechercher</button>
        <a href="visites">Afficher tous</a>
    </form>
    
    <!-- Formulaire d'ajout/modification -->
    <h2>${empty visite.codeVis ? 'Ajouter' : 'Modifier'} une visite</h2>
    <form action="visites" method="post">
        <input type="hidden" name="action" value="${empty visite.codeVis ? 'add' : 'update'}">
        
        <c:if test="${not empty visite.codeVis}">
            <input type="hidden" name="codeVis" value="${visite.codeVis}">
            <p>Code visite : ${visite.codeVis}</p>
        </c:if>
        
        Médecin:
        <select name="codeMed" required>
            <c:forEach items="${medecins}" var="m">
                <option value="${m.codeMed}" 
                    ${not empty visite.medecin && visite.medecin.codeMed == m.codeMed ? 'selected' : ''}>
                    ${m.nom} ${m.prenom}
                </option>
            </c:forEach>
        </select><br>
        
        Patient:
        <select name="codePat" required>
            <c:forEach items="${patients}" var="p">
                <option value="${p.codePat}"
                    ${not empty visite.patient && visite.patient.codePat == p.codePat ? 'selected' : ''}>
                    ${p.nom} ${p.prenom}
                </option>
            </c:forEach>
        </select><br>
        
        Date: 
        <input type="date" name="date" 
            value="<fmt:formatDate value='${visite.date}' pattern='yyyy-MM-dd'/>" 
            required><br>
        
        <button type="submit">${empty visite.codeVis ? 'Ajouter' : 'Modifier'}</button>
        <c:if test="${not empty visite.codeVis}">
            <a href="visites">Annuler</a>
        </c:if>
    </form>
    
    <!-- Liste des visites -->
    <h2>Liste des visites</h2>
    <table>
        <tr>
            <th>Code</th>
            <th>Médecin</th>
            <th>Patient</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
        <c:forEach items="${visites}" var="v">
            <tr>
                <td>${v.codeVis}</td>
                <td>${v.medecin.nom} ${v.medecin.prenom}</td>
                <td>${v.patient.nom} ${v.patient.prenom}</td>
                <td><fmt:formatDate value="${v.date}" pattern="dd/MM/yyyy"/></td>
                <td>
                    <a href="visites?action=edit&codeVis=${v.codeVis}">Modifier</a>
                    <form action="visites" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="codeVis" value="${v.codeVis}">
                        <button type="submit" onclick="return confirm('Supprimer cette visite?')">Supprimer</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>