
 
    <%@page import="com.myapp.struts.admin.RequestDoc,com.myapp.struts.hbm.*"%>
    <%@page import="com.myapp.struts.admin.AdminReg_Institute"%>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
    <%@ page import="org.apache.taglibs.datagrid.DataGridParameters"%>
     <%@ page import="org.apache.taglibs.datagrid.DataGridTag"%>
    <%@ page import="java.sql.*"%>
    <%@ page import="java.io.*"   %>
    <%@ taglib uri="http://jakarta.apache.org/taglibs/datagrid-1.0" prefix="ui" %>
    <%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

    <title>EMS </title>

    
   
    <%
try{
if(session.getAttribute("institute_id")!=null){
System.out.println("institute_id"+session.getAttribute("institute_id"));
}
else{
    request.setAttribute("msg", "Your Session Expired: Please Login Again");
    %><script>parent.location = "<%=request.getContextPath()%>"+"/login.jsp?session=\"expired\"";</script><%
    }
}catch(Exception e){
    request.setAttribute("msg", "Your Session Expired: Please Login Again");
    %>sessionout();<%
    }
String contextPath = request.getContextPath();
%>

<%!
    Locale locale=null;
    String locale1="en";
    String rtl="ltr";
    boolean page=true;
    String align="left";
%>
<%
try{
locale1=(String)session.getAttribute("locale");

    if(session.getAttribute("locale")!=null)
    {
        locale1 = (String)session.getAttribute("locale");
       // System.out.println("locale="+locale1);
    }
    else locale1="en";
}catch(Exception e){locale1="en";}
     locale = new Locale(locale1);
    if(!(locale1.equals("ur")||locale1.equals("ar"))){ rtl="LTR";page=true;align="left";}
    else{ rtl="RTL";page=false;align="right";}
    ResourceBundle resource = ResourceBundle.getBundle("multiLingualBundle", locale);

    %>

<link rel="stylesheet" href="<%=contextPath%>/css/page.css"/>
 
<script language="javascript" >
function b1click()
{
location.href="login.jsp";
}
function b2click()
{
f.action="login.jsp";
f.method="post";
f.target="_self";
f.submit();
}
function getQuery(id)
{
    var query = "admin/index5.jsp?id="+id;
    return query;
}
function changerec(){
        var x=document.getElementById('rec').value;
    var loc = window.location;
    loc = "http://<%=request.getHeader("host")%><%=request.getContextPath()%>/admin/block_admin.jsp";


            loc = loc + "?pageSize="+x;
    window.location = loc;

    }

   document.onkeyup = keyHit
function keyHit(event) {

  if (event.keyCode == 13) {
  changerec();

    event.stopPropagation()
    event.preventDefault()
  }
}

function isNumberKey(evt)
      {
         var charCode = (evt.which) ? evt.which : event.keyCode
         if (charCode > 31 && (charCode < 48 || charCode > 57))
            return false;

         return true;
      }
</script>
 <link rel="stylesheet" href="/EMS/css/page.css"/>
</head>

<body style="width: 720px">
 
     Deliquent List
<%!
   
   
   RequestDoc Ob;
   ArrayList requestList;
   int fromIndex=0, toIndex;
%>
 <%

 //ResultSet rs = (ResultSet)MyQueryResult.getMyExecuteQuery("select a.*,b.working_status from admin_registration a inner join Institute b on a.library_id=b.library_id and b.working_status='Blocked'");
AdminRegistrationDAO admindao = new AdminRegistrationDAO();
List rs = admindao.getAdminInstituteDetails();
AdminReg_Institute adminReg= new AdminReg_Institute();
   requestList = new ArrayList();
   int tcount =0;
   int perpage=10;
   int tpage=0;
 /*Create a connection by using getConnection() method
   that takes parameters of string type connection url,
   user name and password to connect to database.*/
if(request.getParameter("pageSize")!=null)
    perpage = Integer.parseInt((String)request.getParameter("pageSize"));
//rs.beforeFirst();
if (!rs.isEmpty())
{
Iterator it = rs.iterator();

   while (it.hasNext()) {
        adminReg = (AdminReg_Institute)rs.get(tcount);
       tcount++;
	Ob = new RequestDoc ();
	Ob.setRegistration_id(adminReg.getAdminRegistration().getRegistrationId());
	Ob.setInstitute_name(adminReg.getAdminRegistration().getInstituteName());
	//Ob.setLibrary_name(rs.getString(21));
	Ob.setAdmin_email(adminReg.getAdminRegistration().getAdminEmail());
        Ob.setStatus(adminReg.getAdminRegistration().getStatus());
   requestList.add(Ob);
adminReg=null;
it.next();
   //System.out.println("tcount="+tcount);
		     }
}
System.out.println("tcount="+tcount);

%>

<%
String Registration_ID=resource.getString("registrationid");
pageContext.setAttribute("Registration_ID", Registration_ID);
String Institute_Name=resource.getString("institutename");
pageContext.setAttribute("Institute_Name", Institute_Name);
String Admin_Email=resource.getString("login.ems.adminemail");
pageContext.setAttribute("Admin_Email", Admin_Email);
String Status=resource.getString("login.ems.status");
pageContext.setAttribute("Status", Status);
String Working_Status=resource.getString("workingstatus");
pageContext.setAttribute("Working_Status", Working_Status);
pageContext.setAttribute("rec",perpage);
%>
       
<%
   fromIndex = (int) DataGridParameters.getDataGridPageIndex (request, "datagrid1");
   if ((toIndex = fromIndex+4) >= requestList.size ())
   toIndex = requestList.size();
   request.setAttribute ("requestList", requestList.subList(fromIndex, toIndex));
   pageContext.setAttribute("tCount", tcount);
   pageContext.setAttribute("path", request.getContextPath());
%>

<%if(tcount==0)
{%>
<p class="err" style="font-size:12px"><%=resource.getString("no_record_found")%></p>
<%}
else
{%>

<table align="<%=align%>" dir="<%=rtl%>" width="700px">
    <tr><td colspan="2" align="right">View Next&nbsp;
            <%--<input type="textbox" id="rec" onkeypress="return isNumberKey(event)" onblur="changerec()" style="width:50px"/>--%>
        <select id="rec" onchange="changerec()" style="width:50px">
           <option value="10">10</option>
            <option value="20">20</option>
             <option value="30">30</option>
       </select>
        </td></tr>
    <tr dir="<%=rtl%>"><td dir="<%=rtl%>">

<ui:dataGrid items="${requestList}"  var="doc" name="datagrid1" cellPadding="0" cellSpacing="0" styleClass="datagrid">
    
  <columns>
      
    <column width="50">
      <header value="" hAlign="left" styleClass="header"/>
    </column>

    <column width="100">
      <header value="${Registration_ID}" hAlign="left" styleClass="header"/>
      <item   value="${doc.registration_id}" hyperLink="${path}/admin/index3.jsp?id=${doc.registration_id}"  hAlign="left"    styleClass="item"/>
    </column>

    <column width="200">
      <header value="${Institute_Name}" hAlign="left" styleClass="header"/>
      <item   value="${doc.institute_name}" hAlign="left" hyperLink="${path}/admin/index3.jsp?id=${doc.registration_id}"  styleClass="item"/>
    </column>

       
    <column width="100">
      <header value="${Admin_Email}" hAlign="left" styleClass="header"/>
      <item   value="${doc.admin_email}" hyperLink="${path}/admin/index3.jsp?id=${doc.registration_id}"  hAlign="left" styleClass="item"/>
    </column>

   <column width="100">
   <header value="${Status}" hAlign="left" styleClass="header"/>
 <item  value="${doc.status}" hyperLink="${path}/admin/index3.jsp?id=${doc.registration_id}"  hAlign="left" styleClass="item"/>
    </column>
       <column width="100">
   <header value="${Working_Status}" hAlign="left" styleClass="header"/>
 <item  value="Blocked" hyperLink="${path}/admin/index3.jsp?id=${doc.registration_id}"  hAlign="left" styleClass="item"/>
    </column>
 </columns>

<rows styleClass="rows" hiliteStyleClass="hiliterows"/>
  <alternateRows styleClass="alternaterows"/>

  <paging size="${rec}" count="${tCount}" custom="true" nextUrlVar="next"
       previousUrlVar="previous" pagesVar="pages"/>
  <order imgAsc="up.gif" imgDesc="down.gif"/>
</ui:dataGrid>
<table width="700px" style="font-family: arial; font-size: 10pt" border=0>
<tr>
<td align="left" width="100px">
<c:if test="${previous != null}">
<a href="<c:out value="${previous}"/>"><%=resource.getString("previous")%></a>
</c:if>&nbsp;
<c:if test="${next != null}">
<a href="<c:out value="${next}"/>"><%=resource.getString("next")%></a>
</c:if>

</td><td width="500px" align="center">

<c:forEach items="${pages}" var="page">
<c:choose>
  <c:when test="${page.current}">
    <b><a href="<c:out value="${page.url}"/>"><c:out value="${page.index}"/></a></b>
  </c:when>
  <c:otherwise>
    <a href="<c:out value="${page.url}"/>"><c:out value="${page.index}"/></a>
  </c:otherwise>
</c:choose>
</c:forEach>
</td>

</tr>
<tr><td colspan="2">
        <%

String msg=(String)request.getAttribute("msg");
if(msg!=null)
    {%>
    <p class="err" style="font-size:12px"><%=msg%></p>


<%}%>

    </td></tr>
</table>
<%}%>
</td></tr>
</table>
 
    </body>






</html>
 