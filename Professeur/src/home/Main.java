package home;

import java.io.IOException;
import java.util.Collection;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ejb.Annonce;
import ejb.Facade;
import ejb.Personne;


/**
 * Servlet implementation class Main
 */
@WebServlet("/Main")
@MultipartConfig
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private Facade f=new Facade();

	private HttpSession session;
	private String pays = "F";  //par defaut la France
	private String chemin1 =  "E:\\integiciels\\Professeur\\WebContent\\images\\personne\\";
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Main() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String sop = request.getParameter("op");
		session = request.getSession();
		Collection<Annonce> annoncesRecentes = f.getAnnoncesRecentes();
		request.setAttribute("annoncesRecentes",annoncesRecentes);
		
		switch(sop){
		case "changer_pays":	
			pays=request.getParameter("pays");
			String url = request.getParameter("url");
			session.setAttribute("pays",pays);
			request.setAttribute("erreurs", f.getErreurs());
			session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
			String id_annonce = request.getParameter("id_annonce");
			if(id_annonce!=null){
				int id = Integer.parseInt(id_annonce);
				Annonce an = f.getAnnonce(id);
				request.setAttribute("annonce", an);
			}
			this.getServletContext().getRequestDispatcher(url).forward(request, response);
			f.InitErreurs();
			break;

		case "index" :
			// on recupere la session du personne qu'il a fait remember me s'il existe
			if(f.recupererSession("v")) {
				session.setAttribute("pays",pays);
				System.out.println(pays);
				session.setAttribute("identifiant" ,f.getPersonneConnecte().getIdentifiant());
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/indexSession.jsp").forward(request, response);
			}
			else {
				//verifier s'il y a quelqu'un connecte ou pas
				if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
					session.setAttribute("pays",pays);
					System.out.println(pays);
					this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
				}
				else{
					session.setAttribute("pays",pays);
					System.out.println(pays);
					session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
					this.getServletContext().getRequestDispatcher("/WEB-INF/indexSession.jsp").forward(request, response);
				}
			}
			break;

		case "indexSession":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				session.setAttribute("pays",pays);
				System.out.println(pays);
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/indexSession.jsp").forward(request, response);
			}
			break;

		case "s'inscrire":	

			String nom = request.getParameter("nom");

			String prenom = request.getParameter("prenom");

			String email = request.getParameter("email");

			String tel = request.getParameter("phone");

			String ident = request.getParameter("identifiant");

			String mdp = request.getParameter("mdp");

			String confMdp = request.getParameter("confirmationMdp");

			f.enregistrerFichier( request,ident+".jpg",chemin1);
			f.inscrire(nom, prenom, tel, email, ident, mdp , confMdp);
			request.setAttribute("erreurs", f.getErreurs());
			if(f.getErreurs().isEmpty()){
				session.setAttribute("identifiant",ident);
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				session.setAttribute("pays",pays);
				System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/WEB-INF/indexSession.jsp").forward(request, response);
			}
			else{
				request.setAttribute("nom", nom);
				request.setAttribute("prenom", prenom);
				request.setAttribute("phone", tel);
				request.setAttribute("identifiant", ident);
				this.getServletContext().getRequestDispatcher("/inscription.jsp").forward(request, response);
				f.InitErreurs();
			}

			break;
		case "deleteProfil":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				String mdp2= request.getParameter("mdp");
				f.deleteProfil(mdp2);
				if(f.getErreurs().isEmpty()){
					this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
				}
				else{
					request.setAttribute("erreurs", f.getErreurs());
					session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
					this.getServletContext().getRequestDispatcher("/WEB-INF/profil-suppression-compte.jsp").forward(request, response);
					f.InitErreurs();
				}
			}
			break;
		case "changerMdp":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				String oldpwd = request.getParameter("oldpwd");
				String newpwd = request.getParameter("newpwd");
				String confpwd = request.getParameter("confpwd");
				f.updatePassword(oldpwd,newpwd,confpwd);
				request.setAttribute("erreurs", f.getErreurs());
				Personne p2 = f.getPersonne((String)session.getAttribute("identifiant"));
				session.setAttribute("Personne",p2);
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/profil.jsp").forward(request, response);
				f.InitErreurs();
			}
			break;
		case "modifier_profil":
			String nom2 = request.getParameter("nom");

			String prenom2 = request.getParameter("prenom");

			String email2 = request.getParameter("email");

			String tel2 = request.getParameter("phone");

			String ident2 = request.getParameter("identifiant");


			f.updateProfil(nom2, prenom2, tel2, email2, ident2);

			request.setAttribute("erreurs", f.getErreurs());
			if(f.getErreurs().isEmpty()){
				session.setAttribute("identifiant",ident2);
			}
			session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
			this.getServletContext().getRequestDispatcher("/WEB-INF/profil.jsp").forward(request, response);
			f.InitErreurs();
			break;
		case "seconnecter":

			String ident1 = request.getParameter("identifiant");
			System.out.println(ident1);
			session.setAttribute("identifiant",ident1);
			String mdp1 = request.getParameter("mdp");
			System.out.println(mdp1);
			String remember = request.getParameter("remember");
			f.connecter(ident1, mdp1);
			if(f.getErreurs().isEmpty()) {
			// verifier si quelqu'un a fait remember me 
			if (remember!=null){
				// creer une cookie pour cet personne avec pour valeur v et l'ajouter à l'ensemble des cookies
				Cookie cookie = new Cookie(ident1, "v");
				cookie.setMaxAge(365*24*60*60);
				response.addCookie(cookie);
				f.getPersonne((String)session.getAttribute("identifiant")).setSession_id("v");
				f.ajouterSessionId(ident1, "v");
				// écraser le personne qui etait enregiste dans la session
				for(Cookie c:request.getCookies()) {
					if (c.getValue().equals(cookie.getValue()) && !c.getName().equals(cookie.getName()) && f.getIdentifiants().contains(c.getName())) {
						c.setValue("");
						f.getPersonne(c.getName()).setSession_id("");
						f.ajouterSessionId(c.getName(), "");
					}
				}
			}
			else {
				if (request.getCookies()!=null) {
					// si le personne qui etait enregistre dans la session et il voulait que le site ne souvient pas de lui on change la valeur de sa cookie
					for(Cookie c:request.getCookies()) {
						if (c.getName().equals(ident1)) {
							c.setValue("");
							f.getPersonne((String)session.getAttribute("identifiant")).setSession_id("");
							f.ajouterSessionId(ident1, "");
						}
					}
				}
			}
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				session.setAttribute("pays",pays);
				System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/WEB-INF/indexSession.jsp").forward(request, response);
			}
			else{
				request.setAttribute("erreurs", f.getErreurs());
				this.getServletContext().getRequestDispatcher("/connexion.jsp").forward(request, response);
				f.InitErreurs();
			}

			break;

		case "accederEspacePerso" :
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				request.setAttribute("annonces_que_je_suis", f.getAnnoncesQueJeSuis(f.getPersonne((String)session.getAttribute("identifiant")).getId()));
				request.setAttribute("membres_qui_me_suivent",f.getMembresQuiMeSuivent(f.getPersonne((String)session.getAttribute("identifiant")).getId()));
				this.getServletContext().getRequestDispatcher("/WEB-INF/espacePerso.jsp").forward(request, response);		
			}
			break;
		case "Mes_annonces":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				int idPers = f.getPersonne((String)session.getAttribute("identifiant")).getId();
				Collection<Annonce> annonces2 = f.getMesAnnonces(idPers,true);
				request.setAttribute("annonces", annonces2);
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/tableau-de-bord-mes-annonces.jsp").forward(request, response);
			}
			break;
		case "Mes_demandes_de_cours":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				int idPers = f.getPersonne((String)session.getAttribute("identifiant")).getId();
				Collection<Annonce> annonces2 = f.getMesAnnonces(idPers,false);
				request.setAttribute("annonces", annonces2);
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/tableau-de-bord_Mes_demandes.jsp").forward(request, response);
			}
			break;
		case "Profil":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/profil.jsp").forward(request, response);
			}
			break;
		case "profil_personne" : 
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				String id_personne = request.getParameter("id_personne");
				int id = Integer.parseInt(id_personne);
				System.out.println(id);
				Collection<Annonce> annonces2 = f.getMesAnnonces(id,false);
				request.setAttribute("annonces_Demande", annonces2);
				Collection<Annonce> annonces1 = f.getMesAnnonces(id,true);
				request.setAttribute("annonces_Offre", annonces1);
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				request.setAttribute("proprio_profil", f.getPersonne(id));
				this.getServletContext().getRequestDispatcher("/WEB-INF/profil_personne.jsp").forward(request, response);
			}			
			break;
		case "profil-photo":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/profil-photo.jsp").forward(request, response);
			}
			break;
		case "profil-commentaires":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				request.setAttribute("commentaires_recu", f.getCommentaires_recus(f.getPersonne((String)session.getAttribute("identifiant")).getId()));
				request.setAttribute("commentaires_emis", f.getCommentaires_emis(f.getPersonne((String)session.getAttribute("identifiant")).getId()));
				this.getServletContext().getRequestDispatcher("/WEB-INF/profil-commentaires.jsp").forward(request, response);
			}
			break;
		case "profil-suppression-compte":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/profil-suppression-compte.jsp").forward(request, response);
			}
			break;
		case "les-membres-suivis":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				request.setAttribute("membres_qui_me_suivent", f.getMembresQuiMeSuivent(f.getPersonne((String)session.getAttribute("identifiant")).getId()));
				request.setAttribute("annonces_que_je_suis", f.getAnnoncesQueJeSuis(f.getPersonne((String)session.getAttribute("identifiant")).getId()));
				this.getServletContext().getRequestDispatcher("/WEB-INF/les-membres-suivis.jsp").forward(request, response);
			}
			break;

		case "les-membres-qui-me-suivent":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				request.setAttribute("membres_qui_me_suivent", f.getMembresQuiMeSuivent(f.getPersonne((String)session.getAttribute("identifiant")).getId()));
				this.getServletContext().getRequestDispatcher("/WEB-INF/les-membres-qui-me-suivent.jsp").forward(request, response);
			}
			break;

		case "sedeconnecter":
			f.deconnecter();
			session.invalidate();
			this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			break;


		case "rechercher" :

			String matiere = request.getParameter("matiere");
			int matiere_id = Integer.parseInt(matiere);
			String Ville = request.getParameter("villes");
			int ville_id = Integer.parseInt(Ville);
			String sprix_min = request.getParameter("prix_min");
			f.validationPrix(sprix_min);
			String sprix_max = request.getParameter("prix_max");
			f.validationPrix(sprix_max);
			if(!f.getErreurs().isEmpty()) {
				if(f.getPersonne((String)session.getAttribute("identifiant"))==null) {
					request.setAttribute("erreurs", f.getErreurs());
					this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
					f.InitErreurs();
				}
				else {
					request.setAttribute("erreurs", f.getErreurs());
					session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
					this.getServletContext().getRequestDispatcher("/WEB-INF/indexSession.jsp").forward(request, response);
					f.InitErreurs();
				}
			}
			else{
				int prix_min=0;
				if (sprix_min!="") {
					prix_min = Integer.parseInt(sprix_min);
				}
				int prix_max=10000;
				if (sprix_max!="") {
					prix_max = Integer.parseInt(sprix_max);
				}
				Collection<Annonce> annonces = f.rechercherAnnonces(matiere_id ,ville_id,prix_min,prix_max);
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				request.setAttribute("annonces", annonces);
				this.getServletContext().getRequestDispatcher("/WEB-INF/AfficherAnnonces.jsp").forward(request, response);
			}
			break;

		case "deposer" :

			String v = request.getParameter("villes");
			int id_ville=Integer.parseInt(v);
			System.out.println(id_ville);

			String titre = request.getParameter("subject");
			System.out.println(titre);

			String matiere1 = request.getParameter("matiere");
			int matiere_id1=Integer.parseInt(matiere1);
			System.out.println(matiere1);
			String prix = request.getParameter("prix");
			String message = request.getParameter("body");
			System.out.println(message);
			String estOffre = request.getParameter("type");
			System.out.println(estOffre);
			Boolean isOffre =false;
			if(estOffre.equals("s")) isOffre=true;
			f.deposerAnnonce(matiere_id1, titre, message, prix, isOffre,id_ville );
			session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
			if(f.getErreurs().isEmpty()) {
				this.getServletContext().getRequestDispatcher("/WEB-INF/validation.jsp").forward(request, response);
			}
			else{
				request.setAttribute("erreurs", f.getErreurs());
				this.getServletContext().getRequestDispatcher("/WEB-INF/deposer.jsp").forward(request, response);
				f.InitErreurs();
			}
			break;

		case "deposerInitial" :
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/deposer.jsp").forward(request, response);
			}

			break;

		case "supprimerOffre" :
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				String id_annonce2 = request.getParameter("id_annonce");
				int id2 = Integer.parseInt(id_annonce2);
				f.supprimerAnnonce(id2);
				int idPers = f.getPersonne((String)session.getAttribute("identifiant")).getId();
				request.setAttribute("annonces", f.getMesAnnonces(idPers,true));
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/tableau-de-bord-mes-annonces.jsp").forward(request, response);
			}
			break;
		case "supprimerDemande" :
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				String id_annonce3 = request.getParameter("id_annonce");
				int id3 = Integer.parseInt(id_annonce3);
				f.supprimerAnnonce(id3);
				int idPers = f.getPersonne((String)session.getAttribute("identifiant")).getId();
				request.setAttribute("annonces", f.getMesAnnonces(idPers,false));
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/tableau-de-bord_Mes_demandes.jsp").forward(request, response);
			}
			break;
		case "gerer_annonce":
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				String id_annonce2 = request.getParameter("id_annonce");
				int id2 = Integer.parseInt(id_annonce2);
				Annonce an2 = f.getAnnonce(id2);
				request.setAttribute("annonce", an2);
				int idville = an2.getVille().getId();
				pays = f.getCodePays(idville);
				session.setAttribute("pays",pays);
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/rectifier.jsp").forward(request, response);
			}
			break;
		case "rectifier" :
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				String id_annonce4 = request.getParameter("id_annonce");
				int id4 = Integer.parseInt(id_annonce4);

				String vrec = request.getParameter("villes");
				int id_villerec=Integer.parseInt(vrec);
				String titrerec = request.getParameter("subject");

				String matiererec = request.getParameter("matiere");
				int matiererec_id = Integer.parseInt(matiererec); 

				String prixrec = request.getParameter("prix");
				int sprixrec = Integer.parseInt(prixrec);

				String messagerec = request.getParameter("body");

				String estOffrerec = request.getParameter("type");
				Boolean isOffrerec =false;
				if(estOffrerec.equals("s")) isOffrerec=true;

				f.rectifierAnnonce(id4, matiererec_id, titrerec, messagerec, prixrec, isOffrerec,id_villerec );
				request.setAttribute("erreurs", f.getErreurs());
				Annonce an3 = f.getAnnonce(id4);
				request.setAttribute("annonce", an3);
				int idville = an3.getVille().getId();
				pays = f.getCodePays(idville);
				session.setAttribute("pays",pays);
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/rectifier.jsp").forward(request, response);
				f.InitErreurs();
			}
			break;


		case "detail" :
			String id_ann = request.getParameter("id_annonce");
			int idAnnonce = Integer.parseInt(id_ann);
			if( f.getPersonne((String)session.getAttribute("identifiant")) != null) {
				// verifier si le personne a deja vote l'annonce
				if(f.dejaVote(f.getPersonne((String)session.getAttribute("identifiant")).getId(), idAnnonce)) {
					request.setAttribute("voter","false");
				}
				else {
					request.setAttribute("voter","true");
				}
			}
			request.setAttribute("comment","true");
			request.setAttribute("annoncesSimilaires", f.getAnnoncesSimilaire(idAnnonce));
			request.setAttribute("annonce",f.getAnnonce(idAnnonce));
			request.setAttribute("commentaires", f.getCommentaires_dune_annonce(idAnnonce));
			session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
			session.setAttribute("proprio_annonce",f.getAnnonce(idAnnonce).getProprio());
			this.getServletContext().getRequestDispatcher("/WEB-INF/detail.jsp").forward(request, response);
			break;

		case "follow":
			String id_ann1 = request.getParameter("id_annonce");
			int idAnnonce1 = Integer.parseInt(id_ann1);
			if (f.isProprio(idAnnonce1,f.getPersonne((String)session.getAttribute("identifiant")).getId())) {
				request.setAttribute("misenrelation","false");
				this.getServletContext().getRequestDispatcher("/WEB-INF/misEnRelation.jsp").forward(request, response);
			}
			else {
				f.misEnRelation((String)session.getAttribute("identifiant"),idAnnonce1);
				Personne suivi = f.getAnnonce(idAnnonce1).getProprio();
				request.setAttribute("misenrelation","true");
				session.setAttribute("suivi",suivi);
				this.getServletContext().getRequestDispatcher("/WEB-INF/misEnRelation.jsp").forward(request, response);
			}
			break;

		case "supprimerSuivi" :
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				System.out.println(pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				String id_annonce2 = request.getParameter("id_annonce");
				int id2 = Integer.parseInt(id_annonce2);
				int idPers = f.getPersonne((String)session.getAttribute("identifiant")).getId();
				f.supprimerSuivi(id2,idPers);
				request.setAttribute("annonces_que_je_suis", f.getAnnoncesQueJeSuis(idPers));
				request.setAttribute("membres_qui_me_suivent", f.getMembresQuiMeSuivent(idPers));
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				this.getServletContext().getRequestDispatcher("/WEB-INF/les-membres-suivis.jsp").forward(request, response);
			}
			break;	

		case "signaler" :
			int idan = Integer.parseInt(request.getParameter("id_annonce"));
			if( f.getPersonne((String)session.getAttribute("identifiant")) != null) {
				// verifier si le personne a deja vote l'annonce
				if(f.dejaVote(f.getPersonne((String)session.getAttribute("identifiant")).getId(), idan)) {
					request.setAttribute("voter","false");
				}
				else {
					request.setAttribute("voter","true");
				}
			}
			request.setAttribute("comment","true");
			request.setAttribute("annoncesSimilaires",f.getAnnoncesSimilaire(idan));
			request.setAttribute("annonce",f.getAnnonce(idan));
			request.setAttribute("commentaires", f.getCommentaires_dune_annonce(idan));
			session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
			session.setAttribute("proprio_annonce",f.getAnnonce(idan).getProprio());
			this.getServletContext().getRequestDispatcher("/WEB-INF/detail.jsp").forward(request, response);
			break;
		case "send" :
			int idan2 = Integer.parseInt(request.getParameter("id_annonce"));
			if( f.getPersonne((String)session.getAttribute("identifiant")) != null) {
				// verifier si le personne a deja vote l'annonce
				if(f.dejaVote(f.getPersonne((String)session.getAttribute("identifiant")).getId(), idan2)) {
					request.setAttribute("voter","false");
				}
				else {
					request.setAttribute("voter","true");
				}
			}
			request.setAttribute("comment","true");
			request.setAttribute("annoncesSimilaires",f.getAnnoncesSimilaire(idan2));
			request.setAttribute("annonce",f.getAnnonce(idan2));
			request.setAttribute("commentaires", f.getCommentaires_dune_annonce(idan2));
			session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
			session.setAttribute("proprio_annonce",f.getAnnonce(idan2).getProprio());
			this.getServletContext().getRequestDispatcher("/WEB-INF/detail.jsp").forward(request, response);

			break;
		case "uploadPhoto" :
			//verifier s'il y a quelqu'un connecte ou pas
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){

				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				f.enregistrerFichier( request,f.getPersonne((String)session.getAttribute("identifiant")).getIdentifiant()+".jpg",chemin1);
				this.getServletContext().getRequestDispatcher("/WEB-INF/profil.jsp").forward(request, response);
				f.InitErreurs();
			}
			break;

		case "comment":
			int idAnnonce2 = Integer.parseInt(request.getParameter("id_annonce"));
			String commentaire = request.getParameter("commentaire");
			if (f.getPersonne((String)session.getAttribute("identifiant"))==null) {
				request.setAttribute("comment","false");
				request.setAttribute("voter","false");
			}
			else {
				f.comment((String)session.getAttribute("identifiant"),idAnnonce2,commentaire);
				// verifier si le personne a deja vote l'annonce
				if(f.dejaVote(f.getPersonne((String)session.getAttribute("identifiant")).getId(), idAnnonce2)) {
					request.setAttribute("voter","false");
				}
				else {
					request.setAttribute("voter","true");
				}
			}
			request.setAttribute("annonce",f.getAnnonce(idAnnonce2));
			request.setAttribute("commentaires", f.getCommentaires_dune_annonce(idAnnonce2));
			request.setAttribute("annoncesSimilaires",f.getAnnoncesSimilaire(idAnnonce2));
			session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
			session.setAttribute("proprio_annonce",f.getAnnonce(idAnnonce2).getProprio());
			this.getServletContext().getRequestDispatcher("/WEB-INF/detail.jsp").forward(request, response);
			break;
		case "supprimerCommentaire":
			if( f.getPersonne((String)session.getAttribute("identifiant")) == null){
				session.setAttribute("pays",pays);
				this.getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
			}
			else{
				int idCommentaire = Integer.parseInt(request.getParameter("id_commentaire"));
				f.SupprimerCommentaire(idCommentaire);
				session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
				request.setAttribute("commentaires_recu", f.getCommentaires_recus(f.getPersonne((String)session.getAttribute("identifiant")).getId()));
				request.setAttribute("commentaires_emis", f.getCommentaires_emis(f.getPersonne((String)session.getAttribute("identifiant")).getId()));
				this.getServletContext().getRequestDispatcher("/WEB-INF/profil-commentaires.jsp").forward(request, response);
			}
			break;

		case "voter":
			int id = Integer.parseInt(request.getParameter("id_annonce"));
			int note =  Integer.parseInt(request.getParameter("note"));
			// verifier si le personne a deja vote l'annonce
			if(!f.dejaVote(f.getPersonne((String)session.getAttribute("identifiant")).getId(), id)) {
				f.voter(id,note);
			}
			request.setAttribute("voter","false");
			request.setAttribute("comment","true");
			request.setAttribute("annoncesSimilaires", f.getAnnoncesSimilaire(id));
			request.setAttribute("annonce",f.getAnnonce(id));
			request.setAttribute("commentaires", f.getCommentaires_dune_annonce(id));
			session.setAttribute("Personne",f.getPersonne((String)session.getAttribute("identifiant")));
			session.setAttribute("proprio_annonce",f.getAnnonce(id).getProprio());
			this.getServletContext().getRequestDispatcher("/WEB-INF/detail.jsp").forward(request, response);
			break;

		}
	}

}
