package com.cahke.website.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cahke.website.models.Cargo;
import com.cahke.website.services.CargoService;

@Controller
public class CargoController {
	private final CargoService cargoService;
	
	public CargoController(CargoService cargoService) {
		this.cargoService = cargoService;
	}
	@PostMapping(value = "/cargo/criar")
	public String criarCargo(@RequestParam(name="cargoNome") String cargoNome) {
		if(cargoNome != null) {
			Cargo cargo = new Cargo(cargoNome);
			cargoService.save(cargo);
		}
		return "redirect:/admin";
	}
	@GetMapping(value = "/cargo/cargos")
	public String getCargos(Model model) {
		List<Cargo >cargos = cargoService.findAll();
		model.addAttribute("cargos", cargos);
		return "cargos";
		
	}

}
