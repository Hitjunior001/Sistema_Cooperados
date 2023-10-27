package com.cahke.website.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "habilidades")
public class Habilidade {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long habilidade_id;
	
	@Column(name = "nome_habilidade")
	private String nomeHabilidade;
	
	public Habilidade() {
		
	}
	public Habilidade(String nomeHabilidade) {
		this.nomeHabilidade = nomeHabilidade;
	}
	public long getIdHabilidade() {
		return habilidade_id;
	} 
	public String getNomeHabilidade() {
		return nomeHabilidade;
	}
}
