<%@ page language="java" import="java.sql.*" 
         contentType="text/html; charset=utf-8"
%>
<%@ page import="java.io.*, java.util.*,java.util.Date,org.apache.commons.io.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<!DOCTYPE HTML>
<html>
<head>
  <title>新增图书记录</title>
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
if (request.getMethod().equalsIgnoreCase("post")){ 
   boolean isMultipart = ServletFileUpload.isMultipartContent(request);//是否用multipart提交的?
    String savePlace = "";
    String img_url = "";
    String book_name = "";
    String price = "";
    String description = "";
    if (isMultipart) {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List items = upload.parseRequest(request);
        for (int i = 0; i < items.size(); i++) {
            FileItem fi = (FileItem) items.get(i);
            if (fi.isFormField()) {//如果是表单字段
                if(fi.getFieldName().trim().equals("book_name")){
                  book_name = fi.getString("utf-8");
                }
                if(fi.getFieldName().trim().equals("price")){
                  price = fi.getString("utf-8");
                }
                if(fi.getFieldName().trim().equals("description")){
                  description = fi.getString("utf-8");
                }
            }
            else {//如果是文件
                DiskFileItem dfi = (DiskFileItem) fi;
                if (!dfi.getName().trim().equals("")) {//getName()返回文件名称或空串
                    Date date = new Date();
                    String timestamp = String.valueOf(date.getTime()); 
                    String fileName = timestamp + FilenameUtils.getName(dfi.getName());
                    savePlace = application.getRealPath("temp/") + fileName ;
                    dfi.write(new File(savePlace));
                    img_url = "http://172.18.187.6:8080/testjsp/temp/" + fileName;
                } //if
            } //if
        } //for
    } //if

    String connectString = "jdbc:mysql://172.18.187.6:3306/books_16337045"
              + "?autoReconnect=true&useUnicode=true"
              + "&characterEncoding=UTF-8"; 
    try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection con=DriverManager.getConnection(connectString, 
                        "user", "123");
      Statement stmt=con.createStatement();
      String fmt = "insert into books (book_name,price,img_url,description) values('%s','%s','%s','%s')";
      String sql = String.format(fmt,book_name,price,img_url,description);
      int rs = stmt.executeUpdate(sql);
      if(rs>0){msg = "添加成功！";}
      stmt.close();
      con.close();
    }catch(Exception e) {
      msg = e.getMessage();
    }
}%>
  <div class="container">
	<h1>新增图书记录</h1>
	<form action="addBook_16337045.jsp" method="post" name="f" enctype="multipart/form-data">
		书本名字：<input id="book_name" name="book_name" type="text" >
		                     <br/><br/>
		价格(元)：<input id="price" type="text" name="price" >
		                     <br/><br/>
    书本描述：<input id="description" type="text" name="description" >
		                     <br/><br/>
    上传图片：<input id="img" type="file" name="img" >
		                     <br/><br/>
		<input type="submit" name="sub" value="保存">
		                     <br/><br/>
	</form>
  <%=msg%>
	<br/><br/>
	<%-- <a href='browserStu_16337045.jsp'>返回</a> --%>
  </div>
</body>
</html>

