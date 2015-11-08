<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,ejb.*, home.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>s'inscrire</title>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/sticky-footer.css" rel="stylesheet">
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/skel.min.js"></script>
<script src="js/init.js"></script>
<noscript>
	<link rel="stylesheet" href="css/skel.css" />
	<link rel="stylesheet" href="css/style.css" />
	<link rel="stylesheet" href="css/style-desktop.css" />
	<link rel="stylesheet" href="css/style-noscript.css" />
</noscript>
</head>
<body>
	<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost/mondial" user="root" password="ostermann" />
	<%
		String p = (String) session.getAttribute("pays");
	%>
	<sql:query dataSource="${snapshot}" var="villes">
		SELECT * from Ville where pays='<%=p%>';
	</sql:query>
	<!-- Header -->
	<header id="header" class="container">
		<nav class="navbar navbar-default">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="Main?op=indexSession">Accueil</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#" data-toggle="modal" data-target="#pays">Changer
							pays</a></li>
					<li><a href="aide.html">Aide</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</nav>


	<!-- Modal -->
		<div class="modal fade" id="pays" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Choose your Country</h4>
					</div>
					<div class="modal-body">
						<sql:query dataSource="${snapshot}" var="pays">
						SELECT * from Pays;
					</sql:query>
						<form method="post" class="form-signin" role="form" action="Main">
							<input type="hidden" name="op" value="changer_pays" /> <input
								type="hidden" name="url" value="/index.jsp" /> <select id="pays"
								name="pays" style="width: 218px;"
								onchange="fillOptions('villes', this)">
								<c:forEach var="row" items="${pays.rows}">
									<option value="${row.code}">${row.nom}</option>
								</c:forEach>
							</select> <input type="submit" value="go" style="width: 168px;">
						</form>
					</div>
				</div>
			</div>
		</div>
	</header>
	<div id="main" class="container">
	<%if(request.getAttribute("erreurs")!=null){
				Collection<String> erreurs =(Collection<String>) request.getAttribute("erreurs");
				if(!erreurs.isEmpty()){%>
				<div class="alert alert-danger" role="alert">
				<b>Erreur !</b><%
					for(String erreur : erreurs){
						%><p>-<%=erreur%></p><%
					}
					}%>
					</div>
				<%}%>
			


		</div>
	<div id="main" class="container">
		<form method="post" action="Main" name="formular">
			<input type="hidden" name="op" value="s'inscrire" /> <label for="Nom"
			class="sr-only">Nom</label> <input type="Nom" id="Nom" name="nom"
			class="form-control" placeholder="Nom" required autofocus
			value="<%=request.getAttribute("nom")%>"> 
		<p></p>
		<label for="Prenom" class="sr-only">Prénom</label> <input
			type="Prenom" id="Prenom" name="prenom" class="form-control"
			placeholder="Prénom" required autofocus
			value="<%=request.getAttribute("prenom")%>">
		<p></p>
		<label for="inputPhone" class="sr-only">Télephone</label> <input
			type="phone" id="inputphone" name="phone" class="form-control"
			placeholder="Télephone" required autofocus
			value="<%=request.getAttribute("phone")%>">
		<p></p>
		<label for="inputId" class="sr-only">Identifiant</label> <input
			type="identifiant" id="inputId" name="identifiant"
			class="form-control" placeholder="identifiant" required autofocus
			value="<%=request.getAttribute("identifiant")%>">
		<p></p>
		<label for="inputEmail" class="sr-only">l'adresse mail </label> <input
			type="email" id="inputEmail" name="email" class="form-control"
			placeholder="L'adresse mail" required autofocus
			value="<%if(request.getAttribute("email")!=null)request.getAttribute("email");%>">
		<p></p>
		<label for="inputPassword" class="sr-only">Mot de passe</label> <input
			type="password" id="inputPassword" name="mdp" class="form-control"
			placeholder="Mot de passe" required>
		<p></p>
		<label for="inputConfirmationPassword" class="sr-only">Confirmation
			mot de passe</label> <input type="password" id="inputConfirmationPassword"
			name="confirmationMdp" class="form-control"
			placeholder="Confirmation mot de passe" required>
		<p></p>

		<div class="container">
			<div class="radio">
				<input id="Male" type="radio" name="type" value="s"
					checked="checked" /> <label for="Male">Homme</label>
			</div>
			<div class="radio">
				<input id="rk" type="radio" name="type" value="k"
					onclick="typeChanged('k', 'dprice', 'lprice', 'category', 'company_ad');" />
				<label for="rk">Femme</label>
			</div>
		</div>
		<div class="labelform">
			<label>Photo&nbsp;principale:</label>
		</div>
		<div class="image_box" id="image_box_0">
			<input type="file" name="imagePersonne" "
				class="photosup_input_file upload_input" id="imagePersonne"
				accept="image/bmp,image/gif,image/png,image/jpeg,image/x-ms-bmp" />
		</div>
		<p></p>
		<button class="btn btn-lg btn-primary btn-block" type="submit" style="width:200px;">S'inscrire</button>
		</form>
	</div>
	<footer class="footer" id="footer">
      <div class="container">
         <p class="text-muted">Made by Hamza BOURBOUH, Oussama Markad, Ayoub Ratbi and Anca popescu</p>
      </div>
    </footer>
</body>
</html>
