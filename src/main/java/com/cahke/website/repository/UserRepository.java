package com.cahke.website.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

import com.cahke.website.models.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByNome(String nome);
    List<User> findByNomeContainingIgnoreCase(String nome);
}
