<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="navbar.jsp" %>
    <html>

    <head>
        <title>Gestion Hospitalière</title>
        <script src="./assets/style/tailwind_cdn.js"></script>
    </head>

    <body class="bg-gray-50 min-h-screen">
        <div class="container mx-auto px-4 py-8">
            <h1 class="text-3xl font-light text-gray-800 mb-8 text-center">Bienvenue dans le système de gestion
                hospitalière</h1>

            <div class="max-w-md mx-auto bg-white rounded-lg shadow-sm p-6">
                <ul class="space-y-3">
                    <li>
                        <a href="medecins"
                            class="block px-4 py-2 text-gray-700 hover:bg-blue-50 hover:text-blue-600 rounded transition duration-150">
                            Gestion des médecins
                        </a>
                    </li>
                    <li>
                        <a href="patients"
                            class="block px-4 py-2 text-gray-700 hover:bg-blue-50 hover:text-blue-600 rounded transition duration-150">
                            Gestion des patients
                        </a>
                    </li>
                    <li>
                        <a href="visites"
                            class="block px-4 py-2 text-gray-700 hover:bg-blue-50 hover:text-blue-600 rounded transition duration-150">
                            Gestion des visites
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </body>

    </html>