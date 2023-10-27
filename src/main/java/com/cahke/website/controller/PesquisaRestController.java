package com.cahke.website.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cahke.website.models.Estado;
import com.cahke.website.models.Habilidade;
import com.cahke.website.models.User;
import com.cahke.website.services.EstadoService;
import com.cahke.website.services.HabilidadeService;
import com.cahke.website.services.UserService;

@RestController
@RequestMapping(value = "/api")
public class PesquisaRestController {
	
	private final HabilidadeService habilidadeService;
	private final UserService userService;
	private final EstadoService estadoService;
	
	public PesquisaRestController(HabilidadeService habilidadeService,UserService userService, EstadoService estadoService) {
		this.habilidadeService = habilidadeService;
		this.userService = userService;
		this.estadoService = estadoService;
	}

	@GetMapping(value = "/habilidades")
	public List<Habilidade> getHabilidades(){
		
		List<Habilidade> habilidades = habilidadeService.findAll();
		return habilidades;
	}
	@GetMapping(value = "/usuarios")
	public List<User> getUsers(){
		List<User> usuarios = userService.findAll();
		return usuarios;
	}
	@GetMapping(value = "/estados")
	public List<Estado> getEstados(){
		List<Estado> estados = estadoService.findAll();
		return estados;
	}
}
