package com.cahke.website.dto;

import com.cahke.website.models.Cargo;
import com.cahke.website.models.User;

public class UserDTO {
    private long id;
    private String nome;
    private Cargo cargo;
    private double salario;

    public UserDTO(User user) {
        this.id = user.getId();
        this.nome = user.getNome();
        this.cargo = user.getCargo();
        this.salario = user.getSalario();
    }
	public long getId() {
		return id;
	}
	public String getNome() {
		return nome;
	}
	public Cargo getCargo() {
		return cargo;
	}
	public double getSalario() {
		return salario;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public void setCargo(Cargo cargo) {
		this.cargo = cargo;
	}
	public void setSalario(double salario) {
		this.salario = salario;
	}
}

