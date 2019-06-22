<!DOCTYPE html>
<html>
    <head>
        <title>登录</title>
        <style>
            html, body {height:100%; width: 100%;}
            a:link {text-decoration: none; color:skyblue;}
            a:visited {color:brown;}
            a:hover {color:blue; text-decoration: underline;}
            .content-wrap {height:100%; width:100%;}
            .container {width:500px; height:400px; position: absolute; top:100px; left:420px; background: white;}
            .login-section {width:400px; margin:0 auto; padding:30px;}
            .form-text {margin:30px 0;}
            .active {display: inline-block; width:195px; height:60px; text-align: center;
                 padding-top:30px; font-size:1.5rem; font-family: 楷体;}
            .active:hover {background: #c0c0c0;}
            label {font-weight: bold; font-size: 1.5rempx; white-space: pre;}
            input[type="text"], input[type="password"] {width:250px; height:40px; border-radius: 5px;}
            input[type="text"]:focus {background: skyblue;}
            input[type="password"]:focus {background:springgreen;}
            .form-btn {width:400px; text-align: center;}
            .btn {color:white; background: cornflowerblue; border-radius: 10px; width:200px; height:40px;}
            .btn:hover {background: darkcyan; cursor: pointer;}
            .last {margin-top:20px; text-align: left;}
        </style>
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
                    <div class="login-main">
                        <form id="login-form" class="form-vertical" method="post"
                                action="login.jsp" data-parsley-validate="">
                            <div class="form-text mbl">
                                <label class="control-label" for="login_username">用户名    </label>
                                <input class="form-control input-lg" id="login_username" type="text" name="login_username"
                                        value="" placeholder="用户名"
                                        data-parsley-required-message="请输入您的用户名"
                                        data-parsley-type="email" data-parsley-maxlength="128" required="required">
                            </div>
                            <div class="form-text mbl">
                                <label class="control-label" for="login_password">   密码    </label>
                                <input class="form-control input-lg" id="login_password" type="password" name="password"
                                        value="" placeholder="密码"
                                        data-parsley-required-message="请输入您的登录密码"
                                        data-parsley-maxlength="128" required="required">
                            </div>                            
                            <div class="form-btn mbl" style="margin-top: 20px">
                                <button type="submit" class="btn">登录</button>
                            </div>
                        </form>
        
                        <div class="last">
                            <a href="reset.html">忘记密码</a>
                            <span class="text-muted mhs">|</span>
                            <span class="text-muted">没有账户</span>
                            <a href="register.html">注册</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>