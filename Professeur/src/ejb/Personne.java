package ejb;

import java.io.Serializable;
import java.util.*;

import javax.persistence.*;

@Entity
public class Personne implements Serializable {
		
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	
	private String nom;
	private String Prenom;
	private String tel;
	private String email;
	private String identifiant;
	private String mdp;
	private String session_id;
	
	
	@OneToMany(mappedBy="proprio",fetch=FetchType.EAGER)
	Set<Annonce> annonces;
	
	@OneToMany(mappedBy="membreSuiveur",fetch=FetchType.EAGER)
	Set<Follower> suivis;
	
	@OneToMany(mappedBy="membreEmetteur",fetch=FetchType.EAGER)
	Set<Commentaire> commentaires_emis;
	
	@OneToMany(mappedBy="membreRecepteur",fetch=FetchType.EAGER)
	Set<Commentaire> commentaires_recu;
	
	@OneToMany(mappedBy="membreRecepteur",fetch=FetchType.EAGER)
	Set<Vote> votes;
	
	public Personne(){}
	public Personne(String nom,String prenom, String tel,String email ,String ident,String mdp){
		this.nom=nom;
		this.Prenom=prenom;
		this.tel=tel;
		this.email=email;
		this.identifiant=ident;
		this.mdp=mdp;
	}
	
	
	
	public Collection<Follower> getSuivis() {
		return suivis;
	}
	public String getSession_id() {
		return session_id;
	}
	public void setSession_id(String session_id) {
		this.session_id = session_id;
	}
	
	public int getId(){
		return this.id;
	}
	
	public String getIdentifiant() {
		return identifiant;
	}
	public void setIdentifiant(String indentifiant) {
		this.identifiant = indentifiant;
	}
	public String getMdp() {
		return mdp;
	}
	public void setMdp(String mdp) {
		this.mdp = mdp;
	}
	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return Prenom;
	}

	public void setPrenom(String prenom) {
		Prenom = prenom;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	

	
	
		
}
