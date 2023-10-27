package com.cahke.website.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cahke.website.models.User;
import com.cahke.website.services.UserService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class PesquisaController {
	private final UserService userService;

	public PesquisaController(UserService userService) {
		this.userService = userService;
	}
	@GetMapping("/pesquisar")
	public String pesquisar(
	        @RequestParam(name = "termos", required = false) List<String> termos,
	        @RequestParam(name = "remove_termos", required = false) String removeTermos,
	        Model model,	        
	        HttpServletRequest req) {
	    if (removeTermos != null) {
	        termos.remove(removeTermos);
	    }
	    List<User> users = new ArrayList<>();
	    List<String> termosUnicos = new ArrayList<>();

	    if (termos != null && !termos.isEmpty()) {
	        for (String termo : termos) {
	            if (!termosUnicos.contains(termo)) {
	            	System.out.println(termosUnicos.toString());
	            	System.out.println(termos.toString());
	                termosUnicos.add(termo);
	                List<User> usersPorNome = userService.findByNomeContainingIgnoreCase(termo);
	                users.addAll(usersPorNome);
	            }
	        }
	    } else {
	        users = userService.findAll();
	    }

	    model.addAttribute("termos", termosUnicos);
	    model.addAttribute("users", users);
	    return "dashboard";
	}
	@GetMapping("/limpar-filtros")
	public String limparFiltros() {
		return "redirect:/";
	}
}
