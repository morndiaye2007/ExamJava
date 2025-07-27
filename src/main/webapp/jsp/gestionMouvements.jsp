<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Gestion des mouvements - Gestion Entrées/Sorties</title>
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
        .employees-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .employee-card {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .employee-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .employee-info {
            margin-bottom: 20px;
        }
        .employee-name {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        .employee-details {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .employee-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .status-present {
            background-color: #28a745;
            color: white;
        }
        .status-absent {
            background-color: #dc3545;
            color: white;
        }
        .btn-group {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        .btn-entree {
            background-color: #28a745;
            color: white;
        }
        .btn-entree:hover {
            background-color: #218838;
        }
        .btn-sortie {
            background-color: #dc3545;
            color: white;
        }
        .btn-sortie:hover {
            background-color: #c82333;
        }
        .btn:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
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
            text-align: center;
        }
        .no-employees {
            text-align: center;
            padding: 40px;
            color: #666;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="app-title">Gestion des Entrées/Sorties</div>
            <h2>Gestion des mouvements</h2>
        </div>
        
        <c:if test="${not empty message}">
            <div class="message ${message.contains('succès') ? 'success' : 'error'}">
                ${message}
            </div>
        </c:if>
        
        <c:if test="${not empty employes}">
            <div class="stats-info">
                <strong>${employes.size()}</strong> employé(s) disponible(s)
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${empty employes}">
                <div class="no-employees">
                    Aucun employé disponible
                </div>
            </c:when>
            <c:otherwise>
                <div class="employees-grid">
                    <c:forEach var="employe" items="${employes}">
                        <div class="employee-card">
                            <div class="employee-info">
                                <div class="employee-name">${employe.nom} ${employe.prenom}</div>
                                <div class="employee-details">
                                    <strong>Matricule:</strong> ${employe.matricule}<br>
                                    <strong>Poste:</strong> ${employe.poste}
                                </div>
                                <c:set var="employeKey" value="employe_${employe.id}_present" />
                                <div class="employee-status ${requestScope[employeKey] ? 'status-present' : 'status-absent'}">
                                    ${requestScope[employeKey] ? 'Présent' : 'Absent'}
                                </div>
                            </div>
                            
                            <div class="btn-group">
                                <form method="post" action="${pageContext.request.contextPath}/mouvements/gestion" style="display: inline;">
                                    <input type="hidden" name="employeId" value="${employe.id}">
                                    <input type="hidden" name="action" value="entree">
                                    <button type="submit" class="btn btn-entree">🚪 Entrée</button>
                                </form>
                                
                                <form method="post" action="${pageContext.request.contextPath}/mouvements/gestion" style="display: inline;">
                                    <input type="hidden" name="employeId" value="${employe.id}">
                                    <input type="hidden" name="action" value="sortie">
                                    <button type="submit" class="btn btn-sortie">🚪 Sortie</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
        
        <a href="${pageContext.request.contextPath}/dashboard" class="back-link">← Retour au tableau de bord</a>
    </div>
</body>
</html> 