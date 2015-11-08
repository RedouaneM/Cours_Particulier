package ejb;

import java.util.Collection;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Matiere {
	
	private String nom;
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private int id;
	
	@OneToMany(mappedBy="matiere",fetch=FetchType.EAGER)
	Set<Annonce> annonces;
	
	public Matiere(String nom) {
		this.nom=nom;
	}

	public Matiere(){}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public Collection<Annonce> getAnnonces() {
		return annonces;
	}

}
