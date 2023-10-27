package com.cahke.website.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cahke.website.models.Estado;
import com.cahke.website.repository.EstadoRepository;

@Service
public class EstadoService {
	private final EstadoRepository estadoRepository;
	
	public EstadoService(EstadoRepository estadoRepository) {
		this.estadoRepository = estadoRepository;
	}
	
	public List<Estado> findAll(){
		return this.estadoRepository.findAll();
	}
	
	public Estado save(Estado estado) {
		return this.estadoRepository.save(estado);
	}

}
