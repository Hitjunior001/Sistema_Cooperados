package com.cahke.website;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.servlet.*;

import com.cahke.website.controller.HomeController;
import com.cahke.website.models.*;
import com.cahke.website.services.*;

@SpringBootTest
class WebsiteApplicationTests {
	private CargoService cargoService;
	private EstadoService estadoService;
	private UserService userService;
	private HomeController homeController;
	private MockMvc mockMvc;
	
	private WebsiteApplicationTests(CargoService cargoService, EstadoService estadoService, UserService userService) {
		this.cargoService = cargoService;
		this.estadoService = estadoService;
		this.userService = userService;
	}

	@Test
	void contextLoads() {
	}
//	@Test
//    @DisplayName("Verifica se retorna os úsuarios, cargos e etc.")
//	public void testDashboard() throws Exception {
//		Cargo cargo = new Cargo("Desenvolvedor BackEnd");
//		Estado estado = new Estado("DF", "Distrito Federal");
//		User user = new User("UserTest", cargo, 0, 0, null, estado, false, null, null, 0, null);
//		
//		if(cargoService.save(cargo) != null) {
//			System.out.print("ok");
//		}
//		if(estadoService.save(estado) != null) {
//			System.out.print("ok");
//		}
//		if(userService.save(user) != null) {
//			System.out.print("ok");
//		}
//	}

}
