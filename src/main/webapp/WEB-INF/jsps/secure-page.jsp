<%@page pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  </head>
  <body class="container py-4">
  
    <div class="row">
      <div class="col">
        <h1><c:out value="Secure Page" /></h1>
        <p>This page requires an authenticated user.</p>
      </div>
    </div>
    
    <div class="row">
      <div class="col">
        <h2>Authenticated User</h2>
        <p>This is the authenticated user principal object.</p>
        <pre><c:out value="${pageContext.request.userPrincipal}"/></pre>
      </div>
    </div>
    
  </body>
</html>
