<%@ page language="java" import="java.util.*,java.sql.*,java.util.ArrayList,java.util.List" 
         contentType="text/html; charset=utf-8"
%>

<!DOCTYPE HTML>
<html>
<head>
<title>二手书本信息</title>
</head>
<style>
   table{
          border-collapse: collapse;
          border: none;
          width: 50%;
          margin-left:25%;
   }
   td,th{
          border: solid grey 1px;            
          margin: 0 0 0 0;
          padding: 5px 5px 5px 5px 
  }
  td:nth-child(2*n){
    width:100px;
  }
  h1{
    text-align:center;
  }
  form {
    margin-left:30%;
  }
  a {
    text-decoration:none
  }

</style>
<body>
  <%  request.setCharacterEncoding("utf-8"); %>
  <div class="container">
  <% if(session.getAttribute("user_name")==null) {%>
  <a href="login_16337045.jsp">登录 </a>
  <a href="register_16337045.jsp">注册 </a>
  <% }else{ %>
  用户昵称：<%=session.getAttribute("user_name")%>
  <%}%>
	  <h1>二手书本信息</h1>  
    	<form action="bookList_16337045.jsp" method="post" name="f">
		    输入查询:<input id="query" name="query" type="text"
         value=<%=request.getParameter("query")==null?"":request.getParameter("query")%>>		                     
		    <input type="submit" name="sub" value="查询">
		    <br/><br/>
    	</form>
    <table>
    <tr>
      <td>id </td>
      <td>名称 </td>
      <td>价格(元) </td>
      <td>图片 </td>
      <td>操作 </td>
    </tr>  
    <% 	
     
      String param = request.getParameter("query")==null?"":request.getParameter("query");
     
      String msg ="";
      class BookInfo{
        private String id ;
        private String book_name;
        private String price ;
        private String img_url;

        public String getId(){
          return id;
        }
        public String getBookName() {
          return book_name;
        }
        public String getPrice() {
          return price;
        }
        public String getImgUrl() {
          return img_url;
        }

        public void setId(String id){
          this.id = id;
        }
        public void setBookName(String name){
          this.book_name = name;
        }
        public void setPrice(String price){
          this.price = price;
        }
        public void setImgUrl(String url) {
          this.img_url = url;
        }
      }
      List<BookInfo> bookList = new ArrayList<BookInfo>() ;
      int length =0;
      String connectString = "jdbc:mysql://172.18.187.6:3306/books_16337045" + "?autoReconnect=true&useUnicode=true" + "&characterEncoding=UTF-8"; 
      try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection(connectString, "user", "123");
        Statement stmt=con.createStatement();
        String sql = "select * from books where book_name like '%" + param + "%' or  description like '%"+param+"%'" ;
        ResultSet rs=stmt.executeQuery(sql);
        while(rs.next()) {
              BookInfo tmp = new BookInfo();
              tmp.setBookName(rs.getString("book_name"));
              tmp.setId(rs.getString("book_id"));
              tmp.setPrice(rs.getString("price"));
              tmp.setImgUrl(rs.getString("img_url"));
              bookList.add(tmp);
              length++;
        }
        rs.close();
        stmt.close();
        con.close();
        }
      
      catch (Exception e){
        msg = e.getMessage();
      }
        for(BookInfo item:bookList)
         {%>
          <tr>
          <td><%=item.getId()%> </td>
          <td><%=item.getBookName()%> </td>
          <td><%=item.getPrice()%> </td>
          <td><img src= "<%=item.getImgUrl()%>" style="width:80px;height:80px"/> </td>
          <td>
              <a href="bookShow_16337045.jsp?book_id=<%=item.getId()%>">查看详情 </a>
              <% if(session.getAttribute("user_type")!=null && "admin".equals(((String)session.getAttribute("user_type")).trim())){%>
              <a href="deleteBook_16337045.jsp?book_id=<%=item.getId()%>">删除</a>
              <%}%>
          </td>
          </tr>
    <%}
    %>
    </table>
    <%=msg%>
  </div>
  <a href=<%=session.getAttribute("user_name")==null?"login_16337045.jsp":"addBook_16337045.jsp"%>>新增</a>
</body>

</html>