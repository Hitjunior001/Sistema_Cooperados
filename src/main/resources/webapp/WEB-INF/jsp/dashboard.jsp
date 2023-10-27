<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cahke.website.models.User"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.cahke.website.models.Cargo"%>
<%@ page import="com.cahke.website.models.Habilidade"%>


<!DOCTYPE html>
<html xmlns:th="https://www.thymeleaf.org/">
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <script src="https://kit.fontawesome.com/28eecc1f25.js" crossorigin="anonymous"></script>
    <style>
        <%@ include file="/WEB-INF/css/style.css"%>
    </style>
</head>
<body>
<div id="mensagem">
    <div th:if="${sessionScope.successMessage != null}" class="alert-success">${sessionScope.successMessage}</div>
    <div th:if="${sessionScope.failMessage != null}" class="alert-fail">${sessionScope.failMessage}</div>
</div>
<div class="navbar">
    Busca de Cooperados
    <a style="margin-left:30px; font-size:10px; text-align: center; color: white; color:visited: white;" href="/website/admin">Administrar cooperados</a>
</div>
<div class="filters">
    <h3 style="text-align: center;">Busca Principal</h3>
    <form method="get" action="/website/pesquisar">
        <div class="input-field-bar-search">
            <input id="bar-search" name="termos" placeholder="Pesquisar por nome">
            <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
        </div>
        <%
            List<String> termos = (List<String>) request.getAttribute("termos");
            if (termos != null && !termos.isEmpty()) {
                List<String> termosUnicos = new ArrayList<>();
                for (String termo : termos) {
        %>
        <input type="hidden" name="termos" value="<%=termo%>">
        <%
                }
            }
        %>
    </form>
    <div class="termos_da_pesquisa">
        <%
            if (termos != null && !termos.isEmpty()) {
        %>
        <form method="get" action="/website/limpar-filtros">
            <button type="submit" class="clear_filters">Limpar filtros</button>
        </form>
        <ul>
        	<%!public String buildTermosString(List<String> termos, int termToRemove) {
				List<String> termosAtualizados = new ArrayList<>(termos);
				termosAtualizados.remove(termToRemove);
				return termosAtualizados.isEmpty() ? "" : String.join(", ", termosAtualizados);
			}%>
            <%
                for (int i = 0; i < termos.size(); i++) {
            %>
            <li data-termo='<%=termos.get(i)%>'><%=termos.get(i)%>
                <form method="get" action="/website/pesquisar">
                    <input type="hidden" name="termos" value="<%=buildTermosString(termos, i)%>">
                    <input type="hidden" name="remove_termos" value="<%=termos.get(i)%>">
                    <button type="submit">x</button>
                </form>
            </li>
            <%
                }
            %>
        </ul>
        <%
            }
        %>
    </div>
</div>
<div class="dashboard">
    <h2>
        <span th:if="${users != null}">${users.size()}</span>
        Resultados
    </h2>
    <%
        List<User> users = (List<User>) request.getAttribute("users");
        if (users != null) {
    %>
    <div class="users-info">
        <%
            for (User user : users) {
        %>
        <div class="user-info">
            <p><img src=""></p>
            <div class="user-details">
	                <p><%=user.getNome()%> | Adesão: <%=user.getDataCadastro()%></p>
	                <p>Idade: <%=user.getIdade()%> | Cidade: <%=user.getCidade()%>,
	                 <%=user.getEstado().getNomeEstado()%> | Ativo: <%=user.getAtivo()%>
	                 | Cargo: <%=user.getCargo().getCargoNome()%> | Experiência: <%=user.getNivelExperiencia()%>
	                 | Atuação: <%=user.getModeloAtuacao()%> | Carga horário: <%=user.getCargaHoraria()%></p>
	                <p> Principal: <span><%=user.getHabilidades() %></span>  Secundárias: <span> React</span></p>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <%
        }
    %>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

</script>

</body>
</html>