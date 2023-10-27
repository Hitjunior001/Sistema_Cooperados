package com.cahke.website.models;


import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;


import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;
	
	@Column(name = "nome")
	private String nome;
	
	@ManyToOne
	@JoinColumn(name= "cargo_id")
	private Cargo cargo;
	
	@Column(name = "salario")
	private Double salario;

	@Column(name = "idade")
	private int idade;

	@Column(name = "cidade")
	private String cidade;

	@Column(name = "ativo")
	private boolean ativo = true;
	
	@ManyToMany
	@JoinTable(
			name = "user_habilidade", 
			joinColumns = @JoinColumn(name = "user_id"), 
			inverseJoinColumns = @JoinColumn(name="habilidade_id")
			)
	private List<Habilidade> habilidades;

	@Column(name = "nivel_experiencia")
	private String nivelExperiencia;

	@Column(name = "modelo_atuacao")
	private String modeloAtuacao;

	@Column(name = "carga_horaria")
	private int cargaHoraria;

	@ManyToOne
	@JoinColumn(name = "estado_id")
	private Estado estado;

	@Column(name = "data_cadastro")
    private LocalDate dataCadastro; 	
    

    public User() {
    }
    
	public User(String nome, Cargo cargo, double salario, int idade, String cidade, Estado estado,
			boolean ativo, List<Habilidade> habilidades, String nivelExperiencia, String modeloAtuacao,
			int cargaHoraria, LocalDate dataCadastro) {
		this.nome = nome;
		this.cargo = cargo;
		this.salario = salario;
		this.idade = idade;
		this.cidade = cidade;
		this.estado = estado;
		this.ativo = ativo;
		this.habilidades = habilidades;
		this.nivelExperiencia = nivelExperiencia;
		this.modeloAtuacao = modeloAtuacao;
		this.cargaHoraria = cargaHoraria;
		this.dataCadastro = dataCadastro;
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

	public int getIdade() {
		return idade;
	}
	public String getCidade() {
		return cidade;
	}
	public Estado getEstado() {
		return estado;
	}
	public String getAtivo() {
		if(ativo == true) {
			return "Sim";
		}else{
			return "Não";
		}
	}
	public List<String> getHabilidades(){
		List<String> habilidadesStr = new ArrayList<>();
		for(Habilidade habilidade : habilidades) {
			habilidadesStr.add(habilidade.getNomeHabilidade());
		}
		return habilidadesStr;
	}
 	public String getNivelExperiencia() {
		return nivelExperiencia;
	}
	public String getModeloAtuacao() {
		return modeloAtuacao;
	}
	public int getCargaHoraria() {
		return cargaHoraria;
	}
	public LocalDate getDataCadastro() {
		return dataCadastro;
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
	@Override
	public String toString() {
	    return String.format("Usuário [id = %d, nome = %s, cargo = %s, salario = %.2f]", id, nome, cargo, salario);
	}

	
}
