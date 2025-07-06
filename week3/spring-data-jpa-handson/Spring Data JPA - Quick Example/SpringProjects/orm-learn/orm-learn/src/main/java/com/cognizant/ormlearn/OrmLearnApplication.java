package com.cognizant.ormlearn;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import com.cognizant.ormlearn.model.Country;
import com.cognizant.ormlearn.repository.CountryRepository;

@SpringBootApplication
public class OrmLearnApplication {

    public static void main(String[] args) {
        SpringApplication.run(OrmLearnApplication.class, args);
        System.out.println("Started OrmLearnApplication...");
    }

    @Bean
    public CommandLineRunner run(CountryRepository countryRepository) {
        return args -> {
            Country country = new Country();
            country.setCode("IN");
            country.setName("India");

            countryRepository.save(country);
            System.out.println("Saved country: " + country);
        };
    }
}
