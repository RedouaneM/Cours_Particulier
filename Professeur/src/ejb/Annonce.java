package ejb;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Annonce implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	int id;
	
	private String titre;
	private String message;
	private int prix;
	private boolean estOffre;
	private float note;
	private int nbPersNotee;
	@ManyToOne
	Personne proprio;
	
	@ManyToOne
	Ville ville;
	
	@ManyToOne
	Matiere matiere;
	
	@OneToMany(mappedBy="annonce",fetch=FetchType.EAGER)
	Set<Commentaire> commentaires_recus;
	@OneToMany(mappedBy="annonce",fetch=FetchType.EAGER)
	Set<Follower> followers;
	@OneToMany(mappedBy="annonce",fetch=FetchType.EAGER)
	Set<Vote> votes;
	
	public void setId(int id) {
		this.id = id;
	}

	public Annonce(){}
	
	public Annonce(String titre,String message,int prix,boolean estOffre) {
		//this.matiere.setId(matiere_id);
		this.titre=titre;
		this.message=message;
		this.prix=prix;
		this.estOffre=estOffre;
	}
	public int getNbPersNotee() {
		return nbPersNotee;
	}
	public void setNbPersNotee(int nbPersNotee) {
		this.nbPersNotee = nbPersNotee;
	}
	public float getNote() {
		return note;
	}
	public void setNote(float note) {
		this.note = note;
	}
	public int getId(){
		return this.id;
	}
	
	
	public Matiere getMatiere() {
		return this.matiere;
	}
	
	public Ville getVille() {
		return this.ville;
	}
	
	public String getTitre() {
		return this.titre;
	}
	
	public String getMessage() {
		return this.message;
	}
	
	public int getPrix() {
		return this.prix;
	}
	
	public boolean estOffre() {
		return this.estOffre;
	}
	
	public boolean getEstOffre() {
		return estOffre;
	}

	public void setEstOffre(boolean estOffre) {
		this.estOffre = estOffre;
	}

	public Personne getProprio() {
		return proprio;
	}

	public void setProprio(Personne proprio) {
		this.proprio = proprio;
	}

	public void setMatiere(Matiere matiere) {
		this.matiere = matiere;
	}

	public void setVille(Ville ville) {
		this.ville = ville;
	}

	public void setTitre(String titre) {
		this.titre = titre;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public void setPrix(int prix) {
		this.prix = prix;
	}

}