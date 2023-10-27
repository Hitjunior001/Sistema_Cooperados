package com.cahke.website.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cahke.website.models.Habilidade;
import com.cahke.website.repository.HabilidadeRepository;

@Service
public class HabilidadeService {

	private final HabilidadeRepository habilidadeRepository;
	
	public HabilidadeService(HabilidadeRepository habilidadeRepository) {
		this.habilidadeRepository = habilidadeRepository;
	}

	public List<Habilidade> findAll(){
		return habilidadeRepository.findAll();
	}
	public Habilidade save(Habilidade habilidade) {
		return habilidadeRepository.save(habilidade);
	}
}
