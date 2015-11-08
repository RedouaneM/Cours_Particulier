package ejb;

import java.io.Serializable;
import java.util.Collection;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Follower implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	
	@ManyToOne
	Annonce annonce;
	
	@ManyToOne
	Personne membreSuiveur;
	
	public Follower(){}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Personne getMembreSuiveur() {
		return membreSuiveur;
	}

	public void setMembreSuiveur(Personne follower) {
		this.membreSuiveur= follower;
	}

	public Annonce getAnnonce() {
		return annonce;
	}


	public void setAnnonce(Annonce annonce) {
		this.annonce = annonce;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
	
	
}
