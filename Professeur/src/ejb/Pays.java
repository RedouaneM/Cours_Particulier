package ejb;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Pays {


	@Id
	private String nom;
	
	private String code;

	
	public Pays(){}



	public String getNom() {
		return nom;
	}


	public void setNom(String nom) {
		this.nom = nom;
	}


	public String getCode() {
		return code;
	}


	public void setCode(String code) {
		this.code = code;
	}
	
	
}
