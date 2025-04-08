<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html>

        <head>
            <title>Gestion des Patients</title>
            <script src="./assets/style/tailwind_cdn.js"></script>
        </head>

        <body class="bg-gray-100 text-gray-800 p-6">
            <h1 class="text-3xl font-bold mb-6 text-center">Gestion des Patients</h1>

            <!-- Formulaire de recherche -->
            <form action="patients" method="get" class="flex flex-wrap items-center gap-4 mb-6">
                <input type="hidden" name="action" value="search">
                <select name="searchType" class="border rounded px-3 py-2">
                    <option value="code">Code</option>
                    <option value="nom">Nom</option>
                    <option value="prenom">Prénom</option>
                </select>
                <input type="text" name="searchValue" required class="border rounded px-3 py-2 flex-1"
                    placeholder="Rechercher...">
                <button type="submit"
                    class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Rechercher</button>
                <a href="patients" class="text-blue-600 hover:underline">Afficher tous</a>
            </form>

            <!-- Formulaire d'ajout/modification -->
            <div class="bg-white p-6 rounded shadow mb-8">
                <h2 class="text-xl font-semibold mb-4">${empty patient.codePat ? 'Ajouter' : 'Modifier'} un patient</h2>
                <form action="patients" method="post" class="space-y-4">
                    <input type="hidden" name="action" value="${empty patient.codePat ? 'add' : 'update'}">
                    <c:if test="${not empty patient.codePat}">
                        <input type="hidden" name="codePat" value="${patient.codePat}">
                    </c:if>
                    <div>
                        <label class="block font-medium">Nom:</label>
                        <input type="text" name="nom" value="${patient.nom}" required
                            class="border rounded px-3 py-2 w-full">
                    </div>
                    <div>
                        <label class="block font-medium">Prénom:</label>
                        <input type="text" name="prenom" value="${patient.prenom}" required
                            class="border rounded px-3 py-2 w-full">
                    </div>
                    <div>
                        <label class="block font-medium">Sexe:</label>
                        <select name="sexe" class="border rounded px-3 py-2 w-full">
                            <option value="M" ${patient.sexe=='M' ? 'selected' : '' }>Masculin</option>
                            <option value="F" ${patient.sexe=='F' ? 'selected' : '' }>Féminin</option>
                        </select>
                    </div>
                    <div>
                        <label class="block font-medium">Adresse:</label>
                        <input type="text" name="adresse" value="${patient.adresse}"
                            class="border rounded px-3 py-2 w-full">
                    </div>
                    <div class="flex items-center gap-4">
                        <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">
                            ${empty patient.codePat ? 'Ajouter' : 'Modifier'}
                        </button>
                        <c:if test="${not empty patient.codePat}">
                            <a href="patients" class="text-red-600 hover:underline">Annuler</a>
                        </c:if>
                    </div>
                </form>
            </div>

            <!-- Liste des patients -->
            <h2 class="text-2xl font-semibold mb-4">Liste des patients</h2>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white rounded shadow">
                    <thead class="bg-gray-200">
                        <tr>
                            <th class="px-4 py-2 text-left">Code</th>
                            <th class="px-4 py-2 text-left">Nom</th>
                            <th class="px-4 py-2 text-left">Prénom</th>
                            <th class="px-4 py-2 text-left">Sexe</th>
                            <th class="px-4 py-2 text-left">Adresse</th>
                            <th class="px-4 py-2 text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${patients}" var="p">
                            <tr class="border-t hover:bg-gray-50">
                                <td class="px-4 py-2">${p.codePat}</td>
                                <td class="px-4 py-2">${p.nom}</td>
                                <td class="px-4 py-2">${p.prenom}</td>
                                <td class="px-4 py-2">${p.sexe}</td>
                                <td class="px-4 py-2">${p.adresse}</td>
                                <td class="px-4 py-2 space-x-2">
                                    <a href="patients?action=edit&codePat=${p.codePat}"
                                        class="text-blue-600 hover:underline">Modifier</a>
                                    <form action="patients" method="post" class="inline">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="codePat" value="${p.codePat}">
                                        <button type="submit" onclick="return confirm('Supprimer ce patient?')"
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