<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tableau de bord - Gestion Entrées/Sorties</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0; 
            padding: 20px; 
            background-color: #f4f4f4; 
        }
        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            background: white; 
            padding: 30px; 
            border-radius: 10px; 
            box-shadow: 0 0 20px rgba(0,0,0,0.1); 
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #007bff;
        }
        .app-title {
            color: #007bff;
            font-size: 28px;
            margin-bottom: 10px;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #007bff;
            text-align: center;
        }
        .stat-number {
            font-size: 32px;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 5px;
        }
        .stat-label {
            color: #666;
            font-size: 14px;
        }
        .nav-menu {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 30px;
        }
        .nav-button {
            background-color: #007bff;
            color: white;
            padding: 12px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .nav-button:hover {
            background-color: #0056b3;
        }
        .logout-link {
            background-color: #dc3545;
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            position: absolute;
            top: 20px;
            right: 20px;
        }
        .logout-link:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">Déconnexion</a>
        
        <div class="header">
            <div class="app-title">Gestion des Entrées/Sorties</div>
            <h2>Tableau de bord</h2>
        </div>
        
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-number">${presents}</div>
                <div class="stat-label">Employés présents</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${entrees}</div>
                <div class="stat-label">Entrées aujourd'hui</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${sorties}</div>
                <div class="stat-label">Sorties aujourd'hui</div>
            </div>
        </div>
        
        <div class="nav-menu">
            <a href="${pageContext.request.contextPath}/employes/lister" class="nav-button">Gestion Employés</a>
            <a href="${pageContext.request.contextPath}/mouvements/entree" class="nav-button">Enregistrer Mouvement</a>
            <a href="${pageContext.request.contextPath}/mouvements/lister" class="nav-button">Historique Mouvements</a>
        </div>
    </div>
</body>
</html> 