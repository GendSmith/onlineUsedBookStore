<%@ page language="java" import="java.util.*,java.sql.*,java.util.ArrayList,java.util.List" 
         contentType="text/html; charset=utf-8"
%>

<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <title>删除书本记录</title>
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
String book_id = request.getParameter("book_id");
if (!request.getMethod().equalsIgnoreCase("post")){ 
  String connectString = "jdbc:mysql://172.18.187.6:3306/books_16337045" + "?autoReconnect=true&useUnicode=true" + "&characterEncoding=UTF-8"; 
  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(connectString, "user", "123");
    Statement stmt=con.createStatement();
    String fmt = "delete from books where book_id='%s'";
    String sql = String.format(fmt,book_id);
    int rs = stmt.executeUpdate(sql);
    if(rs>0){msg = "删除成功！";}
    stmt.close();
    con.close();
  }catch(Exception e) {
    msg = e.getMessage();
  }
}%>
  <div class="container">
    <h1>删除书籍记录</h1>
	<%=msg%><br/><br/>
	<a href='bookList_16337045.jsp'>返回主页</a>
  </div>
</body>
</html>
