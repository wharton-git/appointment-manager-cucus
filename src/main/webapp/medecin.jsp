<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gestion des Médecins</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        tr:nth-child(even) { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Gestion des Médecins</h1>
    
    <!-- Formulaire de recherche -->
    <form action="medecins" method="get">
        <input type="hidden" name="action" value="search">
        <select name="searchType">
            <option value="code">Code</option>
            <option value="nom">Nom</option>
            <option value="prenom">Prénom</option>
        </select>
        <input type="text" name="searchValue" required>
        <button type="submit">Rechercher</button>
        <a href="medecins">Afficher tous</a>
    </form>
    
    <!-- Formulaire d'ajout/modification -->
    <h2>${empty medecin.codeMed ? 'Ajouter' : 'Modifier'} un médecin</h2>
    <form action="medecins" method="post">
        <input type="hidden" name="action" value="${empty medecin.codeMed ? 'add' : 'update'}">
        <c:if test="${not empty medecin.codeMed}">
            <input type="hidden" name="codeMed" value="${medecin.codeMed}">
        </c:if>
        <c:if test="${empty medecin.codeMed}">
            Code: <input type="text" name="codeMed" required><br>
        </c:if>
        Nom: <input type="text" name="nom" value="${medecin.nom}" required><br>
        Prénom: <input type="text" name="prenom" value="${medecin.prenom}" required><br>
        Grade: <input type="text" name="grade" value="${medecin.grade}"><br>
        <button type="submit">${empty medecin.codeMed ? 'Ajouter' : 'Modifier'}</button>
        <c:if test="${not empty medecin.codeMed}">
            <a href="medecins">Annuler</a>
        </c:if>
    </form>
    
    <!-- Liste des médecins -->
    <h2>Liste des médecins</h2>
    <table>
        <tr>
            <th>Code</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Grade</th>
            <th>Actions</th>
        </tr>
        <c:forEach items="${medecins}" var="m">
            <tr>
                <td>${m.codeMed}</td>
                <td>${m.nom}</td>
                <td>${m.prenom}</td>
                <td>${m.grade}</td>
                <td>
                    <a href="medecins?action=edit&codeMed=${m.codeMed}">Modifier</a>
                    <form action="medecins" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="codeMed" value="${m.codeMed}">
                        <button type="submit" onclick="return confirm('Supprimer ce médecin?')">Supprimer</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>