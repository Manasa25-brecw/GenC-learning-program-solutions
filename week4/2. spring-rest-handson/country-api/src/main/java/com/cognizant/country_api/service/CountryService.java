package com.cognizant.country_api.service;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.cognizant.country_api.model.Country;

@Service
public class CountryService {
    public Country getCountryByCode(String code) {
        ApplicationContext context = new ClassPathXmlApplicationContext("config/country.xml");
        List<Country> countryList = (List<Country>) context.getBean("countryList");

        return countryList.stream()
                .filter(c -> c.getCode().equalsIgnoreCase(code))
                .findFirst()
                .orElse(null);
    }
}
