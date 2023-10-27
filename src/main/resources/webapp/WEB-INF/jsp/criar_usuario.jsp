	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ page import="java.util.List"%>
	<%@ page import="java.util.ArrayList"%>
	<%@ page import="com.cahke.website.models.Cargo"%>
	<%@ page import="com.cahke.website.models.Estado"%>
	<%@ page import="com.cahke.website.models.User"%>
	
	
	<!DOCTYPE html>
	<html>
	<head>
	    <meta charset="UTF-8">
	    <title>Dashboard Admin</title>
	    <style>
	        /* Adicione seu CSS aqui */
	        body {
	            font-family: Arial, sans-serif;
	        }
	
	        form {
	            margin: 20px;
	            padding: 20px;
	            border: 1px solid #ccc;
	            border-radius: 5px;
	        }
	
	        label {
	            display: block;
	            margin-bottom: 10px;
	        }
	
	        input[type="text"], select {
	            width: 100%;
	            padding: 10px;
	            margin-bottom: 10px;
	        }
	
	        input[type="submit"] {
	            background-color: #007bff;
	            color: #fff;
	            border: none;
	            padding: 10px 20px;
	            cursor: pointer;
	        }
	
	        input[type="submit"]:hover {
	            background-color: #0056b3;
	        }
	
	        h1 {
	            font-size: 24px;
	            margin-bottom: 20px;
	        }
	
	        button {
	            background-color: #007bff;
	            color: #fff;
	            border: none;
	            padding: 5px 10px;
	            cursor: pointer;
	        }
	
	        button:hover {
	            background-color: #0056b3;
	        }
	    </style>
	</head>
	<body>
		<% List<String> message = (List<String>) request.getAttribute("message_sucess"); %>
			<% if (message != null) { %>
			    <div class="success-message">
			        <%= message %>
			    </div>
			<% } %>
	    <form method="post" action="/website/create-user">
	        <h1>Criar Usuário</h1>
	        <label for="nome">Nome:</label>
	        <input id="nome" name="nome" type="text">
	        <label for="cargo">Cargo:</label>
	
	        <%
	            List<Cargo> cargos = (List<Cargo>) request.getAttribute("cargos");
	            if (cargos == null) {
	        %>
	        <button>Reiniciar a página</button>
	        <%
	            } else {
	        %>
	        <select id="cargo" name="cargo">
	            <%
	                for (Cargo cargo : cargos) {
	            %>
	            <option value="<%=cargo.getCargoId()%>"><%=cargo.getCargoNome()%></option>
	            <%
	                }
	            %>
	        </select>
	        
	                <select id="estado" name="estado">
	            <%
	            	List<Estado> estados = (List<Estado>) request.getAttribute("estados");
	
	                for (Estado estado : estados) {
	            %>
	            <option value="<%=estado.getIdEstado()%>"><%=estado.getSiglaEstado()%></option>
	            <%
	                }
	            %>
	        </select>
	        
	
	        <label for="salario">Sálario:</label>
	        <select id="salario" name="salario">
	            <option value="1300">R$1300</option>
	            <option value="1130">R$1130</option>
	        </select>
	                <label for="idade">Idade:</label>
	        <input id="idade" name="idade" type="number" required>
	        
	        <label for="cidade">Cidade:</label>
	        <input id="cidade" name="cidade" type="text" required>
	         
	        <label for="habilidades">Habilidades:</label>
			<input type="text" id="habilidades" autocomplete="off" oninput="pesquisarHabilidades()">		
			<input type="hidden" id="habilidadesSelecionadas" name="habilidades">
			<div id="habilidades_selecionadas"></div>
			<div id="pesquisa_habilidades"></div>
	
	        <label for="nivelExperiencia">Nível de Experiência:</label>
	        <input id="nivelExperiencia" name="nivelExperiencia" type="text" required>	
	        
	        <label for="modeloAtuacao">Modelo de Atuação:</label>
	        <input id="modeloAtuacao" name="modeloAtuacao" type="text" required>
	        
	        <label for="cargaHoraria">Carga Horária:</label>
	        <input id="cargaHoraria" name="cargaHoraria" type="number" required>
	        
	        <input type="submit" value="Criar usuário">
	        <%
	            }
	        %>
	    </form>
	
	    <form method="post" action="/website/cargo/criar">
	        <input type="text" name="cargoNome">
	        <input type="submit" value="Criar cargo">
	    </form>
	    
	    
	    <form method="post" action="/website/deleteuser">
	        <label> Deletar úsuario</label>
	        <select name="id">
	        	<%List<User> users = (List<User>) request.getAttribute("users"); %>
	        	<%for(User user : users){ %>
	        	<option value="<%=user.getId()%>"><%=user.getNome()%></option>
	        	<%} %>
	        </select>
	        <input type="submit" value="deletar">
	    </form>
	
	    <form method="get" action="/website/cargo/cargos">
	        <input type="submit" value="Mostrar cargos">
	    </form>
	
	    <form method="post" action="/website/delete-users">
	        <input type="submit" value="Deletar usuários">
	    </form>
	<script>
	var habilidadesArray = [];
	
	function pesquisarHabilidades() {
	  const searchInput = document.getElementById("habilidades").value;
	  fetch("http://localhost:8080/website/api/habilidades")
	    .then(function(response) {
	      if (!response.ok) {
	        throw new Error("Erro na requisição: " + response.status);
	      }
	      return response.json();
	    })
	    .then(function(data) {
	      const optionsHabilidades = document.getElementById("pesquisa_habilidades");
	      optionsHabilidades.innerHTML = "";
	
	      for (let i = 0; i < data.length; i++) {
	        if (data[i].nomeHabilidade.includes(searchInput)) {
	          const option = document.createElement("div");
	          option.textContent = data[i].nomeHabilidade;
	          option.addEventListener("click", function() {
	            adicionarHabilidade(data[i].nomeHabilidade);
			      optionsHabilidades.innerHTML = "";
	          });
	          optionsHabilidades.appendChild(option);
	        }
	      }
	    })
	    .catch(function(error) {
	      console.error("Erro: " + error.message);
	    });
	}
	
	function adicionarHabilidade(habilidade) {
		  habilidadesArray.push(habilidade);
		  exibirHabilidadesSelecionadas();
		}

		function exibirHabilidadesSelecionadas() {
		  const habilidadesSelecionadasDiv = document.getElementById("habilidades_selecionadas");
		  habilidadesSelecionadasDiv.innerHTML = "";

		  habilidadesSelecionadasDiv.textContent = habilidadesArray.join(","); // Converta a lista em uma string separada por vírgulas

		  // Atualize o campo oculto com as habilidades selecionadas
		  const habilidadesSelecionadasInput = document.getElementById("habilidadesSelecionadas");
		  habilidadesSelecionadasInput.value = habilidadesSelecionadasDiv.textContent;
		}
	
	function removerHabilidade(index) {
	  habilidadesArray.splice(index, 1);
	  exibirHabilidadesSelecionadas();
	}
	function converterStringParaLista(habilidadesStr) {
	    // Verifique se a string não está vazia
	    if (habilidadesStr.length <= 0) {
	        return []; // Retorna uma lista vazia se a string estiver vazia
	    }
	    
	    // Divida a string em substrings usando a vírgula como delimitador
	    const habilidadesArray = String(habilidadesStr).split(",");
	    
	    // Use map para remover espaços em branco em excesso e retornar a lista resultante
	    const habilidades = habilidadesArray.map(habilidade => habilidade.trim());
	    
	    return habilidades;
	}
	
	
	function exibirHabilidadesSelecionadas() {
	  const habilidadesSelecionadasDiv = document.getElementById("habilidades_selecionadas");
	  habilidadesSelecionadasDiv.innerHTML = "";
	
	  habilidadesArray.forEach(function(habilidade, index) {
	    const habilidadeDiv = document.createElement("div");
	    habilidadeDiv.textContent = habilidade;
	
	    const removerButton = document.createElement("button");
	    removerButton.textContent = "X";
	    removerButton.addEventListener("click", function() {
	      removerHabilidade(index);
	    });
	
	    habilidadeDiv.appendChild(removerButton);
	    habilidadesSelecionadasDiv.appendChild(habilidadeDiv);
	  });
	
	  // Atualize o campo oculto com as habilidades selecionadas
	  const habilidadesSelecionadasInput = document.getElementById("habilidadesSelecionadas");
	  habilidadesSelecionadasInput.value = converterStringParaLista(habilidadesArray);
	  console.log(habilidadesSelecionadasInput.value);
	  console.log(habilidadesArray);
	}
	
	</script>
	</body>
	</html>
	/