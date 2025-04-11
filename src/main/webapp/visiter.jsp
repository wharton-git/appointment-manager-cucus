<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <html>

            <head>
                <title>Gestion des Visites</title>
                <script src="./assets/style/tailwind_cdn.js"></script>
            </head>

            <body class="bg-gray-50 text-gray-800 p-6">

                <h1 class="text-3xl font-bold mb-6 text-center">Gestion des Visites</h1>

                <c:if test="${not empty error}">
                    <p class="text-red-600 text-center mb-4">Erreur : ${error}</p>
                </c:if>

                <!-- Formulaire de recherche -->
                <form action="visites" method="get"
                    class="bg-white p-4 rounded shadow mb-6 flex flex-col md:flex-row items-center gap-4">
                    <input type="hidden" name="action" value="search">
					<input type="text" name="searchValue" required class="border rounded p-2 flex-grow" placeholder="Rechercher (code, médecin, patient)">
                    <button type="submit"
                        class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">Rechercher</button>
                    <a href="visites" class="text-blue-600 hover:underline">Afficher tous</a>
                </form>

                <!-- Formulaire d'ajout/modification -->
                <div class="bg-white p-6 rounded shadow mb-8">
                    <h2 class="text-xl font-semibold mb-4">${empty visite.codeVis ? 'Ajouter' : 'Modifier'} une visite
                    </h2>
                    <form action="visites" method="post" class="space-y-4">
                        <input type="hidden" name="action" value="${empty visite.codeVis ? 'add' : 'update'}">

                        <c:if test="${not empty visite.codeVis}">
                            <input type="hidden" name="codeVis" value="${visite.codeVis}">
                            <p class="text-gray-700">Code visite : <strong>${visite.codeVis}</strong></p>
                        </c:if>

                        <div>
                            <label class="block mb-1 font-medium">Médecin:</label>
                            <select name="codeMed" required class="w-full border p-2 rounded">
                                <c:forEach items="${medecins}" var="m">
                                    <option value="${m.codeMed}" ${not empty visite.medecin &&
                                        visite.medecin.codeMed==m.codeMed ? 'selected' : '' }>
                                        ${m.nom} ${m.prenom}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label class="block mb-1 font-medium">Patient:</label>
                            <select name="codePat" required class="w-full border p-2 rounded">
                                <c:forEach items="${patients}" var="p">
                                    <option value="${p.codePat}" ${not empty visite.patient &&
                                        visite.patient.codePat==p.codePat ? 'selected' : '' }>
                                        ${p.nom} ${p.prenom}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div>
                            <label class="block mb-1 font-medium">Date:</label>
                            <input type="date" name="date"
                                value="<fmt:formatDate value='${visite.date}' pattern='yyyy-MM-dd'/>"
                                class="w-full border p-2 rounded" required>
                        </div>

                        <div class="flex items-center gap-4">
                            <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">
                                ${empty visite.codeVis ? 'Ajouter' : 'Modifier'}
                            </button>
                            <c:if test="${not empty visite.codeVis}">
                                <a href="visites" class="text-gray-600 hover:underline">Annuler</a>
                            </c:if>
                        </div>
                    </form>
                </div>

                <!-- Liste des visites -->
                <h2 class="text-xl font-semibold mb-4">Liste des visites</h2>
                <div class="overflow-x-auto">
                    <table class="w-full bg-white rounded shadow overflow-hidden">
                        <thead class="bg-gray-200">
                            <tr>
                                <th class="p-3 text-left">Code</th>
                                <th class="p-3 text-left">Médecin</th>
                                <th class="p-3 text-left">Patient</th>
                                <th class="p-3 text-left">Date</th>
                                <th class="p-3 text-left">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${visites}" var="v">
                                <tr class="border-t hover:bg-gray-50">
                                    <td class="p-3">${v.codeVis}</td>
                                    <td class="p-3">${v.medecin.nom} ${v.medecin.prenom}</td>
                                    <td class="p-3">${v.patient.nom} ${v.patient.prenom}</td>
                                    <td class="p-3">
                                        <fmt:formatDate value="${v.date}" pattern="dd/MM/yyyy" />
                                    </td>
                                    <td class="p-3 flex gap-2">
                                        <a href="visites?action=edit&codeVis=${v.codeVis}"
                                            class="text-blue-600 hover:underline">Modifier</a>
                                        <form action="visites" method="post"
                                            onsubmit="return confirm('Supprimer cette visite?')" class="inline">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="codeVis" value="${v.codeVis}">
                                            <button type="submit"
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