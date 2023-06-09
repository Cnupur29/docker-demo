package com.schaudha.dockerdemo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {

    @GetMapping("/test-docker")
    public String getResult(){
        return "hello";
    }
}
