package com.cahke.website.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cargos")
public class Cargo {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long cargoId;
	@Column(name = "cargoNome", unique = true)
	private String cargoNome;
	 
	public Cargo(){
	}
	
	public Cargo(String cargoNome) {
		this.cargoNome = cargoNome;
	}
	public long getCargoId() {
		return cargoId;
	}
	public String getCargoNome() {
		return cargoNome;
	}	
	public void setCargoId(long cargoId) {
		this.cargoId = cargoId;
	}
	public void setCargoNome(String cargoNome) {
		this.cargoNome = cargoNome;
	}
}

