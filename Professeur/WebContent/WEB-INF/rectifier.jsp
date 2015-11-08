<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*,ejb.*, home.*" %>
 <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>réctifier</title>

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
     url="jdbc:mysql://localhost/mondial"
     user="root"  password="ostermann"/>
      	<%String p = (String) session.getAttribute("pays");%>
  	  <sql:query dataSource="${snapshot}" var="villes">
		SELECT * from Ville where pays='<%=p%>';
	</sql:query>
	<!-- Header -->
	<%Annonce annonce = (Annonce) request.getAttribute("annonce");%>
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
					</ul>
				</li>
				<li><a href="#" data-toggle="modal" data-target="#pays">Changer pays</a></li> 
				<li><a  href="aide.html">Aide</a></li>
				
			</ul>
		</nav>
		</div>
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
					<input type="hidden" name="id_annonce" value="<%=annonce.getId()%>"/>
					<input type="hidden" name="url" value="/WEB-INF/rectifier.jsp"/>
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
		<div id="main" class="container">
		
		<%Collection<String> erreurs =(Collection<String>) request.getAttribute("erreurs");
					if (erreurs!=null){
					if(erreurs.isEmpty()){%>
						<div class="alert alert-success" role="alert">
							<strong>Well done!</strong> vos informations sont bien mis a jour
						</div>
					<%}
						
					if(!erreurs.isEmpty()){%>
					<div class="alert alert-danger" role="alert">
					<b>Erreur !</b><%
						for(String erreur : erreurs){
							%><p>-<%=erreur%></p><%
						}%>
					</div>
						<%}%>
						
					<%}%>
				
		<form method="post" action="Main" name="formular">
			<input type=hidden name="op" value="rectifier">
			<input type=hidden name="id_annonce" value="<%=annonce.getId() %>">
			<div id="newad_form" class="lbcAcont">
				<h2>Localisation</h2>
				<div class="labelform" style="display: block;" id="ldpt_code">
					<label>Ville:</label>
				</div>
				<div class="adinput height-limit" id="ddpt_code"
					style="display: block;">
					<div class="select">
						<select  id="villes" value="<%=annonce.getVille().getId()%>" name="villes" style=" width : 218px;">
						<option value="<%=annonce.getVille().getId()%>" ><%=annonce.getVille().getNom()%></option>
				<c:forEach var="row" items="${villes.rows}">
					<option value="${row.id}" >${row.nom}</option>
				</c:forEach>
			</select>
					</div>

					<div class="clear"></div>

					
				<div id="field_ad_type" style="display: block">
					<div class="labelform">Type d'annonce:</div>
					<div class="container">
					<div class="adinput" id="dtype">
						<div class="radio">
							<input id="rs" type="radio" name="type" value="s"
								<%if(annonce.estOffre()){ %>checked="checked"<% }%>
								onclick="typeChanged('s', 'dprice', 'lprice', 'category', 'company_ad');" />
							<label for="rs">Offre</label>
						</div>
						<div class="radio">
							<input id="rk" type="radio" name="type" value="k"
								<%if(!annonce.estOffre()){ %>checked="checked"<% }%>
								onclick="typeChanged('k', 'dprice', 'lprice', 'category', 'company_ad');" />
							<label for="rk">Demande</label>
						</div>
					</div>
					</div>
					<div class="clear"></div>
				</div>
				<div class="clear"></div>
				<div id='store_holder'></div>

				
				<div class="clear"></div>
				<h2>Votre annonce</h2>
				<div class="clear"></div>
				<div class="labelform" id="lsubject">
					<label>Titre de l'annonce:</label>
				</div>
				<div class="adinput">
					<input type="text" id="subject" name="subject" size="50"
						maxlength="50" value="<%=annonce.getTitre()%>" style="width: 600px;" />
					<div class="clear"></div>
					<div id="title_caption"></div>
				</div>
				<div class="clear"></div>
			</div>
			 <sql:query dataSource="${snapshot}" var="matiere">
				SELECT * from Matiere;
			</sql:query>
			<div class="labelform" style="display: block;" id="ldpt_code">
					<label>Matiere:</label>
				</div>
				<div class="adinput height-limit" id="ddpt_code" style="display: block;">
					<div class="select">
						<select  id="matiere" value="<%=annonce.getMatiere().getId()%>" name="matiere" style=" width : 218px;">
						<option value="<%=annonce.getMatiere().getId()%>" ><%=annonce.getMatiere().getNom()%></option>
				<c:forEach var="row" items="${matiere.rows}">
					<option value="${row.id}" >${row.nom}</option>
				</c:forEach>
			</select>
					</div>
					
	<label>Prix :</label>
	<div class="adinput">
		<input type="text" id="prix" name="prix" size="50" maxlength="50"
			value="<%=annonce.getPrix()%>" style="width: 600px;" />
		<div class="clear"></div>
	</div>
	<div class="labelform" style="clear: left;" id="lbody">
		<label>Texte de l'annonce:</label>
	</div>
	<textarea cols="50" rows="10" name="body" id="body" 
		style="width: 600px;"><%=annonce.getMessage()%></textarea>

	<div class="clear"></div>
	<br>
	<div class="adinput" id="submit-buttoms">

		<input type="submit" name="validate" value="Valider" class="button" />
	</div>

	</form>
	</div>
	
	<!-- Footer -->
		<footer class="footer" id="footer">
      <div class="container">
         <p class="text-muted">Made by Hamza BOURBOUH, Oussama Markad, Ayoub Ratbi and Anca popescu</p>
      </div>
    </footer>
</body>
</html>
