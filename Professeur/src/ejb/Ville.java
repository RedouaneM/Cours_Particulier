package ejb;

import java.util.Collection;

import javax.persistence.Embeddable;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.OneToMany;



@Entity 
public class Ville {
	private String nom;
	private String pays;
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	@OneToMany(mappedBy="ville",fetch=FetchType.EAGER)
	Collection<Annonce> annonces;
	
	
	
	public Ville(){}
	
	public String getPays() {
		return pays;
	}

	public void setPays(String pays) {
		this.pays = pays;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Ville(String nom,String pays){
		this.nom=nom;
		this.pays =pays;
	}
	
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	
	
	public Collection<Annonce> getAnnonces() {
		return this.annonces;
	}
	public void setAnnonces(Collection<Annonce> annonces) {
		this.annonces = annonces;
	}
	
}
