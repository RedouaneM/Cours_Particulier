package ejb;

import java.util.Collection;

public class Couple_AP {

	private Annonce a;
	private Collection<Personne> personnes;
	
	
	public Couple_AP(Annonce a, Collection<Personne> personnes){
		this.a = a;
		this.personnes = personnes;
	}


	public Annonce getAnnonce_AP() {
		return a;
	}


	public Collection<Personne> getPersonnes_AP() {
		return personnes;
	}
	
}
