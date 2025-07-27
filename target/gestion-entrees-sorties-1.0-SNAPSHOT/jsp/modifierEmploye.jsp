<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier un employé - Gestion Entrées/Sorties</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background-color: #f4f4f4; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
        .header { text-align: center; margin-bottom: 30px; padding-bottom: 20px; border-bottom: 2px solid #007bff; }
        .app-title { color: #007bff; font-size: 24px; margin-bottom: 10px; }
        .form-section { background-color: #f8f9fa; padding: 25px; border-radius: 8px; border: 1px solid #ddd; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #333; }
        input[type="text"] { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 5px; font-size: 16px; box-sizing: border-box; }
        input[type="text"]:focus { border-color: #007bff; outline: none; }
        .checkbox-group { display: flex; align-items: center; gap: 10px; }
        input[type="checkbox"] { width: 18px; height: 18px; }
        .btn-group { display: flex; gap: 15px; margin-top: 20px; }
        button { padding: 12px 30px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; font-weight: bold; flex: 1; }
        .btn-primary { background-color: #007bff; color: white; }
        .btn-primary:hover { background-color: #0056b3; }
        .btn-secondary { background-color: #6c757d; color: white; }
        .btn-secondary:hover { background-color: #545b62; }
        .back-link { display: inline-block; margin-top: 20px; color: #007bff; text-decoration: none; font-weight: bold; }
        .back-link:hover { text-decoration: underline; }
        .required { color: #dc3545; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="app-title">Gestion des Entrées/Sorties</div>
            <h2>Modifier un employé</h2>
        </div>
        
        <div class="form-section">
            <form action="${pageContext.request.contextPath}/employes/modifier" method="post">
                <input type="hidden" name="id" value="${employe.id}">
                
                <div class="form-group">
                    <label for="nom">Nom <span class="required">*</span></label>
                    <input type="text" id="nom" name="nom" value="${employe.nom}" required>
                </div>
                
                <div class="form-group">
                    <label for="prenom">Prénom <span class="required">*</span></label>
                    <input type="text" id="prenom" name="prenom" value="${employe.prenom}" required>
                </div>
                
                <div class="form-group">
                    <label for="matricule">Matricule <span class="required">*</span></label>
                    <input type="text" id="matricule" name="matricule" value="${employe.matricule}" required>
                </div>
                
                <div class="form-group">
                    <label for="poste">Poste <span class="required">*</span></label>
                    <input type="text" id="poste" name="poste" value="${employe.poste}" required>
                </div>
                
                <div class="form-group">
                    <div class="checkbox-group">
                        <input type="checkbox" id="actif" name="actif" ${employe.actif ? 'checked' : ''}>
                        <label for="actif">Employé actif</label>
                    </div>
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn-primary">Modifier l'employé</button>
                    <a href="${pageContext.request.contextPath}/employes/lister" class="btn-secondary" style="text-decoration: none; text-align: center; line-height: 45px;">Annuler</a>
                </div>
            </form>
        </div>
        
        <a href="${pageContext.request.contextPath}/employes/lister" class="back-link">← Retour à la liste des employés</a>
    </div>
</body>
</html> 