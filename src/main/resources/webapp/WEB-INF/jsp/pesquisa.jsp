<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <style>
        #barraPesquisa,
        #modeloAtuacao,
        #habilidades {
            margin: 10px;
            padding: 5px;
            width: 200px;
        }

        #insert_habilidade,
        #pesquisarButton {
            margin: 10px;
            padding: 5px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        /* Estilos para os resultados */
        #resultados {
            margin: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f8f8f8;
        }

        /* Estilos para as habilidades selecionadas */
        #habilidades_selecionadas {
            margin: 10px;
            padding: 5px;
        }

        /* Estilos para os botões de remoção das habilidades */
        button {
            background-color: #ff5722;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        /* Estilos para o botão de pesquisa de habilidades */
        #insert_habilidade {
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        /* Estilos para os cartões de usuário */
        .user-card {
            margin: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            box-shadow: 2px 2px 5px #888;
            display: grid;
            grid-template-rows: auto auto auto;
            gap: 10px;

            /* Estilos para as sugestões de habilidades */
            #sugestoes {
                position: absolute;
                background-color: #fff;
                border: 1px solid #ccc;
                max-height: 100px;
                overflow-y: auto;
                display: none;
            }

            #sugestoes ul {
                list-style: none;
                padding: 0;
            }

            #sugestoes ul li {
                padding: 5px;
                cursor: pointer;
            }

            #sugestoes ul li:hover {
                background-color: #f0f0f0;
            }
        }
    </style>
</head>

<body>
    <div id="barraPesquisaInfield">
        <input type="text" name="pesquisar" id="barraPesquisa" placeholder="Pesquisar por nome" oninput="pesquisar()">
    </div>
    <div style="display: block;">
        <label> Pesquisa dinamica: </label>
        <div class="group-button">
            <label for="pesquisaDinamicaTrue">Sim</label>
            <input type="radio" id="pesquisaDinamicaTrue" name="pesquisaDinamica" value="true">
            <label for="pesquisaDinamicaFalse">Não</label>
            <input type="radio" id="pesquisaDinamicaFalse" name="pesquisaDinamica" value="false">
        </div>
        <label> Pesquisar por modelo de atuação</label>
        <select name="modeloAtuacao" id="modeloAtuacao" onchange="pesquisar()">
            <option value="Todos">Todos</option>
            <option value="Hibrido">Híbrido</option>
            <option value="Remoto">Remoto</option>
            <option value="Presencial">Presencial</option>
        </select>
    </div>
    <input type="text" name="habilidades" id="habilidades" autocomplete="off" oninput="autoCompleteHabilidades(value)"
        placeholder="Pesquisar por habilidades">
    <div id="sugestoes" class="sugestoes"></div>
    <input type="button" value="Pesquisar habilidade" id="insert_habilidade" onclick="pesquisaHabilidade()">
    <div id="habilidades_selecionadas"></div>
    <label> Estado </label>
    <select name="estadoInput" id="estadoInput"></select>
    <div id="estados_selecionados"></div>

    <div id="resultados"></div>
    <script>

        var termosAll = [];
        var estadosSelecionados = [];
        var resultadosUnicos = [];
        var estadosDisponiveis = [];

        function loadEstado() {
            let estadoInput = document.querySelector("#estadoInput")
            let divEstadosSelecionados = document.querySelector("#estados_selecionados");
            divEstadosSelecionados.textContent = '';
            fetch("http://localhost:8080/website/api/estados")
                .then(function (response) {
                    if (!response.ok) {
                        throw new Error("Erro na requisição" + response.status);
                    }
                    return response.json();
                }).then(function (data) {
                    for (let i = 0; i < data.length; i++) {
                        if (!estadosDisponiveis.includes(data[i].siglaEstado)) {
                            estadosDisponiveis.push(data[i].siglaEstado);
                            let optionEstado = document.createElement("option");
                            optionEstado.value = JSON.stringify(data[i]);
                            optionEstado.textContent = data[i].siglaEstado;
                            optionEstado.addEventListener("click", function () {
                                if (!estadosSelecionados.includes(data[i].siglaEstado)) {
                                    estadosSelecionados.push(data[i].siglaEstado);
                                    loadEstado();
                                } else {
                                    console.log("Estado já adicionado");
                                }
                            })
                            estadoInput.appendChild(optionEstado);
                        }
                    }
                    for (let k = 0; k < estadosSelecionados.length; k++) {
                        let estadoSelecionado = document.createElement("div");
                        estadoSelecionado.textContent = estadosSelecionados[k];
                        estadoSelecionado.value = estadosSelecionados[k];
                        estadoSelecionado.classList.add(estadosSelecionados[k]);
                        const button = document.createElement("button");
                        button.textContent = "x";
                        button.addEventListener('click', function () {
                            let indexEstado = estadosSelecionados.indexOf(estadoSelecionado.value);
                            if (indexEstado > -1) {
                                estadosSelecionados.splice(indexEstado, 1);
                                estadoSelecionado.remove();
                            }
                            loadEstado();
                        })
                        estadoSelecionado.appendChild(button);
                        divEstadosSelecionados.appendChild(estadoSelecionado);
                    }
                });
            pesquisar()
        };
        estadoInput.addEventListener("change", loadEstado());

        function enablePesquisaDinamica() {
            let switchButton = document.querySelector('input[name="pesquisaDinamica"]:checked').value;
            let divBarraPesquisa = document.querySelector('#barraPesquisaInfield');
            let barraPesquisa = document.querySelector("#barraPesquisa");
            if (switchButton == "false") {
                let button = document.createElement('button');
                barraPesquisa.oninput = null;
                button.textContent = "Pesquisar";
                button.classList.add("buttonPesquisa");
                button.id = "pesquisarButton";
                button.onclick = function () {
                    pesquisar();
                };
                divBarraPesquisa.appendChild(button);
            } else {
                const existingButton = document.querySelector("#pesquisarButton");
                barraPesquisa.oninput = function () {
                    pesquisar();
                }

                if (existingButton) {
                    existingButton.remove();
                }
            }
        }

        const switchButton = document.querySelectorAll('input[name="pesquisaDinamica"]');
        switchButton.forEach(function (radio) {
            radio.addEventListener('change', function (event) {
                if (event.target.checked) {
                    enablePesquisaDinamica()
                }
            });
        });

        function pesquisar() {
            let resultado = document.querySelector("#resultados");
            let nomePesquisa = document.querySelector("#barraPesquisa").value;
            let modeloAtuacaoPesquisa = document.querySelector("#modeloAtuacao").value;
            resultado.innerHTML = "";

            fetch("http://localhost:8080/website/api/usuarios")
                .then(function (response) {
                    if (!response.ok) {
                        throw new Error("Erro na requisição" + response.status);
                    }
                    return response.json();
                }).then(function (data) {
                    resultadosUnicos = [];
                    for (let i = 0; i < data.length; i++) {
                        let listaHabilidadeUser = interarJson(data[i].habilidades)
                        function checkHabilidade() {
                            for (let k = 0; k < termosAll.length; k++) {
                                if (!listaHabilidadeUser.includes(termosAll[k])) {
                                    return false;
                                }
                            }
                            return true;
                        }
                        function checkEstado(estado) { //Objeto do Estado de usuario.
                            if (estadosSelecionados.includes(estado)) {
                                return true;
                            }
                            else if (estadosSelecionados.length === 0) {
                                return true; // Retorna verdadeiro se nenhum estado estiver selecionado
                            }
                            return false;

                        }
                        if (
                            (data[i].nome.includes(nomePesquisa) && modeloAtuacaoPesquisa === "Todos" && checkEstado(data[i].estado.siglaEstado) ||
                                data[i].nome.includes(nomePesquisa) && data[i].modeloAtuacao.includes(modeloAtuacaoPesquisa)) &&
                            (termosAll.length === 0 && checkEstado(data[i].estado.siglaEstado) ||
                                checkHabilidade(interarJson(data[i].habilidades)))
                        ) {

                            const user = document.createElement("div");
                            user.classList.add("user-card");
                            for (const key in data[i]) {
                                if (data[i].hasOwnProperty(key)) {
                                    const p = document.createElement("span");
                                    p.textContent = key + ": ";
                                    const value = data[i][key];
                                    if (typeof value === 'object') {
                                        if (value.hasOwnProperty('siglaEstado') && value.hasOwnProperty('nomeEstado')) {
                                            p.textContent += value.nomeEstado;
                                        } else if (value.hasOwnProperty('cargoNome')) {
                                            p.textContent += value.cargoNome;
                                        }
                                        else {
                                            const span = document.createElement("span");
                                            const jsonString = JSON.stringify(value);
                                            const cleanedString = jsonString.replace(/["\{}[\]]/g, '');
                                            span.textContent = cleanedString;
                                            p.appendChild(span);
                                        }
                                    } else {
                                        if (key === 'salario') {
                                            p.textContent += 'R$ ' + value;
                                        } else {

                                            p.textContent += ' ' + value;
                                        }
                                    }
                                    user.appendChild(p);
                                }
                            }
                            resultadosUnicos.push(user);
                        }
                    }
                    resultadosUnicos.forEach(function (user) {
                        resultado.appendChild(user);
                    });
                });
        }
        function pesquisaHabilidade() {
            let pesquisaHabilidade = document.querySelector("#habilidades").value;
            let termos = document.querySelector("#habilidades_selecionadas");
            let buttonPesquisa = document.querySelector("#insert_habilidade");

            if (pesquisaHabilidade != null) {
                const div = document.createElement("div");
                div.textContent = pesquisaHabilidade;
                const button = document.createElement("button");
                button.textContent = "X"
                button.addEventListener("click", function () {
                    let element = termosAll.indexOf(pesquisaHabilidade);
                    if (element !== -1) {
                        termosAll.splice(element, 1);
                    }
                    div.remove();
                    pesquisar();
                })
                div.appendChild(button)
                fetch("http://localhost:8080/website/api/habilidades")
                    .then(function (response) {
                        if (!response.ok) {
                            throw new Error("Erro na requisição" + response.status);
                        }
                        return response.json();
                    }).then(function (data) {
                        //MÉTODO 1 - ITERAR SOBRE A LISTA E COMPARANDO.
                        for (let i = 0; i < data.length; i++) {
                            if (data[i].nomeHabilidade.includes(pesquisaHabilidade)) {
                                if (termosAll.includes(pesquisaHabilidade)) {
                                    console.log("Termo já incluso");
                                } else {
                                    termosAll.push(pesquisaHabilidade);
                                    termos.appendChild(div);
                                }
                            }
                        }
                    });
                pesquisar();
            }
        }
        function interarJson(data) {
            listData = []
            for (let i = 0; i < data.length; i++) {
                listData.push(data[i])
            }
            return listData;
        }
        function autoCompleteHabilidades(query) {
            var sugestoes = document.querySelector('#sugestoes');
            sugestoes.innerHTML = ''; // Limpa as sugestões anteriores

            if (query.length === 0) {
                sugestoes.style.display = 'none';
                return;
            }

            // Realize uma solicitação à API para buscar as sugestões com base na consulta (query).
            // Substitua a URL abaixo pela URL real da sua API de habilidades.
            var apiUrl = 'http://localhost:8080/website/api/habilidades?query=' + query;

            fetch(apiUrl)
                .then(function (response) {
                    if (!response.ok) {
                        throw new Error('Erro na requisição ' + response.status);
                    }
                    return response.json();
                })
                .then(function (data) {
                    data.forEach(function (sugestao) {
                        if (sugestao.nomeHabilidade.includes(query)) {
                            var item = document.createElement('div');
                            item.textContent = sugestao.nomeHabilidade;
                            item.classList.add('sugestao');
                            item.addEventListener('click', function () {
                                document.querySelector('#habilidades').value = sugestao.nomeHabilidade;
                                sugestoes.style.display = 'none';
                            });
                            sugestoes.appendChild(item);
                        }
                    });

                    if (sugestoes.children.length > 0) {
                        sugestoes.style.display = 'block';
                    } else {
                        sugestoes.style.display = 'none';
                    }
                })
                .catch(function (error) {
                    console.error('Erro ao buscar sugestões de habilidades:', error);
                });
        }

        pesquisar()

</script>
</body>
</html>