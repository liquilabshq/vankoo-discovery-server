package com.liquilabs.vankoo.discovery;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class VankooDiscoveryServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(VankooDiscoveryServerApplication.class, args);
    }

}
