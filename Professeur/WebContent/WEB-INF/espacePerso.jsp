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
    <link href="css/bootstrap-theme.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
    <link href="css/theme.css" rel="stylesheet">
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
	<!-- Header -->
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
			<img src="images/personne/<%=proprio.getIdentifiant()%>.jpg" title="<%=proprio.getIdentifiant()%>" width="30" height="30"  style="margin-top:-3px;margin-right:10px" />
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
	    <div >
		<ul class="nav nav-tabs">
		  <li role="presentation" class="active"><a href="Main?op=accederEspacePerso">Tableau de bord</a></li>
		  <li role="presentation"><a href="Main?op=les-membres-suivis">Mes suivis</a></li>
		  <li role="presentation"><a href="Main?op=Mes_annonces">Mes annonces</a></li>
		  <li role="presentation"><a href="Main?op=Mes_demandes_de_cours">Mes demandes</a></li>
		  <li role="presentation"><a href="Main?op=Profil">Profil</a></li>
		</ul>
		</div>
		<div class="jumbotron">
		<div class="row" >
				<div class="col-sm-6 col-md-4">
					<img src="images/personne/<%=proprio.getIdentifiant()%>.jpg"  title="<%=proprio.getNom()%>" width="220" height="220" class="photo" /> <br/>
					<b><%=proprio.getNom()%></b><br/>
					<a href="Main?op=Profil">Modifier le profil</a><br/>
					<a href="Main?op=profil_personne&id_personne=<%=proprio.getId()%>">voir le profil</a>
				</div>
				<div class="col-sm-6 col-md-8">
					<%Collection<Couple_AP> ap = (Collection<Couple_AP>) request.getAttribute("membres_qui_me_suivent");
					if(ap.isEmpty()){%>
						<h4>vous n'etes suivi-e dans aucune annonce</h4>
					<%}%>
					<%if(ap.size()==1){%>
					    <h4>vous etes suivi-e dans une annonce</h4> 
					<%} %>
					<%if (ap.size()>1){%>
						<h4>vous etes suivi-e dans <%=ap.size()%> annonces</h4>
					<%} %>
					<%Collection<Annonce> annonces2 = (Collection<Annonce>) request.getAttribute("annonces_que_je_suis");
					if(annonces2.isEmpty()){%>
						<h4>vous suivez aucune annonce</h4>
					<%}%>
					<%if(annonces2.size()==1){%>
					    <h4>vous suivez une annonce</h4> 
					<%} %>
					<%if (annonces2.size()>1){%>
						<h4>vous suivez <%=annonces2.size()%> annonces</h4>
					<%} %>
					<a href="Main?op=les-membres-suivis">Voir / modifier vos suivis</a><br />
					<a href="Main?op=Mes_annonces">Voir / modifier vos annonces</a><br />
					<a href="Main?op=deposerInitial">Ajouter une annonce</a>
				</div>
		</div>
		</div>
	</div><!--ferme container-->
	
	<!-- Footer -->
		<footer class="footer" id="footer">
      <div class="container">
         <p class="text-muted">Made by Hamza BOURBOUH, Oussama Markad, Ayoub Ratbi and Anca popescu</p>
      </div>
    </footer>
</body>
</html>
