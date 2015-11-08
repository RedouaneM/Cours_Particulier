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
<title>AfficherAnnonces</title>

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
		<header id="header" class="container">
	<%
		Personne proprio = (Personne) session.getAttribute("Personne");
		if (proprio == null) {
	%>
	<!-- Header -->

		<nav class="navbar navbar-default">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.jsp">Accueil</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#" data-toggle="modal" data-target="#singin">Se
							connecter</a></li>
					<li><a href="#" data-toggle="modal" data-target="#subscribe">S'inscrire</a></li>
					<li><a href="#" data-toggle="modal" data-target="#pays">Changer pays</a></li>
					<li><a href="aide.html">Aide</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</nav>
		<%} else {%>
		<!-- Header -->
			<nav class="navbar navbar-default">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="Main?op=index">Accueil</a>
				</div>
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false"> <img
								src="images/personne/<%=proprio.getIdentifiant()%>.jpg"
								title="<%=proprio.getIdentifiant()%>" width="30" height="30"
								style="margin-top: -3px; margin-right: 10px" /> <%=proprio.getIdentifiant()%><span
								class="caret"></span>
						</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="Main?op=accederEspacePerso">Tableau de
										bord</a></li>
								<li><a href="Main?op=Mes_annonces">Mes annonces</a></li>
								<li><a href="Main?op=Mes_demandes_de_cours">Mes
										demandes de cours</a></li>
								<li><a href="Main?op=Profil">Profil</a></li>
								<li><a href="Main?op=deposerInitial">Ajouter une
										annonce</a></li>
								<li><a href="Main?op=sedeconnecter">Déconnexion</a></li>
							</ul></li>
						<li><a href="#" data-toggle="modal" data-target="#pays">Changer
								pays</a></li>
						<li><a href="aide.html">Aide</a></li>

					</ul>
				</div>
			</nav>
			<% }%>

			
			
			<div class="modal fade" id="pays" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">Choose your
								Country</h4>
						</div>
						<div class="modal-body">
							<sql:query dataSource="${snapshot}" var="pays">
						SELECT * from Pays;
					</sql:query>
							<form method="post" class="form-signin" role="form" action="Main">
								<input type="hidden" name="op" value="changer_pays" /> <input
									type="hidden" name="url" value="/index.jsp" />
								<select id="pays" name="pays" style="width: 218px;"
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
			<!-- Modal -->
			<div class="modal fade" id="singin" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">Connectez vous</h4>
						</div>
						<div class="modal-body">
							<form method="post" class="form-signin" role="form" action="Main">
								<input type="hidden" name="op" value="seconnecter" /> <label
									for="inputId" class="sr-only">identifiant</label> <input
									type="identifiant" id="inputId" name="identifiant"
									class="form-control" placeholder="Identifiant" required
									autofocus> <label for="inputPassword" class="sr-only">mot
									de passe</label> <input type="password" id="inputPassword" name="mdp"
									class="form-control" placeholder="Mot de passe" required>

								<div class="checkbox">
									<label> <input type="checkbox" name="remember"
										value="remember-me"> Remember me
									</label>
								</div>
								<button class="btn btn-lg btn-primary btn-block" type="submit">Se
									connecter</button>
								<a href="#" data-toggle="modal" data-target="#subscribe">Inscrivez
									vous</a>
							</form>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal -->
			<div class="modal fade" id="subscribe" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">
								<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title" id="myModalLabel">S'inscrire sur
								Notre Site</h4>
						</div>
						<div class="modal-body">
							<form method="post" class="form-signin" role="form" action="Main"
								enctype="multipart/form-data">
								<input type="hidden" name="op" value="s'inscrire" /> <label
									for="Nom" class="sr-only">Nom</label> <input type="Nom"
									id="Nom" name="nom" class="form-control" placeholder="Nom"
									required autofocus> <label for="Prenom" class="sr-only">Prénom</label>
								<input type="Prenom" id="Prenom" name="prenom"
									class="form-control" placeholder="Prenom" required autofocus>

								<label for="inputEmail" class="sr-only">l'adresse mail </label>
								<input type="email" id="inputEmail" name="email"
									class="form-control" placeholder="Email address" required
									autofocus> <label for="inputPhone" class="sr-only">Télephone</label>
								<input type="phone" id="inputphone" name="phone"
									class="form-control" placeholder="Phone" required autofocus>
								<label for="inputId" class="sr-only">Identifiant</label> <input
									type="identifiant" id="inputId" name="identifiant"
									class="form-control" placeholder="identifiant" required
									autofocus> <label for="inputPassword" class="sr-only">Mot
									de passe</label> <input type="password" id="inputPassword" name="mdp"
									class="form-control" placeholder="Password" required> <label
									for="inputConfirmationPassword" class="sr-only">Confirmation
									mot de passe</label> <input type="password"
									id="inputConfirmationPassword" name="confirmationMdp"
									class="form-control" placeholder="ConfirmationPassword"
									required>


								<div class="container">
									<div class="radio">
										<input id="Male" type="radio" name="type" value="s"
											checked="checked" /> <label for="Male">Male</label>
									</div>
									<div class="radio">
										<input id="rk" type="radio" name="type" value="k"
											onclick="typeChanged('k', 'dprice', 'lprice', 'category', 'company_ad');" />
										<label for="rk">Female</label>
									</div>
								</div>
								<div class="labelform">
								<label>Photo&nbsp;principale:</label>
							</div>
							<div class="image_box" id="image_box_0">
								<input type="file" name="imagePersonne" 
									class="photosup_input_file upload_input" id="imagePersonne"
									accept="image/bmp,image/gif,image/png,image/jpeg,image/x-ms-bmp" />
							</div>
								<button class="btn btn-lg btn-primary btn-block" type="submit">S'inscrire</button>
							</form>
						</div>
					</div>
				</div>
			</div>
</header>
<div id="main" class="container">
				<h2>Faire votre recherche dans notre site</h2>
				<sql:query dataSource="${snapshot}" var="matiere">
												SELECT * from Matiere;
										</sql:query>
				<form method="post" action="Main">
					<div>

						<input type="hidden" name="op" value="rechercher">
						<div class="row">
							<div class="6u">
								<select id="matiere" name="matiere">
									<c:forEach var="row" items="${matiere.rows}">
										<option value="${row.id}">${row.nom}</option>
									</c:forEach>
								</select>
							</div>
							<div class="6u">
								<select id="villes" name="villes">
									<c:forEach var="row" items="${villes.rows}">
										<option value="${row.id}">${row.nom}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="6u">
								Entre <input type="text" id="prix_min" name="prix_min"
									placeholder="prix min" />
							</div>
							<div class="6u">
								et <input type="text" id="prix_max" name="prix_max"
									placeholder="prix max" />
							</div>
						</div>
						<button class="btn btn-lg btn-primary btn-block" type="submit"
							style="width: 200px;">Rechercher</button>
					</div>
				</form>
					<%
							Collection<Annonce> annonces = (Collection<Annonce>) request
										.getAttribute("annonces");
								if (annonces.isEmpty()) {
						%>
					<h2>Votre recherche ne correspond à aucune annonce !!</h2>
					<%
							} else {
						%>
					<h2>Voici les annonces disponibles :</h2>
					<ul class="list-group">
					<%
							for (Annonce a : annonces) {
						%>
					<li class="list-group-item" style="background-color:#f1f1f1;">
							<div class="row" >
							<div class="row">
								<div class="2u">
									<a class="image fit"><img
										src="images/personne/<%= a.getProprio().getIdentifiant()%>.jpg" /></a>
								</div>
								<div class="10u">
									<b class="titre" style="padding-top: 20px"><%=a.getTitre()%><span
										style="font-size: 13px"><br /> Matière = <%=a.getMatiere().getNom()%></span>
									</b><br /> <a href="Main?op=detail&id_annonce=<%=a.getId()%>"
										class="btn btn-primary">Voir l'annonce</a>
								</div>
							</div>
					</div>
					</li><div><p></p></div>
					<%}%>
					</ul>
					<%}%>
</div>
				
	<footer class="footer" id="footer">
		<div class="container">
			<p class="text-muted">Made by Hamza BOURBOUH, Oussama Markad,
				Ayoub Ratbi and Anca popescu</p>
		</div>
	</footer>
</body>
</html>