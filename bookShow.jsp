<%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"%>
<%
    //首先是判断注册或者登录信息是否正确，然后显示主页面
    request.setCharacterEncoding("utf-8");
    //连接Mysql数据库
    String connectString = "jdbc:mysql://172.18.187.6:3306/books_16337045"
                        + "?autoReconnect=true&useUnicode=true"
                        + "&characterEncoding=UTF-8"; 
    String book_id = request.getParameter("book_id");
    String book_name="", price="", img_url="", description="", user_id="";
    String user_name="", contact="";
    Connection con=DriverManager.getConnection(connectString, 
                        "user", "123");
    Statement stmt=con.createStatement();
    String sql=String.format("select * from books where book_id = %s", book_id);
    ResultSet rs=stmt.executeQuery(sql);
    if(rs.next()){
        book_name = rs.getString("book_name");
        price = rs.getString("price");
        img_url = rs.getString("img_url");
        description = rs.getString("description");
        user_id = rs.getString("user_id");
    }
    rs.close();
    stmt.close();
    Statement stmt2 = con.createStatement();
    String sql2 = String.format("select * from user where user_id = '%s'", user_id);
    ResultSet rs2  =stmt2.executeQuery(sql2);
    if(rs2.next()){
        user_name = rs2.getString("user_name");
        contact = rs2.getString("contact");
    }
    %>
<!DOCTYPE html>
<html>
    <head>
        <title>book name</title>
        <style>
            html, body {height:100%; width: 100%;}
            body {background-color:#f5f8fa}
            img{ width:auto; height:auto; max-width:100%; max-height:100%;}
            #main_container {position:absolute; height:500px; width:600px; top:100px; left:300px;}
            #img_div {float:left; width:300px; height:400px; margin-right: 30px;}
            #title {font-family:黑体; font-size:1.5rem; font-weight:blod;}
            .text { margin-bottom:30px; }
            span {white-space:pre;}
            #re_main {float:right;}
        </style>
    </head>
    <body>
        <div id="main_container">
            <div id="re_main"><a href="bookList_16337045.jsp">返回主页</a></div>
            <div id="img_div">
                <img src= "<%=img_url%>"  alt="<%=book_name%>" />
            </div>
            <div id="title" class="text"><%=book_name%></div>
            <div id="description" class="text"><%=description%></div>
            <div id="book_info" class="text">
                <span id="price">价格:<%=price%>元</span>
            </div>
            <div id="user_info">
                <span id="user_name">发布人: <%=user_name%>  </span>
                <span id="contact">联系方式: <%=contact%>  </span>
            </div>
        </div>
    </body>
</html>