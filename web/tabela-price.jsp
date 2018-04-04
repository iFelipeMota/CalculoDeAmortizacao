<%-- 
    Document   : tabela-price
    Created on : 01/04/2018, 14:31:27
    Author     : ivanf
--%>

<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="_css/estilo.css"/>
        <title>Tabela Price</title>
    </head>
    <body>
         <%@include file="WEB-INF/jspf/cabecalho.jspf" %>
         <%@include file="WEB-INF/jspf/menu.jspf" %>
        <h1>Tabela Price</h1>
        <div id="formulario">
        <form>
            Digite os dados exigidos
            <br>
            <br>
            
            <input type="text" name="vlEmprestimo" placeholder="Valor do Empréstimo "/>
            <br>
            <input type="text" name="vlJuros" placeholder="Taxa de Juros Mensal "/>
            <br>
            <input type="text" name="qtMeses" placeholder="Quantidade de meses "/>
            <br>
            <br>
            <input type="submit" value="Calcular"/>
            <br>
        </form>
            </div>
        
        
        <%
            String vlEmprestimo = request.getParameter("vlEmprestimo");
            String vlJuros = request.getParameter("vlJuros");
            String qtMeses = request.getParameter("qtMeses");
            
            if((vlEmprestimo!="" && vlEmprestimo!=null)||(vlJuros!="" && vlJuros!=null)||(qtMeses!="" && qtMeses!=null)){
                try{
                    double valor = Double.parseDouble(vlEmprestimo);
                    double juros = Double.parseDouble(vlJuros);
                    int meses = Integer.parseInt(qtMeses);
                    juros = juros/100;
                    double pmt=0;
                    double calculo = 0;
                    calculo = 1+juros;
                    double calcjuros=0;
                    double amortizacaoConst = 0;
                    double saldoDevedor = 0;
                    double jurosAtual = 0;                    
                    %>
                    <div>
                    <table id="res">
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
                                <%= NumberFormat.getCurrencyInstance().format(valor) %>
                            </td>
                        </tr>
                        <tr>
                            <% 
                                 pmt = valor * (juros/(1-(1/(Math.pow(calculo, meses)))));
                            
                                for(int i=1; i<=meses; i++) {
                                   
                                    calcjuros = valor * juros;
                                    amortizacaoConst = pmt - calcjuros;
                                    jurosAtual= valor * juros;
                                    saldoDevedor = valor - amortizacaoConst;
                                    
                            %>
                            <th><%= i %></th>
                            <td><%= NumberFormat.getCurrencyInstance().format(pmt) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(jurosAtual) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(amortizacaoConst) %></td>
                            <td><%= NumberFormat.getCurrencyInstance().format(saldoDevedor) %></td>
                        </tr>
                        <%valor = valor - amortizacaoConst;%>
                            <%}%>
                    </table>
                <%}catch(Exception e){}}%>               
    <%@include file="WEB-INF/jspf/rodape.jspf" %>
    </div>
    </body>
</html>
