<%@ page language="java" import="java.util.*,java.sql.*,java.util.ArrayList,java.util.List" 
         contentType="text/html; charset=utf-8"
%>

<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <title>删除学生记录</title>
   <style>
     a:link,a:visited {color:blue}
     .container{  
    	margin:0 auto; 
    	width:500px;  
    	text-align:center;  
     } 
   </style>
</head>
<body>
<%
String msg = "";
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
if (!request.getMethod().equalsIgnoreCase("post")){ 
  String connectString = "jdbc:mysql://172.18.187.6:3306/teaching"
              + "?autoReconnect=true&useUnicode=true"
              + "&characterEncoding=UTF-8"; 
  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(connectString, 
                      "user", "123");
    Statement stmt=con.createStatement();
    String fmt = "delete from stu where id='%s'";
    String sql = String.format(fmt,id);
    int rs = stmt.executeUpdate(sql);
    if(rs>0){msg = "删除成功！";}
    stmt.close();
    con.close();
  }catch(Exception e) {
    msg = e.getMessage();
  }
}%>
  <div class="container">
    <h1>删除学生记录</h1>
	<%=msg%><br/><br/>
	<a href='browserStu_16337045.jsp'>返回</a>
  </div>
</body>
</html>
