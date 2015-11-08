package ejb;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

@Entity
public class Vote implements Serializable{

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;

	@ManyToOne
	Annonce annonce;

	@OneToOne
	Personne membreVote;
	@ManyToOne
	Personne membreRecepteur;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Annonce getAnnonce() {
		return annonce;
	}

	public void setAnnonce(Annonce annonce) {
		this.annonce = annonce;
	}

	public Personne getMembreVote() {
		return membreVote;
	}

	public void setMembreVote(Personne membreVote) {
		this.membreVote = membreVote;
	}

	public Personne getMembreRecepteur() {
		return membreRecepteur;
	}

	public void setMembreRecepteur(Personne membreRecepteur) {
		this.membreRecepteur = membreRecepteur;
	}

}
