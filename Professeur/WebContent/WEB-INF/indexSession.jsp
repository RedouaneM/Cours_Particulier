<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,ejb.*, home.*" %>
 <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Page d'accueil</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
	 <link href="css/sticky-footer.css" rel="stylesheet">
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
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
     url="jdbc:mysql://localhost/mondial"
     user="root"  password="ostermann"/>
      	<%String p = (String) session.getAttribute("pays");%>
  	  <sql:query dataSource="${snapshot}" var="villes">
		SELECT * from Ville where pays='<%=p%>';
	</sql:query>
	
		<!-- Header -->
		<%Personne per =(Personne)session.getAttribute("Personne");%>
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
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" >
					<img src="images/personne/<%= per.getIdentifiant()%>.jpg" title="<%=per.getIdentifiant()%>" width="30" height="30"  style="margin-top:-3px;margin-right:10px" />
					<%=per.getIdentifiant()%><span class="caret"></span>
					</a>
					<ul class="dropdown-menu" >
					<li><a href="Main?op=accederEspacePerso">Tableau de bord</a></li>
					<li ><a href="Main?op=les-membres-suivis">Mes suivis</a></li>
					 <li ><a href="Main?op=Mes_annonces">Mes annonces</a></li>
					 <li ><a href="Main?op=Mes_demandes_de_cours">Mes demandes de cours</a></li>
					 <li ><a href="Main?op=Profil">Profil</a></li>
					<li><a href="Main?op=deposerInitial">Ajouter une annonce</a></li>
					<li><a  href="Main?op=sedeconnecter">Déconnexion</a></li>
					</ul>
				</li>
				<li><a href="#" data-toggle="modal" data-target="#pays">Changer pays</a></li> 
				<li><a  href="aide.html">Aide</a></li>
            </ul>
          </div><!--/.nav-collapse -->
      </nav>
      <div class="modal fade" id="pays" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title" id="myModalLabel">Choose your Country</h4>
			  </div>
			  <div class="modal-body">
			  		 <sql:query dataSource="${snapshot}" var="pays">
						SELECT * from Pays;
					</sql:query>
					<form method="post" class="form-signin" role="form" action="Main">
					<input type="hidden" name="op" value="changer_pays"/>
					<input type="hidden" name="url" value="/WEB-INF/indexSession.jsp"/>
					<select  id="pays" name="pays" style=" width : 218px;" onchange="fillOptions('villes', this)">
						<c:forEach var="row" items="${pays.rows}">
							<option value="${row.code}">${row.nom}</option>
						</c:forEach>
					</select>
					<input type="submit" value="go" style=" width : 168px;">
				  </form>
			  </div>
			</div>
		  </div>
		</div>
		</header>	
		
		<div id="counterwrapper" style="margin-bottom: -175px;"></div>
		<!-- Wrapper-->
			<div id="wrapper">
				
				<!-- Nav -->
					<nav id="nav">
						<a href="#recherche" class="icon fa-home active"><span>Home</span></a>
						<a href="#work" class="icon fa-folder"><span>Work</span></a>
						<a href="#contact" class="icon fa-envelope"><span>Contact</span></a>
					</nav>

				<!-- Main -->
					<div id="main">
						
						<!-- recherche -->
							<article id="recherche" class="panel">
								<header>
									<h2>Faire votre recherche dans notre site</h2>
								</header>
									<sql:query dataSource="${snapshot}" var="matiere">
												SELECT * from Matiere;
										</sql:query>
									<form method="post" action="Main">
										<div>
										<input type="hidden" name="op" value="rechercher">
											<div class="row">
												<div class="6u">
													<select  id="matiere" name="matiere" >
														<c:forEach var="row" items="${matiere.rows}">
														<option value="${row.id}" >${row.nom}</option>
														</c:forEach>
													</select>
												</div>
												<div class="6u">
													 <select  id="villes" name="villes" >
														<c:forEach var="row" items="${villes.rows}">
														<option value="${row.id}" >${row.nom}</option>
														</c:forEach>
													</select>
												</div>
											</div>
											<div class="row">
												<div class="6u">
													Entre <input type="text" id="prix_min" name="prix_min" placeholder="prix min"/>
												</div>
												<div class="6u">
													 et <input type="text" id="prix_max" name="prix_max" placeholder="prix max"   />
												</div>
											</div>
												<div class="clear"></div>
												<button class="btn btn-lg btn-primary btn-block" type="submit" style="width:200px;">Rechercher</button>
										</div>
									</form>
									<!--</nav>
								</header>-->
							</article>

						<!-- Work --> 
							<article id="work" class="panel">
				<header>
					<h4>les dernières annonces mises en ligne</h4>
				</header>
				<section>
					<% if(request.getAttribute("annoncesRecentes")!=null){
									Collection<Annonce> annoncesRecentes = (Collection<Annonce>) request.getAttribute("annoncesRecentes");
											if(! annoncesRecentes.isEmpty()){%>
					<ul class="list-group">
						<%for(Annonce a : annoncesRecentes){%>
						<li class="list-group-item" style="background-color: #f1f1f1;">
							<div class="row">
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
						</li>
						<%}%>
					</ul>
						<%}else {%><h2>Aucune annonce</h2>
						<%}}else {%><h2>Aucune annonce</h2>
						<%}%>
				</section>
			</article>

						<!-- Contact -->
							<article id="contact" class="panel">
								<header>
									<h2>Contact Me</h2>
								</header>
								<form action="Main" method="post">
									<div>
										<div class="row">
											<div class="6u">
												<input type="text" name="name" placeholder="Name" />
											</div>
											<div class="6u">
												<input type="text" name="email" placeholder="Email" />
											</div>
										</div>
										<div class="row">
											<div class="12u">
												<input type="text" name="subject" placeholder="Subject" />
											</div>
										</div>
										<div class="row">
											<div class="12u">
												<textarea name="message" placeholder="Message" rows="8"></textarea>
											</div>
										</div>
										<div class="row">
											<div class="12u">
												<input type="submit" value="Send Message" />
											</div>
										</div>
									</div>
								</form>
							</article>

					</div>
				<div id="main" class="container">
	<%if(request.getAttribute("erreurs")!=null){
				Collection<String> erreurs =(Collection<String>) request.getAttribute("erreurs");
				if (!erreurs.isEmpty()){
					%><div id="cadre_page">
		<div class="alert alert-error">
			<button data-dismiss="alert" class="close" type="button">×</button>
			<b>Erreur !</b>
			<%
					for(String erreur : erreurs){
						%><p>
				-<%=erreur%></p>
			<%
					}
				}
			}
				%>


		</div>
	</div>
				<!-- Footer -->
					<div id="footer">
						<ul class="copyright">
							<li>&copy; Untitled.</li><li>Design:Hamza, Ayoub, Oussama & Anca</li>
						</ul>
					</div>
		
			</div>
			</div>
			
			<!-- Footer -->
		<footer class="footer" id="footer">
      <div class="container">
         <p class="text-muted">Made by Hamza BOURBOUH, Oussama Markad, Ayoub Ratbi and Anca popescu</p>
      </div>
    </footer>
  </body>
</html>
