<!--#INCLUDE FILE ="chamar_banco.asp"-->
<!--#INCLUDE FILE ="funcao_senha.asp"-->
<!--#INCLUDE FILE ="CPF_CNPJ.asp"-->
<!--#include file="aDOVBS.inc" -->
<%pesquisa=replace(trim(request("pesquisa")),"'","")
pagina=request("pagina")
radio=request("radio")
opcao=request("opcao")
box=request("deletar")
ordem=request("ordem")
ordem2=request("ordem2")
imovel=request("imovel")
if box <> "" then
   conn.Execute ("update gasto_extra set status=1 where codigo IN ("&box&")")
end if
currentPage = Request( "currentPage" )
Set contador = Server.CreateObject( "ADODB.Recordset" )
contador.activeConnection = conn
contador.CursorType = adOpenStatic
IF currentPage = "" THEN currentPage = 1
Set itens = Server.CreateObject( "ADODB.Recordset" ) 
itens.activeConnection = conn
itens.CursorType = adOpenStatic  
itens.PageSize = 9
if ordem="" then
   ordem="despesa.descricao"
end if
if pesquisa<>"" then
   sql="and despesa.descricao like '%"&pesquisa&"%' "
end if
itens.Open "SELECT gasto_extra.*, imoveis.descricao as imovel, despesa.descricao as despesa FROM ((gasto_extra INNER JOIN imoveis ON gasto_extra.cod_imovel = imoveis.codigo) INNER JOIN despesa ON despesa.codigo = gasto_extra.cod_despesa) WHERE gasto_extra.status = 0 AND gasto_extra.cod_imovel ="&imovel&" "&sql&" ORDER BY "&ordem&" "&ordem2,conn%>
<html>
<head>
<title></title>
<link rel="stylesheet" href="estilo.css">
</head>
<body bgcolor="#f7f7f7" link=black text="#000000" leftmargin="10" topmargin="0" marginwidth="0" marginheight="0" background="../img/bkgd-main.gif">
<br><br>
<table width=90% align="center" bgcolor="white">
  <tr>
    <td class="navdroplist">
      <table width=100% align="center" bgcolor="#FFFFFF">
        <tr>
          <td class="navdroplist">
            <a href="<%=pagina%>.asp?imovel=<%=imovel%>"><img src="../img/logopb.gif" border=0></a>
          </td>
        </tR>
      </table>
      <br>
      <table width=100% align="center" bgcolor="#f7f7f7" border=0>
        <tr>
          <td class="navdroplist" align=center><B>RELAT�RIO DESPESA(S) EXTRA(S)</B></td>
        </tR>
      </table>
      <br>
      <table width=100% align="center" bgcolor="#FFFFFF" border=0>
        
        <tr>
          
          <td class="navdroplist">
             SOLICITANTE:&nbsp<b><%=verificador("nome")%></b>
          </td>
        </tr>
        <tr>
          <td class="navdroplist"  width=30%>
            DATA:&nbsp<b><%=date()%></b>
          </td>
          <td class="navdroplist">
             HORA:&nbsp<b><%=time()%></b>
          </td>
          <td class="navdroplist">
          <%contador.Open "SELECT COUNT(gasto_extra.codigo)as total FROM ((gasto_extra INNER JOIN imoveis ON gasto_extra.cod_imovel = imoveis.codigo) INNER JOIN despesa ON despesa.codigo = gasto_extra.cod_despesa) WHERE gasto_extra.status = 0 AND gasto_extra.cod_imovel ="&imovel&" "&sql,conn%>
           QUANTIDADE DE REGISTRO:&nbsp<b><%=contador("total")%></b>
          </td>
          
        </tr>
       
      </table>
      <br>
      <hr>
      <table width=100% align="center" bgcolor="#FFFFFF" border=0>
        <%If itens.EOF = true then%>
        <tr>
          <td align=center></td>
          <td class="navdroplist" width=100%><b>NENHUM REGISTRO ENCONTRADO!</b></td>
        </tR>
        </table>
        <%else%>
        <tr>
          <td class="navdroplist">
            <b>IM�VEL: <%=itens("imovel")%><B>
        </tr>
        <tr>
           <td class="navdroplist">&nbsp;</td>
        </tr>
        <tr>
           <td class="navdroplist"><b>DESCRI��O:</b></td>
           <td class="navdroplist" align=center><b>VALOR:</b></td>
        </tr>
       <tr><td class="navdroplist"></td></tr>
       <%do while not itens.eof%>
       <tr>
         <td class="navdroplist"><%=itens("despesa")%></td>
         <td class="navdroplist" align=center>R$ <%=formatnumber(itens("valor"),2)%></td>
       </tr>
      <%itens.MoveNext
       loop%>
    <tr>
      <td class="navdroplist">&nbsp;</td>
      <td class="navdroplist">&nbsp;</td>
      <td class="navdroplist">&nbsp;</td>
    </tr>
    
    </table>
    <%end if%>
    <br>
    <center><a href="javascript:window.print()"><img src="../img/impressora.gif" border=0>&nbspImprimir</a></center>
    </td>
  </tr>
</table>
</body>
</html>