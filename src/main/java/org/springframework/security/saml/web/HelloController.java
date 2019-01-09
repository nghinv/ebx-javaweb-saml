package org.springframework.security.saml.web;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class HelloController {

    @Value("${saml.redirectAfterSuccessfulLogin.url}")
    private String redirectAfterSuccessfulLogin;

    public String getRedirectAfterSuccessfulLogin() {
        return redirectAfterSuccessfulLogin;
    }

}
