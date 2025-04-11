<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav class="bg-blue-600 text-white shadow-md">
    <div class="max-w-7xl mx-auto px-6 py-4">
        <div class="flex items-center justify-between">
            <!-- Logo ou titre -->
            <a href="/" class="text-xl font-semibold">Mon Application</a>
            
            <!-- Menu de navigation -->
            <div class="hidden md:flex space-x-8">
                <a href="/hibernate" class="text-white hover:bg-gray-700 px-3 py-2 rounded-md text-lg">Accueil</a>
                <a href="/hibernate/medecins" class="text-white hover:bg-gray-700 px-3 py-2 rounded-md text-lg">Médécins</a>
                <a href="/hibernate/patients" class="text-white hover:bg-gray-700 px-3 py-2 rounded-md text-lg">Patients</a>
                <a href="/hibernate/visites" class="text-white hover:bg-gray-700 px-3 py-2 rounded-md text-lg">Visiter</a>
            </div>
            
            <!-- Menu mobile (réduit) -->
            <div class="md:hidden flex items-center">
                <button class="text-white" onclick="toggleMenu()">
                    <span class="material-icons">menu</span>
                </button>
            </div>
        </div>
    </div>

    <!-- Menu mobile (apparaît après clic) -->
    <div id="mobileMenu" class="md:hidden hidden">
        <div class="space-y-4 p-4">
            <a href="HomePage.jsp" class="text-white block">Accueil</a>
            <a href="EmployeList.jsp" class="text-white block">Employés</a>
            <a href="LieuList.jsp" class="text-white block">Lieux</a>
            <a href="AffectationList.jsp" class="text-white block">Affectations</a>
        </div>
    </div>
</nav>

<script>
    function toggleMenu() {
        const menu = document.getElementById('mobileMenu');
        menu.classList.toggle('hidden');
    }
</script>
