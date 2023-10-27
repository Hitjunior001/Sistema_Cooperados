package com.cahke.website.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "estados")
public class Estado {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long estado_id;
	
	@Column(name = "sigla_estado", columnDefinition="VARCHAR(2)")
	private String siglaEstado;
	
	@Column(name = "nome_estado")
	private String nomeEstado;
	
	public Estado() {
	}
	
	public Estado(String siglaEstado, String nomeEstado) {
		this.siglaEstado = siglaEstado;
		this.nomeEstado = nomeEstado;
	}
	
	public long getIdEstado() {
		return estado_id;
	}
	public String getSiglaEstado() {
		return siglaEstado;
	}
	public String getNomeEstado() {
		return nomeEstado;
	}
	
	public void setNomeEstado(String nomeEstado) {
		this.nomeEstado = nomeEstado;
	}
}

