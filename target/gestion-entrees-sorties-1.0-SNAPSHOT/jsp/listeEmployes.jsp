<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des employés - Gestion Entrées/Sorties</title>
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
            font-size: 24px;
            margin-bottom: 10px;
        }
        .actions-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            border: 1px solid #ddd;
            text-align: center;
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            margin: 0 10px;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn-success {
            background-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
        }
        .btn-warning {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-warning:hover {
            background-color: #e0a800;
        }
        .btn-danger {
            background-color: #dc3545;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        .table-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .stats-info {
            background-color: #e7f3ff;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #007bff;
        }
        .status-active {
            color: #28a745;
            font-weight: bold;
        }
        .status-inactive {
            color: #dc3545;
            font-weight: bold;
        }
        .message {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
        }
        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="app-title">Gestion des Entrées/Sorties</div>
            <h2>Liste des employés</h2>
        </div>
        
        <div class="actions-section">
            <a href="${pageContext.request.contextPath}/employes/ajouter" class="btn btn-success">➕ Ajouter un employé</a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn">🏠 Tableau de bord</a>
        </div>
        
        <c:if test="${not empty message}">
            <div class="message ${message.contains('succès') ? 'success' : 'error'}">
                ${message}
            </div>
        </c:if>
        
        <c:if test="${not empty employes}">
            <div class="stats-info">
                <strong>${employes.size()}</strong> employé(s) enregistré(s)
            </div>
        </c:if>
        
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Matricule</th>
                        <th>Poste</th>
                        <th>Statut</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty employes}">
                            <tr>
                                <td colspan="6" class="no-data">
                                    Aucun employé enregistré
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="e" items="${employes}">
                                <tr>
                                    <td><strong>${e.nom}</strong></td>
                                    <td>${e.prenom}</td>
                                    <td><code>${e.matricule}</code></td>
                                    <td>${e.poste}</td>
                                    <td>
                                        <span class="status-${e.actif ? 'active' : 'inactive'}">
                                            ${e.actif ? 'Actif' : 'Inactif'}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/employes/modifier?id=${e.id}" class="btn btn-warning">✏️</a>
                                        <a href="${pageContext.request.contextPath}/employes/supprimer?id=${e.id}" class="btn btn-danger" onclick="return confirm('Êtes-vous sûr de vouloir désactiver cet employé ?')">🗑️</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
        
        <a href="${pageContext.request.contextPath}/dashboard" class="back-link">← Retour au tableau de bord</a>
    </div>
</body>
</html> 