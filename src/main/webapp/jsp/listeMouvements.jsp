<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Historique des mouvements - Gestion Entrées/Sorties</title>
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
        .filters-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            border: 1px solid #ddd;
        }
        .filters-form {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            align-items: end;
        }
        .form-group {
            margin-bottom: 0;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        select, input[type="date"] {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
        }
        select:focus, input[type="date"]:focus {
            border-color: #007bff;
            outline: none;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }
        button:hover {
            background-color: #0056b3;
        }
        .table-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
        .type-entree {
            color: #28a745;
            font-weight: bold;
        }
        .type-sortie {
            color: #dc3545;
            font-weight: bold;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="app-title">Gestion des Entrées/Sorties</div>
            <h2>Historique des mouvements</h2>
        </div>
        
        <div class="filters-section">
            <h3>Filtres</h3>
            <form method="get" action="${pageContext.request.contextPath}/mouvements/lister" class="filters-form">
                <div class="form-group">
                    <label for="employeId">Employé :</label>
                    <select id="employeId" name="employeId">
                        <option value="">-- Tous les employés --</option>
                        <c:forEach var="e" items="${employes}">
                            <option value="${e.id}" <c:if test="${param.employeId == e.id}">selected</c:if>>
                                ${e.nom} ${e.prenom} (${e.matricule})
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="date">Date :</label>
                    <input type="date" id="date" name="date" value="${param.date}" />
                </div>
                <div class="form-group">
                    <label for="type">Type :</label>
                    <select id="type" name="type">
                        <option value="">-- Tous les types --</option>
                        <option value="ENTREE" <c:if test="${param.type == 'ENTREE'}">selected</c:if>>Entrée</option>
                        <option value="SORTIE" <c:if test="${param.type == 'SORTIE'}">selected</c:if>>Sortie</option>
                    </select>
                </div>
                <div class="form-group">
                    <button type="submit">Filtrer</button>
                </div>
            </form>
        </div>
        
        <c:if test="${not empty mouvements}">
            <div class="stats-info">
                <strong>${mouvements.size()}</strong> mouvement(s) trouvé(s)
            </div>
        </c:if>
        
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Employé</th>
                        <th>Date/Heure</th>
                        <th>Type</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty mouvements}">
                            <tr>
                                <td colspan="3" class="no-data">
                                    Aucun mouvement trouvé
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="m" items="${mouvements}">
                                <tr>
                                    <td><strong>${m.employe.nom} ${m.employe.prenom}</strong><br>
                                        <small>${m.employe.matricule}</small></td>
                                    <td>
                                        ${m.dateHeure.format(dateFormatter)}<br>
                                        ${m.dateHeure.format(timeFormatter)}
                                    </td>
                                    <td>
                                        <span class="type-${m.type == 'ENTREE' ? 'entree' : 'sortie'}">
                                            ${m.type}
                                        </span>
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