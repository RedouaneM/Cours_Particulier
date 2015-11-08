<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,ejb.*, home.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Mon Espace Personnel</title>
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/sticky-footer.css" rel="stylesheet">
<!-- Bootstrap theme -->
    <link href="css/bootstrap-theme.min.css" rel="stylesheet">
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
	<%Personne proprio =(Personne)session.getAttribute("Personne");%>
	<!-- Header -->
	<header id="header" class="container">
	 <nav class="navbar navbar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target=".navbar-collapse">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="Main?op=indexSession">Accueil</a>
	</div>
	<div class="navbar-collapse collapse">
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
			<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
			<img src="images/personne/<%= proprio.getIdentifiant()%>.jpg" title="<%=proprio.getIdentifiant()%>" width="30" height="30"  style="margin-top:-3px;margin-right:10px" />
			<%=proprio.getIdentifiant()%><span class="caret"></span>
			</a>
			<ul class="dropdown-menu" role="menu">
			<li><a href="Main?op=accederEspacePerso">Tableau de bord</a></li>
			<li ><a href="Main?op=les-membres-suivis">Mes suivis</a></li>
			 <li ><a href="Main?op=Mes_annonces">Mes annonces</a></li>
			 <li ><a href="Main?op=Mes_demandes_de_cours">Mes demandes de cours</a></li>
			 <li ><a href="Main?op=Profil">Profil</a></li>
			<li><a href="Main?op=deposerInitial">Ajouter une annonce</a></li>
			<li><a  href="Main?op=sedeconnecter">Déconnexion</a></li>
			</ul></li>
			<li><a href="aide.html">Aide</a></li>
		</ul>
	</div>
	<!--/.nav-collapse -->
	 </nav> 
	 </header>
	<div id="main" class="container">
	    <div>
		<ul class="nav nav-tabs">
		  <li role="presentation"><a href="Main?op=accederEspacePerso">Tableau de bord</a></li>
		  <li role="presentation"><a href="Main?op=les-membres-suivis">Mes suivis</a></li>
		  <li role="presentation"  class="active"><a href="Main?op=Mes_annonces">Mes annonces</a></li>
		  <li role="presentation"><a href="Main?op=Mes_demandes_de_cours">Mes demandes</a></li>
		  <li role="presentation"><a href="Main?op=Profil">Profil</a></li>
		</ul>
		</div>
		<div class="jumbotron">
			<p></p>
			<%Collection<Annonce> annonces = (Collection<Annonce>) request.getAttribute("annonces");
			int i = 1;
				if(annonces.isEmpty()){%>
					<a>vous avez aucune Offre</a>
				<%}%>
				<%if(!annonces.isEmpty()){%>
					<ul class="list-group">
						<%for(Annonce an : annonces){%>
						<li class="list-group-item" style="background-color:#f1f1f1;">
							<div class="row" >
							<div class="2u">
								<a class="image fit"><img src="images/personne/<%= proprio.getIdentifiant()%>.jpg" /></a>
							</div>
							<div class="10u">
								<b class="titre" style="padding-top:20px"><%=an.getTitre()%><span style="font-size:13px"><br />
								<B>Matière  :</B> <%=an.getMatiere().getNom()%></span>
								</b><br />
								<a href="Main?op=gerer_annonce&id_annonce=<%=an.getId()%>" class="btn btn-primary">Gérer l'annonce</a>
								<a href="Main?op=detail&id_annonce=<%=an.getId()%>" class="btn btn-primary">Voir l'annonce</a>
								<a href="Main?op=supprimerOffre&id_annonce=<%=an.getId()%>&url=tableau-de-bord_mes_annonces" class="btn btn-primary">supprimer l'annonce</a>
							</div>
							</div>
						</li><div><p></p></div>
						<%}%>
					</ul>
				<%}%>
				<div class="row" >
				<div class="12u">
				<a href="Main?op=deposerInitial"  class="btn btn-primary pull-right">Ajouter une annonce</a>
				</div>
				</div>
		</div>
	</div><!--ferme container-->
	<footer class="footer" id="footer">
      <div class="container">
         <p class="text-muted">Made by Hamza BOURBOUH, Oussama Markad, Ayoub Ratbi and Anca popescu</p>
      </div>
    </footer>
</body>
</html>
