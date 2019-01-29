<%@page import="com.orchestranetworks.ps.customDirectory.directory.sso.SSOUserAuthenticatedBean"%>
<%@page import="com.orchestranetworks.ps.customDirectory.YourDirectory"%>
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.springframework.security.saml.util.SAMLUtil"%>
<%@page import="org.opensaml.xml.util.XMLHelper"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="com.on.ps.security.saml.MappingEbxSamlCredentials"%>
<%@page import="org.springframework.security.saml.SAMLCredential"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.saml.web.HelloController"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>

<%
	final WebApplicationContext webApplicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext());
	final String label_str = ((HelloController)webApplicationContext.getBean("hellocontrlr")).getRedirectAfterSuccessfulLogin();

	if(label_str.equals("/index_ebx.jsp")){
		final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		final SAMLCredential credential = (SAMLCredential) authentication.getCredentials();
		final MappingEbxSamlCredentials mapping = (MappingEbxSamlCredentials) webApplicationContext.getBean("myMappingEbxSamlCredentials");

		pageContext.setAttribute("authentication", authentication);
		pageContext.setAttribute("credential", credential);
		pageContext.setAttribute("assertion", XMLHelper.nodeToString(SAMLUtil.marshallMessage(credential.getAuthenticationAssertion())));

		System.out.println("SESSIONID="+session.getId());

		final Map<String, Object> values = new HashMap<String, Object>();
		values.put("SAML_AuthenticationName", authentication.getName());
		values.put("SAML_AuthenticationPrincipal", authentication.getPrincipal().toString());
		values.put("SAML_CredentialNameIdValue", credential.getNameID().getValue());
		values.put("SAML_UserID", credential.getAttributeAsString(mapping.getUserID()));
		values.put("SAML_EmailAddress", credential.getAttributeAsString(mapping.getEmailAddress()));
		values.put("SAML_FirstName", credential.getAttributeAsString(mapping.getFirstName()));
		values.put("SAML_LastName", credential.getAttributeAsString(mapping.getLastName()));
		
		YourDirectory.setSSOAuthenticationData(session.getId(), new SSOUserAuthenticatedBean(values));

		response.sendRedirect("/ebx");

	} else if(label_str.equals("/")){
		response.sendRedirect("/saml/index.jsp");
	} else {
		response.sendRedirect("/saml/"+label_str);
	}
%>
