package com.cahke.website.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cahke.website.services.*;

import jakarta.faces.context.FacesContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import com.cahke.website.models.*;

@Controller
@RequestMapping(value="/")
public class LoginController {
	private final UserService userService;
	
	public LoginController(UserService userService) {
		this.userService = userService;
	}
	@GetMapping("/login")
	public String getLogin() {
		return "login";
	}
	@PostMapping("/process-login")
	public String login(@RequestParam("nome") String nome) {
    boolean isValido = userService.authenticate(nome);
    if(isValido) {
    	return "logado";
    }else {
    	return "fail";
    }	
}
}	

