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
	<title>Annonces</title>
	<!-- Bootstrap -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/sticky-footer.css" rel="stylesheet">

    <!-- Bootstrap theme -->
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
	<%Annonce annonce = (Annonce) request.getAttribute("annonce");%>
	<%Personne proprio =(Personne)session.getAttribute("proprio_annonce");%>
	<%Personne perConnecte =(Personne)session.getAttribute("Personne");%>
	<%String comment =(String)request.getAttribute("comment"); %>
	<%String voter =(String)request.getAttribute("voter"); %>	
	<%if(perConnecte==null) {%>
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
					<li><a href="#" data-toggle="modal" data-target="#singin">Se
							connecter</a></li>
					<li><a href="#" data-toggle="modal" data-target="#subscribe">S'inscrire</a></li>
					<li><a href="aide.html">Aide</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</nav>


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
							<button class="btn btn-lg btn-primary btn-block" type="submit">Se connecter</button>
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
								for="Nom" class="sr-only">Nom</label> <input type="Nom" id="Nom"
								name="nom" class="form-control" placeholder="Nom" required
								autofocus> <label for="Prenom" class="sr-only">Prénom</label>
							<input type="Prenom" id="Prenom" name="prenom"
								class="form-control" placeholder="Prenom" required autofocus>

							<label for="inputEmail" class="sr-only">l'adresse mail </label> <input
								type="email" id="inputEmail" name="email" class="form-control"
								placeholder="Email address" required autofocus> <label
								for="inputPhone" class="sr-only">Télephone</label> <input
								type="phone" id="inputphone" name="phone" class="form-control"
								placeholder="Phone" required autofocus> <label
								for="inputId" class="sr-only">Identifiant</label> <input
								type="identifiant" id="inputId" name="identifiant"
								class="form-control" placeholder="identifiant" required
								autofocus> <label for="inputPassword" class="sr-only">Mot
								de passe</label> <input type="password" id="inputPassword" name="mdp"
								class="form-control" placeholder="Password" required> <label
								for="inputConfirmationPassword" class="sr-only">Confirmation
								mot de passe</label> <input type="password"
								id="inputConfirmationPassword" name="confirmationMdp"
								class="form-control" placeholder="ConfirmationPassword" required>


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
							<button class="btn btn-lg btn-primary btn-block" type="submit">S'inscrire</button>
						</form>
					</div>
				</div>
			</div>
		</div>
		</header>
	<%if (comment.equals("false")) {%>
	<div id="main" class="container">
	<div class="alert alert-danger" role="alert">
			<b>Vous devez se connecter pour commenter une annonce!!</b>
		</div>
	</div>
	<%} %>
	<div id="main" class="container">
	<div>
	<div class="row" >
		<div class="col-sm-6 col-md-9">
			<h4><%=annonce.getTitre()%></h4><br/>
			<B>Ville =</B> <%=annonce.getVille().getNom()%><br/>
			<B>Type d'annonce :</B><%if(annonce.estOffre()){ %>Offre<% }else{%>Demande<%}%><br/>
			<B>Matière :</B><%=annonce.getMatiere().getNom()%><br/>
			<B>Prix : </B><%=annonce.getPrix()%><br/>
			<div class="seperateur"></div><br/>
			<B>Texte de l'annonce : </B><%=annonce.getMessage()%>
		</div>
		<div class="col-sm-6 col-md-3">
			<img src="images/personne/<%=proprio.getIdentifiant()%>.jpg"  title="<%=proprio.getNom()%>" width="220" height="220" class="photo" /> <br/>
			<h5><font size="5"><a href="Main?op=profil_personne&id_personne=<%=proprio.getId()%>"></a><%=proprio.getIdentifiant()%></font></h5>
			<a href="#" data-toggle="modal"  data-target="#signal"><font size="3">Signaler cette annonce</font></a><br/>
			<a href="#" data-toggle="modal" data-target="#send"><font size="3">Envoyer cette annonce</font></a>
		</div>
		<div class="col-sm-6 col-md-9">
			<div class="row" id="etoiles_avis">
			<div class="span3 etoiles_avis_vol" id="etoiles_avis1" >
				<B><FONT color="blue">avis générale(<%=annonce.getNbPersNotee() %> ont voté)</FONT></B><br />
				<%int note = (int) annonce.getNote();
				for(int i=0;i<note;i++){ %>
				<img src="images/picto-etoile-2.png" alt="*" />
				<%} 
				int n = 5-note;
				for(int j=0;j<n;j++){%>
				<img src="images/picto-etoile-0.png" alt="-" />
				<%} %>
			</div>
			</div>
			<a href="#" data-toggle="modal"  data-target="#vote"><u>voter cette annonce</u></a>
		<h2>Commentaires :</h2>
			<ul class="media-list">
				<%Collection<Commentaire> commentaires = (Collection<Commentaire>) request.getAttribute("commentaires");
					if(commentaires.isEmpty()){%>
						<a>Aucun commentaire jusqu'à maintenant soyez le premier</a>
					<%}%>
					<%if(!commentaires.isEmpty()){%>
							<%for(Commentaire c : commentaires){%>
							<li class="media">
								<a class="media-left" href="#">
								  <img src="images/personne/<%=c.getMembreEmetteur().getIdentifiant()%>.jpg" alt="<%=c.getMembreEmetteur().getNom()%>" width="120" height="120" class="photo"/><br/>
								  <%=c.getMembreEmetteur().getNom()%><br/>
								</a>
								<div class="media-body">
									<%=c.getCommentaire()%>
								   <br style="clear:both" /><br />
								</div>
							  </li>
							<%}%>
					<%}%>
			  
				<div class="media-body">
					<form method="post"  role="form" action="Main">
					<div class="row">
						<div class="6u">
						<textarea name="commentaire" id="commentaire" placeholder="commentaire" style="width: 500px;"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="12u">
						<input type="hidden" name="op" value="comment" />
						<input type="hidden" name="id_annonce" value="<%=annonce.getId()%>"/>
						<button class="btn btn-lg btn-primary btn-block" type="submit" style="width:200px;">Envoyer</button>
						</div>
					</div>
					</form>	
				</div>
			  </li>
			</ul>
		</div>
		<div class="col-sm-6 col-md-3">		
				<div id="annonces_similaires">
					<%Collection<Annonce> annonces = (Collection<Annonce>) request.getAttribute("annoncesSimilaires");
					int i = 1;
					if(!annonces.isEmpty()){%>
					<h5><font size="5">Annonces similaires</font></h5>
						<ul class="list-group" >
							<%for(Annonce an : annonces){%>
							<li class="list-group-item" style="background-color:#f1f1f1;">
								<!--<div class="row" >-->
								<!--<div class=" col-md-2">-->
									<img src="images/personne/<%= an.getProprio().getIdentifiant()%>.jpg" class="photo" 
									width="80" height="80" alt="<%=an.getTitre()%>" /><br />
								<!--</div>-->
								<!--<div class="col-md-4">-->
									<b class="titre" style="padding-top:20px"><%=an.getTitre()%><span style="font-size:13px"><br />
									Matière  = <%=an.getMatiere().getNom()%></span>
									</b><br />
									<a href="Main?op=detail&id_annonce=<%=an.getId()%>" class="btn btn-primary" style="margin-left:10px">Voir l'annonce</a>
								<!--</div>-->
								<!--</div>-->
							</li>
							<%}%>
						</ul>
						
					<%}%>
			</div>
		</div>
			<!-- Modal -->
		<div class="modal fade" id="signal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"> </button>
					<h3>Signaler cette annonce</h3>
			 </div>
				<div class="modal-body">
					<form method="post" class="form-signin" role="form" action="Main">
						<a name="envoie"> </a>
						<p>Décrivez le problème constaté sur cette annonce</p>
						<p><select  name="id_raison" id="id_raison" style=" width : 218px;">
							<option value="3">Contenus illegaux ou inconvenants</option>
							<option value="4">Coordonnées</option>
							<option value="6">Doublon</option>
							<option value="1">Photo de mauvaise qualité</option>
							<option value="5">Spam</option>
							<option value="2">Texte incompréhensible</option>
							<option value="7">Autre</option>
							</select>
						</p>
						<p><textarea name="texte" id="texte" placeholder="Problème" cols="50" rows="6" style="width: 400px;"></textarea></p><br/>
						<input type="hidden" name="op" value="signaler" />
						<input type="hidden" name="id_annonce" value="<%=annonce.getId()%>"/>
						<p><input name="signaler" type="submit" class="bn_modal pull-right" value="Envoyer" /></p>
						<p></p>
					</form>	
				</div>
				<div class="modal-footer">
				<p></p>
				</div>
			  </div>
			</div>
		  </div>
		</div>

		<div class="modal fade" id="send" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="myModalLabel">Envoyer Cette annonce</h4>
			  </div>
			  <div class="modal-body">
					<form method="post" class="form-signin" role="form" action="Main">
					<input type="hidden" name="op" value="send"/>
					<input type="hidden" name="id_annonce" value="<%=annonce.getId()%>"/>
					<label for="email" class="sr-only">Email</label>
					<input type="email" id="email" name="email" class="form-control" placeholder="email" required autofocus>
					<button class="btn  btn-primary btn-block pull-right" type="submit">Envoyer</button>
				  </form>
			  </div>
			  <div class="modal-footer">
				<p></p>
				</div>
			</div>
		  </div>
		</div>
		</div>
	</div>
	</div>
	</div>
	<!-- Modal -->
		<div class="modal fade" id="vote" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <h3> Vous devez se connecter pour voter une annonce</h3>
			  
				<div class="modal-footer">
				<p></p>
				</div>
			  </div>
			</div>
		  </div>
		</div>
		
<%} else { %>
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
			<img src="images/personne/<%= perConnecte.getIdentifiant()%>.jpg" title="<%=perConnecte.getIdentifiant()%>" width="30" height="30"  style="margin-top:-3px;margin-right:10px" />
			<%=perConnecte.getIdentifiant()%><span class="caret"></span>
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
	<div class="row" >
		<div class="col-sm-6 col-md-9">
			<h4><%=annonce.getTitre()%></h4><br/>
			<B>Ville :</B> <%=annonce.getVille().getNom()%><br/>
			<B>Type d'annonce :</B><%if(annonce.estOffre()){ %>Offre<% }else{%>Demande<%}%><br/>
			<B>Matière :</B><%=annonce.getMatiere().getNom()%><br/>
			<B>Prix : </B><%=annonce.getPrix()+"€ "%><br/>
			<div class="seperateur"></div><br/>
			<B>Texte de l'annonce : </B><%=annonce.getMessage()%>
		</div>
		<div class="col-sm-6 col-md-3">
			<img src="images/personne/<%=proprio.getIdentifiant()%>.jpg"  title="<%=proprio.getNom()%>" width="220" height="220" class="photo" /> <br/>
			<h5><font size="5"><a href="Main?op=profil_personne&id_personne=<%=proprio.getId()%>"><%=proprio.getIdentifiant()%></a></font></h5>
			<a href="Main?op=follow&id_annonce=<%=annonce.getId()%>"><font size="3">Suivre ce professeur</font></a><br/>
			<a href="#" data-toggle="modal"  data-target="#signal"><font size="3">Signaler cette annonce</font></a><br/>
			<a href="#" data-toggle="modal" data-target="#send"><font size="3">Envoyer cette annonce</font></a>
		</div>
		<div class="col-sm-6 col-md-9">
			<div class="row" id="etoiles_avis">
			<div class="span3 etoiles_avis_vol" id="etoiles_avis1" >
				<B><FONT color="blue">avis générale(<%=annonce.getNbPersNotee() %> ont voté)</FONT></B><br />
				<%int note = (int) annonce.getNote();
				for(int i=0;i<note;i++){ %>
				<img src="images/picto-etoile-2.png" alt="*" />
				<%} 
				int n = 5-note;
				for(int j=0;j<n;j++){%>
				<img src="images/picto-etoile-0.png" alt="-" />
				<%} %>
			</div>
			</div>
			<a href="#" data-toggle="modal"  data-target="#vote"><u>voter cette annonce</u></a>
		<h2>Commentaires :</h2>
			<ul class="media-list">
				<%Collection<Commentaire> commentaires = (Collection<Commentaire>) request.getAttribute("commentaires");
					if(commentaires.isEmpty()){%>
						<a>Aucun commentaire jusqu'à maintenant soyez le premier</a>
					<%}%>
					<%if(!commentaires.isEmpty()){%>
							<%for(Commentaire c : commentaires){%>
							<li class="media">
								<a class="media-left" href="#">
								  <img src="images/personne/<%=c.getMembreEmetteur().getIdentifiant()%>.jpg" alt="<%=c.getMembreEmetteur().getNom()%>" width="120" height="120" class="photo"/><br/>
								  <%=c.getMembreEmetteur().getNom()%><br/>
								</a>
								<div class="media-body">
									<%=c.getCommentaire()%>
								   <br style="clear:both" /><br />
								</div>
							  </li>
							<%}%>
					<%}%>
			  
			  <li class="media">
				<a class="media-left" href="#">
				  <img src="images/personne/<%= perConnecte.getIdentifiant()%>.jpg" alt="<%=perConnecte.getNom()%>" width="120" height="120" class="photo"/><br/>
				  <%=perConnecte.getNom()%><br/>
				</a>
				<div class="media-body">
					<form method="post"  role="form" action="Main">
					<div class="row">
						<div class="6u">
						<textarea name="commentaire" id="commentaire" placeholder="commentaire" style="width: 500px;"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="12u">
						<input type="hidden" name="op" value="comment" />
						<input type="hidden" name="id_annonce" value="<%=annonce.getId()%>"/>
						<button class="btn btn-lg btn-primary btn-block" type="submit" style="width:200px;">Envoyer</button>
						</div>
					</div>
					</form>	
				</div>
			  </li>
			</ul>
		</div>
		<div class="col-sm-6 col-md-3">		
				<div id="annonces_similaires">
					<%Collection<Annonce> annonces = (Collection<Annonce>) request.getAttribute("annoncesSimilaires");
					int i = 1;
					if(!annonces.isEmpty()){%>
					<h5><font size="5">Annonces similaires</font></h5>
						<ul class="list-group" >
							<%for(Annonce an : annonces){%>
							<li class="list-group-item" style="background-color:#f1f1f1;">
								<!--<div class="row" >-->
								<!--<div class=" col-md-2">-->
									<img src="images/personne/<%= an.getProprio().getIdentifiant()%>.jpg" class="photo" 
									width="80" height="80" alt="<%=an.getTitre()%>" /><br />
								<!--</div>-->
								<!--<div class="col-md-4">-->
									<b class="titre" style="padding-top:20px"><%=an.getTitre()%><span style="font-size:13px"><br />
									Matière  = <%=an.getMatiere().getNom()%></span>
									</b><br />
									<a href="Main?op=detail&id_annonce=<%=an.getId()%>" class="btn btn-primary" style="margin-left:10px">Voir l'annonce</a>
								<!--</div>-->
								<!--</div>-->
							</li>
							<%}%>
						</ul>
						
					<%}%>
			</div>
		</div>
			<!-- Modal -->
		<div class="modal fade" id="signal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"> </button>
					<h3>Signaler cette annonce</h3>
			 </div>
				<div class="modal-body">
					<form method="post" class="form-signin" role="form" action="Main">
						<a name="envoie"> </a>
						<p>Décrivez le problème constaté sur cette annonce</p>
						<p><select  name="id_raison" id="id_raison" style=" width : 218px;">
							<option value="3">Contenus illegaux ou inconvenants</option>
							<option value="4">Coordonnées</option>
							<option value="6">Doublon</option>
							<option value="1">Photo de mauvaise qualité</option>
							<option value="5">Spam</option>
							<option value="2">Texte incompréhensible</option>
							<option value="7">Autre</option>
							</select>
						</p>
						<p><textarea name="texte" id="texte" placeholder="Problème" cols="50" rows="6" style="width: 400px;"></textarea></p><br/>
						<input type="hidden" name="op" value="signaler" />
						<input type="hidden" name="id_annonce" value="<%=annonce.getId()%>"/>
						<p><input name="signaler" type="submit" class="bn_modal pull-right" value="Envoyer" /></p>
						<p></p>
					</form>	
				</div>
				<div class="modal-footer">
				<p></p>
				</div>
			  </div>
			</div>
		  </div>
		</div>

		<div class="modal fade" id="send" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="myModalLabel">Envoyer Cette annonce</h4>
			  </div>
			  <div class="modal-body">
					<form method="post" class="form-signin" role="form" action="Main">
					<input type="hidden" name="op" value="send"/>
					<input type="hidden" name="id_annonce" value="<%=annonce.getId()%>"/>
					<label for="email" class="sr-only">Email</label>
					<input type="email" id="email" name="email" class="form-control" placeholder="email" required autofocus>
					<button class="btn  btn-primary btn-block pull-right" type="submit">Envoyer</button>
				  </form>
			  </div>
			  <div class="modal-footer">
				<p></p>
				</div>
			</div>
		  </div>
		</div>
		</div>
	</div>
	</div>
	</div>
	<!-- Modal -->
		<%if (voter=="false") { %>
		<div class="modal fade" id="vote" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
			<div class="modal-content">
				<h3> Vous avez déjà voté cette annonce</h3>
			</div>
			</div>
		</div>
		<%} else { %>
		<div class="modal fade" id="vote" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"> </button>
					<h3>Voter cette annonce</h3>
			 </div>
				<div class="modal-body">
					<form method="post" class="form-signin" role="form" action="Main">
						<a name="envoie"> </a>
						<p>Donner une note entre 1 à 5:</p>
						<div class="input-group">
					      <span class="input-group-addon">
					       <input id="1" type="radio" name="note" value="1"
							checked="checked"/>
					      </span>
					      <label for="1">tres insuffisant</label>
					    </div><!-- /input-group -->
					    <div class="input-group">
					      <span class="input-group-addon">
					       <input id="2" type="radio" name="note" value="2"/>
					      </span>
					      <label for="2">insuffisant</label>
					    </div><!-- /input-group -->
					    <div class="input-group">
					      <span class="input-group-addon">
					       <input id="3" type="radio" name="note" value="3"/>
					      </span>
					      <label for="3">passable</label>
					    </div><!-- /input-group -->
					    <div class="input-group">
					      <span class="input-group-addon">
					        <input id="4" type="radio" name="note" value="4"/>
					      </span>
					      <label for="4">bien</label>
					    </div><!-- /input-group -->
					    <div class="input-group">
					      <span class="input-group-addon">
					       <input id="5" type="radio" name="note" value="5"/>
					      </span>
					      <label for="5">tres bien</label>
					    </div><!-- /input-group -->
						<input type="hidden" name="op" value="voter" />
						<input type="hidden" name="id_annonce" value="<%=annonce.getId()%>"/>
						<p><input name="signaler" type="submit" class="bn_modal pull-right" value="Envoyer" /></p>
						<p></p>
					</form>	
				</div>
				<div class="modal-footer">
				<p></p>
				</div>
			  </div>
			</div>
		  </div>
		<%} %>
<%} %>
<footer class="footer" id="footer">
      <div class="container">
         <p class="text-muted">Made by Hamza BOURBOUH, Oussama Markad, Ayoub Ratbi and Anca popescu</p>
      </div>
    </footer>
</body>

</html>
