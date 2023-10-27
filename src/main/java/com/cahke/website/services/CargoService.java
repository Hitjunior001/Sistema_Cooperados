package com.cahke.website.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cahke.website.models.Cargo;
import com.cahke.website.repository.CargoRepository;

@Service
public class CargoService {
	
	private final CargoRepository cargoRepository;
	
	public CargoService(CargoRepository cargoRepository) {
		this.cargoRepository = cargoRepository;
	}
	public Cargo save(Cargo cargo) {
		return cargoRepository.save(cargo);
	}
	public Optional<Cargo> findById(long cargoId){
		return cargoRepository.findById(cargoId);
	}
	public List<Cargo> findAll() {
		return cargoRepository.findAll();	
		}
}
