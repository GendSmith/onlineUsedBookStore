 <%@ page language="java" import="java.util.*,java.sql.*"
contentType="text/html; charset=utf-8"%>
<%
    //首先是判断注册或者登录信息是否正确，然后显示主页面
    request.setCharacterEncoding("utf-8");
    String msg = "";
    //连接Mysql数据库
    if (request.getMethod().equalsIgnoreCase("post")){
      try{
        String connectString = "jdbc:mysql://172.18.187.6:3306/books_16337045"
                            + "?autoReconnect=true&useUnicode=true"
                            + "&characterEncoding=UTF-8"; 
      
        String submit = request.getParameter("sign_in");
        String register_username = request.getParameter("register_username");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        String user_type = request.getParameter("user_type");
        Connection con=DriverManager.getConnection(connectString, 
                            "user", "123");
        Statement stmt=con.createStatement();
        String CHECK_USER_EXIST_SQL = "select * from user where user_name='" + register_username + "'" ;

       
        ResultSet rs = stmt.executeQuery(CHECK_USER_EXIST_SQL);
        out.print(register_username);
        if(!rs.next()){
          out.print("hhh");
          String INSERT_USER_SQL = String.format("insert into user (user_name,password,user_type,contact) values('%s','%s','%s','%s')",register_username,password,user_type,contact);
          int insert_result = stmt.executeUpdate(INSERT_USER_SQL);
          if(insert_result>0){
            msg = "注册成功~";
          }
        }else {
          msg = "用户名已存在，请更换用户名注册~";
        }
        
        rs.close();
        stmt.close();
        con.close();
      }catch(Exception e){
        msg = e.getMessage();
      }
    }
    %> 
<!DOCTYPE html>
<html>
    <head>
        <title>注册</title>
        <style>
            html, body {height:100%; width: 100%;}
            a:link {text-decoration: none; color:skyblue;}
            a:visited {color:brown;}
            a:hover {color:blue; text-decoration: underline;}
            .content-wrap {height:100%; width:100%;}
            .container {width:500px; height:600px; position: absolute; top:20px; left:420px; background: white;}
            .login-section {width:400px; margin:0 auto; padding:30px;}
            .form-text, .form-group {margin:30px 0;}
            .active {display: inline-block; width:195px; height:60px; text-align: center;
                 padding-top:30px; font-size:1.5rem; font-family: 楷体;}
            .active:hover {background: #c0c0c0;}
            label {font-weight: bold;white-space: pre;}
            input[type="text"], input[type="password"] {width:250px; height:40px; border-radius: 5px;}
            input[type="text"]:focus {background: skyblue;}
            input[type="password"]:focus {background:springgreen;}
            .form-btn {width:400px; text-align: center;}
            .btn {color:white; background: cornflowerblue; border-radius: 10px; width:200px; height:40px;}
            .btn:hover {background: darkcyan; cursor: pointer;}
            .checkbox-inline {clear: black; font-weight: normal;}
        </style>
        <script>
            function check(){
                var password1 = document.getElementById("register_password");
                var password2 = document.getElementById("register_password2");
                var register_form = document.getElementById("register-form");
                var register_div = document.getElementById("register_div");
                if(password1.value == password2.value)
                    return true;
                var txt = document.createTextNode("密码不匹配，请重新输入");
                var p = document.createElement("p");
                p.appendChild(txt);
                register_form.insertBefore(p, register_div);
                return false;
            }
        </script>
    </head>
    <body>
        <div class="content-wrap" style="background-color:#f5f8fa">
            <!-- content in this page -->    
            <div id="content-container" class="container">
                <div class="login-section">
                    <div class="logon-tab clearfix">
                        <a href="login.html" class="active" id="login-a">登录</a>
                        <a href="register.html" class="active">注册</a>
                    </div>
                    <div class="register-main">
                        <form id="register-form" class="form-vertical" method="post"
                                action="register_16337045.jsp" data-parsley-validate="" onsubmit="return check()">
                            <div class="form-text mbl">
                                <label class="control-label" for="register_username">    用户名    </label>
                                <input class="form-control input-lg" id="register_username" type="text" 
                                        name="register_username" value="" placeholder="用户名"
                                        data-parsley-required-message="请输入您的用户名"
                                        data-parsley-type="email" data-parsley-maxlength="128" required="required">
                            </div>
                            <div class="form-text mbl">
                                <label class="control-label" for="register_password">       密码    </label>
                                <input class="form-control input-lg" id="register_password" type="password" 
                                        name="password" value="" placeholder="密码"
                                        data-parsley-required-message="请输入您的登录密码"
                                        data-parsley-maxlength="128" required="required">
                            </div> 
                            <div class="form-text mbl">
                                <label class="control-label" for="register_password2">确认密码    </label>
                                <input class="form-control input-lg" id="register_password2" type="password" 
                                        name="login_username" value="" placeholder="确认密码"
                                        data-parsley-required-message="请确认您的密码"
                                        data-parsley-type="email" data-parsley-maxlength="128" required="required">
                            </div>
                            <div class="form-text mbl">
                                <label class="control-label" for="contact">联系方式    </label>
                                <input class="form-control input-lg" id="contact" type="text" 
                                        name="contact" value="" placeholder="联系方式"
                                        data-parsley-required-message="请舒服联系方式"
                                        data-parsley-maxlength="128" required="required">
                            </div>
                            <div class="form-group mbl">
                                <label class="control-labelrequired"> 用户类型  </label>
                                <label class="checkbox-inline"><input type="radio" name="user_type" value="admin" data-parsley-multiple="type"
                                            data-parsley-errors-container="#checkbox-errors"
                                            data-parsley-required-message="请选择您的用户类型">管理员</label>
                                <label class="checkbox-inline"><input type="radio" name="user_type" value="normal" data-parsley-multiple="type" required
                                            >普通用户</label>
                            </div>
                            <div class="form-btn mbl" id="register_div">
                                <button type="submit" class="btn">注册</button>
                            </div>
                           <%=msg%>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>