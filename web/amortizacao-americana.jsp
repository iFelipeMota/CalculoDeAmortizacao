<%-- 
    Document   : amortizacao-americana
    Created on : 01/04/2018, 14:31:01
    Author     : ivanf
--%>

<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Amortização Americano</title>
        <link rel="stylesheet" type="text/css" href="_css/estilo.css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/cabecalho.jspf" %>
         <%@include file="WEB-INF/jspf/menu.jspf" %>
        <h1>Amortização Americana</h1>
        <form>
            Digite os dados exigidos
            <br>
            <br>
            Valor do Empréstimo:    
            <input type="text" name="vlEmprestimo"/>
            <br>
            Taxa de Juros ao Mês:   
            <input type="text" name="vlJuros"/>
            <br>
            Quantidade de Parcelas:    
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
                    double juros=taxaJuros;
                    double saldoDevedor = emprestimo;
                    double prestacao = emprestimo/meses;
        %>
                    <table border="1">
                        <tr>
                            <th>Nº de Prestação</th>
                            <th>Amortização</th>
                            <th>Juros(<%=taxaJuros%>% de R$<%=emprestimo%>)</th>
                            <th>Dívida</th>
                        </tr>
                        
                        <tr>
                            <%
                                for(int i=1; i<=meses; i++) {
                                    juros= (taxaJuros/100)*saldoDevedor;
                                    saldoDevedor = saldoDevedor - prestacao;
                            %>
                            <th><%= i %></th>
                            <td><%= NumberFormat.getCurrencyInstance().format(prestacao) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(juros) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(saldoDevedor) %></td>
                        </tr>
                            <%}%>
                    </table>
                <%}catch(Exception e){}}%>
    </body>
</html>
