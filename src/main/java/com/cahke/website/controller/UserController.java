package com.cahke.website.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cahke.website.models.Cargo;
import com.cahke.website.models.Estado;
import com.cahke.website.models.Habilidade;
import com.cahke.website.models.User;
import com.cahke.website.services.HabilidadeService;
import com.cahke.website.services.UserService;

@Controller
public class UserController {
	private final UserService userService;
	private final HabilidadeService habilidadeService;
	
	public UserController(UserService userService, HabilidadeService habilidadeService) {
		this.userService = userService;
		this.habilidadeService = habilidadeService;
	}

	@PostMapping("/create-user")
	public String criarUsuario(@RequestParam("nome") String nome, 
	        @RequestParam("cargo") Cargo cargo, 
	        @RequestParam("salario") Double salario,
	        @RequestParam("idade") int idade,
	        @RequestParam("cidade") String cidade,
	        @RequestParam("estado") Estado estado,
	        @RequestParam("habilidades") String habilidades,
	        @RequestParam("nivelExperiencia") String nivelExperiencia,
	        @RequestParam("modeloAtuacao") String modeloAtuacao,
	        @RequestParam("cargaHoraria") int cargaHoraria)
	{
	    LocalDate dataCadastro = LocalDate.now(); 
	    boolean ativo = true;
	    String[] habilidadeList = habilidades.split(",");
	    List<Habilidade> habilidadesMod = new ArrayList<>();
	    for(String habilidadeStr : habilidadeList) {
	        for(Habilidade habilidade : habilidadeService.findAll()) {
	            if(habilidadeStr.trim().equals(habilidade.getNomeHabilidade())) {
	                habilidadesMod.add(habilidade);
	            }

	        }
	    }
	    System.out.println(habilidadesMod);
	    userService.createUser(nome, cargo, salario, idade, cidade, estado, ativo, 
	    		habilidadesMod, nivelExperiencia, modeloAtuacao, cargaHoraria, dataCadastro);
	    
	    return "redirect:/admin";
	}
	
	@PostMapping("/delete-users")
	public String deleteAllUser() {
		List<User> users = userService.findAll();
		for(User user : users) {
			userService.deleteById(user.getId());
		}
		return "redirect:/admin?sucess=todos+usuarios+deletados";
	}
	@PostMapping(value= "/deleteuser")
	public String deleteById(@RequestParam("id") long id, RedirectAttributes redirectAttributes) {
		userService.deleteById(id);
		return "redirect:/admin?sucess=usuario+deletado+com+sucesso";
    }

	@PostMapping("/edituser")
	public String editUseById(@RequestParam("id") long id,
			@RequestParam("nome") String nome,
			@RequestParam("cargo") Cargo cargo,
			@RequestParam("salario") double salario) {
		User user = userService.findById(id).orElse(null);
		if(!nome.isEmpty()) {
			user.setNome(nome);
		}
		if(cargo != null) {
			user.setCargo(cargo);
		}
		if(salario <= 0) {
			user.setSalario(salario);
		}
		userService.save(user);
		return "redirect:/admin";
	}
}
