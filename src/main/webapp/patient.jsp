<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestion des Patients</title>
    <style>table { border-collapse: collapse; width: 100%; } th, td { border: 1px solid #ddd; padding: 8px; text-align: left; } tr:nth-child(even) { background-color: #f2f2f2; }</style>
</head>
<body>
    <h1>Gestion des Patients</h1>
    
    <!-- Formulaire de recherche -->
    <form action="patients" method="get">
        <input type="hidden" name="action" value="search">
        <select name="searchType">
            <option value="code">Code</option>
            <option value="nom">Nom</option>
            <option value="prenom">Prénom</option>
        </select>
        <input type="text" name="searchValue" required>
        <button type="submit">Rechercher</button>
        <a href="patients">Afficher tous</a>
    </form>
    
    <!-- Formulaire d'ajout/modification -->
    <h2>${empty patient.codePat ? 'Ajouter' : 'Modifier'} un patient</h2>
    <form action="patients" method="post">
        <input type="hidden" name="action" value="${empty patient.codePat ? 'add' : 'update'}">
        <c:if test="${not empty patient.codePat}">
            <input type="hidden" name="codePat" value="${patient.codePat}">
        </c:if>
        Nom: <input type="text" name="nom" value="${patient.nom}" required><br>
        Prénom: <input type="text" name="prenom" value="${patient.prenom}" required><br>
        Sexe: 
        <select name="sexe">
            <option value="M" ${patient.sexe == 'M' ? 'selected' : ''}>Masculin</option>
            <option value="F" ${patient.sexe == 'F' ? 'selected' : ''}>Féminin</option>
        </select><br>
        Adresse: <input type="text" name="adresse" value="${patient.adresse}"><br>
        <button type="submit">${empty patient.codePat ? 'Ajouter' : 'Modifier'}</button>
        <c:if test="${not empty patient.codePat}">
            <a href="patients">Annuler</a>
        </c:if>
    </form>
    
    <!-- Liste des patients -->
    <h2>Liste des patients</h2>
    <table>
        <tr>
            <th>Code</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Sexe</th>
            <th>Adresse</th>
            <th>Actions</th>
        </tr>
        <c:forEach items="${patients}" var="p">
            <tr>
                <td>${p.codePat}</td>
                <td>${p.nom}</td>
                <td>${p.prenom}</td>
                <td>${p.sexe}</td>
                <td>${p.adresse}</td>
                <td>
                    <a href="patients?action=edit&codePat=${p.codePat}">Modifier</a>
                    <form action="patients" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="codePat" value="${p.codePat}">
                        <button type="submit" onclick="return confirm('Supprimer ce patient?')">Supprimer</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>