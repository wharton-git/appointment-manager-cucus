<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ include file="navbar.jsp" %>
        <html>

        <head>
            <title>Gestion des Médecins</title>
            <script src="./assets/style/tailwind_cdn.js"></script>
        </head>

        <body class="bg-gray-50 text-gray-800 p-6">
            <h1 class="text-3xl font-bold mb-6 text-center">Gestion des Médecins</h1>

            <!-- Formulaire de recherche -->
            <form action="medecins" method="get" class="flex flex-wrap items-center gap-2 mb-6">
                <input type="hidden" name="action" value="search">
                <input type="text" name="searchValue" required class="border border-gray-300 rounded px-3 py-2"
                    placeholder="Rechercher...">
                <button type="submit"
                    class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Rechercher</button>
                <a href="medecins" class="text-blue-600 hover:underline ml-2">Afficher tous</a>
            </form>


            <!-- Formulaire d'ajout/modification -->
            <h2 class="text-xl font-semibold mb-4">
                ${empty medecin.codeMed ? 'Ajouter' : 'Modifier'} un médecin
            </h2>
            <form action="medecins" method="post" class="">
                <input type="hidden" name="action" value="${empty medecin.codeMed ? 'add' : 'update'}">
                <c:if test="${not empty medecin.codeMed}">
                    <input type="hidden" name="codeMed" value="${medecin.codeMed}">
                </c:if>
                <div class="flex items-center gap-4 my-4">
                    <c:if test="${empty medecin.codeMed}">
                        <div>
                            <label class="block font-medium">Code:</label>
                            <input type="text" name="codeMed" required
                                class="border border-gray-300 rounded px-3 py-2 w-full">
                        </div>
                    </c:if>
                    <div>
                        <label class="block font-medium">Nom:</label>
                        <input type="text" name="nom" value="${medecin.nom}" required
                            class="border border-gray-300 rounded px-3 py-2 w-full">
                    </div>
                    <div>
                        <label class="block font-medium">Prénom:</label>
                        <input type="text" name="prenom" value="${medecin.prenom}" required
                            class="border border-gray-300 rounded px-3 py-2 w-full">
                    </div>
                    <div>
                        <label class="block font-medium">Grade:</label>
                        <input type="text" name="grade" value="${medecin.grade}"
                            class="border border-gray-300 rounded px-3 py-2 w-full">
                    </div>
                </div>
                <div class="flex gap-4 items-center">
                    <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">
                        ${empty medecin.codeMed ? 'Ajouter' : 'Modifier'}
                    </button>
                    <c:if test="${not empty medecin.codeMed}">
                        <a href="medecins" class="text-red-600 hover:underline">Annuler</a>
                    </c:if>
                </div>
            </form>

            <!-- Liste des médecins -->
            <h2 class="text-xl font-semibold mb-4">Liste des médecins</h2>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white border border-gray-300 rounded shadow">
                    <thead class="bg-gray-100">
                        <tr>
                            <th class="px-4 py-2 border">Code</th>
                            <th class="px-4 py-2 border">Nom</th>
                            <th class="px-4 py-2 border">Prénom</th>
                            <th class="px-4 py-2 border">Grade</th>
                            <th class="px-4 py-2 border">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${medecins}" var="m">
                            <tr class="hover:bg-gray-50">
                                <td class="px-4 py-2 border">${m.codeMed}</td>
                                <td class="px-4 py-2 border">${m.nom}</td>
                                <td class="px-4 py-2 border">${m.prenom}</td>
                                <td class="px-4 py-2 border">${m.grade}</td>
                                <td class="px-4 py-2 border space-x-2">
                                    <a href="medecins?action=edit&codeMed=${m.codeMed}"
                                        class="text-blue-600 hover:underline">Modifier</a>
                                    <form action="medecins" method="post" style="display:inline;" class="inline">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="codeMed" value="${m.codeMed}">
                                        <button type="submit" onclick="return confirm('Supprimer ce médecin?')"
                                            class="text-red-600 hover:underline">Supprimer</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </body>

        </html>