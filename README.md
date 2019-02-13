# ebx-javaweb-saml

## requirements

### requirement 1

download and setup https://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html

unzip and read the readme.txt

### requirement 2

add folder 'libSaml/deps/*.jar' to Tomcat common.loader

### requirement 3

add tomcat-oidcauth-2.2.3-Tomcat9.0.jar to Tomcat/lib, see bitbucket.org:mickaelgermemont/tomcat-oidcauth

add tomcat-realm-ebx-1.0.0-SNAPSHOT.jar to Tomcat/lib, see bitbucket.org:mickaelgermemont/tomcat-realm-ebx

in server.xml, configure the EBX Ream

if you use OpenIDConnect and Azure AD (OAuth), in server.xml or separate context, add valve OpenIDConnectAuthenticator to the oidc webapp (to know the providers parameter value, see documentation https://github.com/boylesoftware/tomcat8-oidcauth)

if you use SAML, in server.xml or separate context, add valve SamlAuthenticator to the saml webapp

```
<Engine defaultHost="localhost" name="Catalina">
	<Realm className="org.apache.catalina.realm.LockOutRealm">
		<Realm className="com.tibco.ps.ebx.catalina.realm.EBXRealm" createIfNotExist="true"/>
	</Realm>
	<Host appBase="webapps" autoDeploy="true" name="localhost" unpackWARs="true">
		<Valve className="org.apache.catalina.authenticator.SingleSignOn"/>
		
		<Context docBase="tomcat8-oidcauth-sample" path="/oidc">
			<Valve additionalScopes="email profile" className="org.bsworks.catalina.authenticator.oidc.tomcat90.OpenIDConnectAuthenticator" providers="....." usernameClaim="email"/>
		</Context>
	
		<Context docBase="saml" path="/saml">
			<Valve className="org.bsworks.catalina.authenticator.oidc.tomcat90.SamlAuthenticator"/>
		</Context>
	</Host>
</Engine>
```

## build

mvn clean install

## configuration

configure Tomcat startup and include the following parameter

-Dsaml.conf.location=file:/Users/mickaelgermemont/src/github.com/mickaelgermemont/java-saml/samlconf.properties
-Dsaml.conf.location=classpath:samlconf.properties

<Connector SSLEnabled="true" clientAuth="false" keystoreFile="${keystore.location}" keystorePass="ebx tomcat password" maxThreads="150" port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol" scheme="https" secure="true" sslProtocol="TLS"/>

## distribution

cp target/saml-0.0.5-SNAPSHOT.war ../tomcat-saml/saml.war && cp target/saml-0.0.5-SNAPSHOT.war ../tomcat-saml-ebx/saml.war

## References

valid values for 'signatureAlgorithmURI'

```
=== Supported Signatures ===
http://www.w3.org/2000/09/xmldsig#dsa-sha1
http://www.w3.org/2000/09/xmldsig#dsa-sha1
http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha1
http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha256
http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha384
http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha512
http://www.w3.org/2001/04/xmldsig-more#rsa-md5
http://www.w3.org/2000/09/xmldsig#rsa-sha1
http://www.w3.org/2001/04/xmldsig-more#rsa-ripemd160
http://www.w3.org/2000/09/xmldsig#rsa-sha1
http://www.w3.org/2001/04/xmldsig-more#rsa-sha256
http://www.w3.org/2001/04/xmldsig-more#rsa-sha384
http://www.w3.org/2001/04/xmldsig-more#rsa-sha512
```

valid values for 'signatureReferenceDigestMethod'

```
=== Supported Digests ===
http://www.w3.org/2001/04/xmldsig-more#md5
http://www.w3.org/2001/04/xmlenc#ripemd160
http://www.w3.org/2000/09/xmldsig#sha1
http://www.w3.org/2001/04/xmlenc#sha256
http://www.w3.org/2001/04/xmldsig-more#sha384
http://www.w3.org/2001/04/xmlenc#sha512
```

## samlconf

AuthenticationName

sending to EBX
- FirstName
- LastName
- EmailAddress
- AuthenticationName
- AuthenticationPrincipal
- CredentialNameIdValue
