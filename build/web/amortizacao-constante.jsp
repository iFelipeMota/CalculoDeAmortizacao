<%-- 
    Document   : amortizacao-constante
    Created on : 01/04/2018, 14:30:29
    Author     : ivanf
--%>

<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="_css/estilo.css"/>
        <title>Amortização Constante</title>
    </head>
    <body>
         <%@include file="WEB-INF/jspf/cabecalho.jspf" %>
         <%@include file="WEB-INF/jspf/menu.jspf" %>
        <h1>Amortização Constante</h1>
        <form>
            Digite os dados exigidos
            <br>
            <br>
            Valor do Empréstimo:    
            <input type="text" name="vlEmprestimo"/>
            <br>
            Taxa de Juros Mensal:   
            <input type="text" name="vlJuros"/>
            <br>
            Quantidade de Meses:    
            <input type="text" name="qtMeses"/>
            <br>
            <br>
            <input type="submit" value="Calcular"/>
            <br>
        </form>
        <hr/>
        
        <%
            String vlEmprestimo = request.getParameter("vlEmprestimo");
            String vlJuros = request.getParameter("vlJuros");
            String qtMeses = request.getParameter("qtMeses");
            
            if((vlEmprestimo!="" && vlEmprestimo!=null)||(vlJuros!="" && vlJuros!=null)||(qtMeses!="" && qtMeses!=null)){
                try{
                    double emprestimo = Double.parseDouble(vlEmprestimo);
                    double taxaJuros = Double.parseDouble(vlJuros);
                    int meses = Integer.parseInt(qtMeses);
                    double amortizacaoConst = emprestimo / meses;
                    double prestacao;
                    double saldoDevedor = emprestimo;
                    double juros;
        %>
                    <table border="1">
                        <tr>
                            <th>Período</th>
                            <th>Prestação</th>
                            <th>Juros</th>
                            <th>Amortização</th>
                            <th>Saldo Devedor</th>
                        </tr>
                        <tr>
                            <th>0</th>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <%= NumberFormat.getCurrencyInstance().format(saldoDevedor) %>
                            </td>
                        </tr>
                        <tr>
                            <%
                                for(int i=1; i<=meses; i++) {
                                    juros=(meses-i+1)*(taxaJuros/100)*amortizacaoConst;
                                    prestacao = amortizacaoConst + juros;
                                    saldoDevedor = saldoDevedor - amortizacaoConst;
                            %>
                            <th><%= i %></th>
                            <td><%= NumberFormat.getCurrencyInstance().format(prestacao) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(juros) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(amortizacaoConst) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(saldoDevedor) %></td>
                        </tr>
                            <%}%>
                    </table>
                <%}catch(Exception e){}}%>
    <%@include file="WEB-INF/jspf/rodape.jspf" %>
    </body>
</html>
