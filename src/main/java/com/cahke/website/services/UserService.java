package com.cahke.website.services;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.cahke.website.models.Cargo;
import com.cahke.website.models.Estado;
import com.cahke.website.models.Habilidade;
import com.cahke.website.models.User;
import com.cahke.website.repository.UserRepository;

@Service
public class UserService {
	private final UserRepository userRepository;
	
	public UserService(UserRepository userRepository) {
		this.userRepository = userRepository;
	}
	public List<User> findAll(){
		return userRepository.findAll();
	}
	public Optional<User> findById(long id){
		return userRepository.findById(id);
	}
	public User save(User user) {
		return userRepository.save(user);
	}
    public boolean deleteById(long id) {
    	if(id != 0) {
    		userRepository.deleteById(id);
    		return true;    		
    	} return false;
    }
    public User findByNome(String nome) {
    	return userRepository.findByNome(nome);
    }
    public List<User> findByNomeContainingIgnoreCase(String nome){
    	return userRepository.findByNomeContainingIgnoreCase(nome);
    }

    public boolean authenticate(String nome) {	
        User user = userRepository.findByNome(nome);
        if (user != null) {
            return true; // Autenticação bem-sucedida
        }
        return false; // Autenticação falhou
    }
    public boolean createUser(String nome, Cargo cargo, double salario, int idade, String cidade, Estado estado,
			boolean ativo,List<Habilidade> habilidades, String nivelExperiencia, String modeloAtuacao, int cargaHoraria, LocalDate dataCadastro) {
    	if(nome != null && cargo != null && salario >= 0) {
    		if(userRepository.findByNome(nome) == null) {
    			User user = new User(nome, cargo, salario, idade, cidade, estado, ativo, habilidades, nivelExperiencia, modeloAtuacao,
    					cargaHoraria, dataCadastro);
    			userRepository.save(user);
    			return true;
    		}
    	}
    	return false;
    }

       	
}
