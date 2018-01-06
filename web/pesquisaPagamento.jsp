
<%-- 
    Document   : pesquisaPagamento
    Created on : 10/10/2017, 08:50:52
    Author     : Aluno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html ng-app="testApp">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <title>Pesquisa Pagamento</title>
        <script src="angular.min.js"></script>
        <style>
            html{
                position: relative;
                min-height: 100%;
            }
        </style>
    </head>
    <body ng-controller="testController" ng-init="getRequest()">
        <nav class="navbar navbar-dark bg-dark navbar-fixed-top">

            <div class="navbar-header">
                <ol class="breadcrumb" style="margin: auto;">
                    <li class="breadcrumb-item"><a href="PaginaAcessoController?tipoLogin=${tipoLogin}">Página do ${tipoLogin}</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Pesquisa de Pagamento</li>
                </ol>
            </div>

            <ul class="nav navbar-nav navbar-right">
                <li><a class="btn btn-outline-danger my-2 my-sm-0" href="index.jsp"> Logout</a></li>
            </ul>
        </nav>
        <div class="container" style="margin: 20px auto;">
            <input class="form-control"  style="margin-bottom: 7px;" id="buscaNome" ng-model="search.codPagamento" placeholder="Pesquise por código" />
            <table class="table" id="tabelaPesquisa">
                <thead class="thead-dark">
                    <tr>
                        <th scope ="co1">Codigo Pagamento</th>
                        <th scope ="co1">Valor</th>
                        <th scope ="co1">Status Pagamento</th>
                        <th scope ="co1">Ação</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="pagamento in pagamentos| filter:search:strict">
                        <td>{{pagamento.codPagamento}}</td>
                        <td>{{pagamento.valorTotal}}</td>
                        <td><span ng-hide="{{pagamento.status}}">Não </span>Pago</td>
                        <td ><div style="float: left" <c:if test="${tipoLogin =='organizador'}">hidden</c:if>>
                                <a class="btn btn-warning"  href="ManterPagamentoController?acao=prepararEditar&tipoLogin=${tipoLogin}&codPagamento={{pagamento.codPagamento}}" />Editar</a>
                            </div>  <div style="float: center" <c:if test="${tipoLogin!='administrador'}">hidden</c:if>>  
                                <a class="btn btn-danger" href="ManterPagamentoController?acao=prepararExcluir&tipoLogin=${tipoLogin}&codPagamento={{pagamento.codPagamento}}"/>Excluir</a>
                            </div></td>
                    </tr>
                </tbody>
            </table>
            <form <c:if test="${tipoLogin=='administrador'}"> action="ManterPagamentoController?acao=prepararIncluir&tipoLogin=${tipoLogin}" </c:if> method="post">
                <div style="float:left"<c:if test="${tipoLogin=='atleta'}"> hidden</c:if>>
                        <input class ="btn btn-success" type="submit" name="btnIncluir" value="Incluir"/></div>
                    <a class="btn btn-info"href="PaginaAcessoController?tipoLogin=${tipoLogin}">Voltar</a>
            </form>
        </div>
        <footer class="footer bg-dark" style=" position: absolute; bottom: 0; width: 100%;" >
            <div class="container">
                <span class="text-muted">Sistema de Controle de Corrida de Rua.</span>
            </div>
        </footer>


        <script>
                    var testApp = angular.module('testApp', []);
                    testApp.controller('testController', function ($scope, $http) {
                        $scope.getRequest = function () {
                            $http.get("http://localhost:8080/SCCR/api/pagamentos")
                                    .then(function successCallback(response) {

                                        $scope.pagamentos = response.data;
                                    }, function errorCallback(response) {
                                        console.log("Unable to perform get request");
                                    });
                        };
                    });
        </script>

    </body>
</html>