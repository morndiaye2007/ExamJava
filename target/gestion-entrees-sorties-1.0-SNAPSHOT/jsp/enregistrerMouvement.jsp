<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Enregistrer un mouvement - Gestion Entrées/Sorties</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0; 
            padding: 20px; 
            background-color: #f4f4f4; 
        }
        .container { 
            max-width: 800px; 
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
        .form-section {
            margin-bottom: 30px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f8f9fa;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        select {
            width: 100%;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        select:focus {
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
            margin-right: 10px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .btn-sortie {
            background-color: #dc3545;
        }
        .btn-sortie:hover {
            background-color: #c82333;
        }
        .message {
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
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
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="app-title">Gestion des Entrées/Sorties</div>
            <h2>Enregistrer un mouvement</h2>
        </div>
        
        <div class="form-section">
            <h3>Entrée</h3>
            <form action="${pageContext.request.contextPath}/mouvements/entree" method="post">
                <div class="form-group">
                    <label for="employeId1">Employé :</label>
                    <select id="employeId1" name="employeId" required>
                        <option value="">-- Sélectionnez un employé --</option>
                        <c:forEach var="e" items="${employes}">
                            <option value="${e.id}">${e.nom} ${e.prenom} (${e.matricule})</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit">Enregistrer Entrée</button>
            </form>
        </div>
        
        <div class="form-section">
            <h3>Sortie</h3>
            <form action="${pageContext.request.contextPath}/mouvements/sortie" method="post">
                <div class="form-group">
                    <label for="employeId2">Employé :</label>
                    <select id="employeId2" name="employeId" required>
                        <option value="">-- Sélectionnez un employé --</option>
                        <c:forEach var="e" items="${employes}">
                            <option value="${e.id}">${e.nom} ${e.prenom} (${e.matricule})</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn-sortie">Enregistrer Sortie</button>
            </form>
        </div>
        
        <c:if test="${not empty message}">
            <div class="message ${message.contains('succès') ? 'success' : 'error'}">
                ${message}
            </div>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/dashboard" class="back-link">← Retour au tableau de bord</a>
    </div>
</body>
</html> 