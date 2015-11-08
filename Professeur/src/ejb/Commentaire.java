package ejb;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;


@Entity
public class Commentaire implements Serializable {

	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	
	private String commentaire;
	
	@ManyToOne
	Annonce annonce;
	
	@ManyToOne
	Personne membreEmetteur;
	@ManyToOne
	Personne membreRecepteur;
	
	
	public Commentaire(){}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCommentaire() {
		return commentaire;
	}

	public void setCommentaire(String commentaire) {
		this.commentaire = commentaire;
	}
	public Personne getMembreRecepteur() {
		return membreRecepteur;
	}

	public void setMembreRecepteur(Personne membreRecepteur) {
		this.membreRecepteur = membreRecepteur;
	}

	

	public Annonce getAnnonce() {
		return annonce;
	}

	public void setAnnonce(Annonce annonce) {
		this.annonce = annonce;
	}

	public Personne getMembreEmetteur() {
		return membreEmetteur;
	}

	public void setMembreEmetteur(Personne membreEmetteur) {
		this.membreEmetteur = membreEmetteur;
	}
	
	
}
