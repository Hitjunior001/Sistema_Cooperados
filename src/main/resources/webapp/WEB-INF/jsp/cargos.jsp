<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List"%>
<%@ page import="com.cahke.website.models.Cargo"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%List<Cargo> cargos =(List<Cargo>) request.getAttribute("cargos");   %>
    <div class="cargos">
    <%for(Cargo cargo : cargos){ %>
	<table border="1">
	<tr> 
	<td> CargoId </td>
	<td> CargoNome </td>
	</tr>
	<tr>
	<td> <%=cargo.getCargoId()%> </td>
	<td> <%=cargo.getCargoNome()%> </td>
	</tr>
	</table>
    <%}%>
    </div>
</body>
</html>