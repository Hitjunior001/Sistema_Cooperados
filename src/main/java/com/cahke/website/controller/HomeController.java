package com.cahke.website.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cahke.website.dto.UserDTO;
import com.cahke.website.models.Cargo;
import com.cahke.website.models.Estado;
import com.cahke.website.models.User;
import com.cahke.website.repository.CargoRepository;
import com.cahke.website.repository.EstadoRepository;
import com.cahke.website.repository.UserRepository;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

@Controller
public class HomeController {
	private final UserRepository userRepository;
	private final CargoRepository cargoRepository;
	private final EstadoRepository estadoRepository;
	
	public HomeController(UserRepository userRepository,CargoRepository cargoRepository, EstadoRepository estadoRepository) {
		this.userRepository = userRepository;
		this.cargoRepository = cargoRepository;
		this.estadoRepository = estadoRepository;

	}
	@RequestMapping(value="/")
	@GetMapping(value="/")
	public String loadDashboard(Model model) {
	    List<User> users = userRepository.findAll();
	    List<Cargo> cargos = cargoRepository.findAll();
	    model.addAttribute("users", users);
	    model.addAttribute("cargos", cargos);
	    return "dashboard"; 
	}
	@GetMapping(value="/admin")
	public String loadCriacao(Model model) {
	    List<Cargo> cargos = cargoRepository.findAll();
	    List<Estado> estados = estadoRepository.findAll();
	    List<User> users = userRepository.findAll();

	    model.addAttribute("users", users);
	    model.addAttribute("cargos", cargos);
	    model.addAttribute("estados", estados);
	    return "criar_usuario"; 
	}
	@GetMapping(value="/pesquisa")
	public String loadPesquisa() {
		return "pesquisa";
	}
	@GetMapping(value="/newdashboard")
	public String loadNewDashboard() {
		return "dashboardNew";
	}

	
}	
