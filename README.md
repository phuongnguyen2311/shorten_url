# README
## How to install
- Install ruby 2.6.5
- Install rails 6.0.1
- Install Redis
- git clone url
- cd shortener_url
- bundle install
- bundle exec rails db:migrate
- rails s

## Run rspec for endpoint
- rspec spec/controllers/v1/*


### API endpoint
#### encode
- URL: {{host}}:4000/v1/encode
- Method: POST
- Params: url: string

#### decode
- URL: {{host}}:4000/v1/decode
- Method: POST
- Params: url: string

### Potential attack vectors on the application

- Cross-site scripting (XSS) attacks: An attacker could inject malicious code into the application, which would then execute when other users click on the shortened URL. This could allow the attacker to steal user credentials or perform other malicious actions.

- SQL injection attacks: If the application uses a database to store URLs or other user data, an attacker could manipulate the input fields to inject malicious SQL code. This could allow the attacker to view or modify sensitive data, such as user credentials.

- Denial of Service (DoS) attacks: An attacker could flood the application with requests or other traffic to overwhelm the server, causing it to crash or become unavailable. This could prevent legitimate users from accessing the application or its resources.

- Phishing attacks: An attacker could create a shortened URL that appears to be legitimate, but actually redirects users to a malicious site. This could allow the attacker to steal user credentials or install malware on the user's device.

- Brute-force attacks: An attacker could use automated tools to generate and test a large number of shortened URLs in an attempt to guess valid ones. This could allow the attacker to access sensitive data or perform other malicious actions.

- To mitigate these potential attack vectors, the application could implement input validation, sanitization, and encoding to prevent injection attacks. It could also limit the number of requests per user to prevent DoS attacks, and implement multi-factor authentication to prevent phishing attacks. Regular security testing and vulnerability assessments can also help identify and address potential weaknesses in the application's security.

- Beside of we need setting for secure application as:
- 1. Set the "secure" flag on the cookie: This ensures that the cookie is only sent over HTTPS connections, which adds an extra layer of security.

- 2. Set the "HttpOnly" flag on the cookie: This prevents the cookie from being accessed by JavaScript, which helps protect against cross-site scripting (XSS) attacks.

- 3. Set the "max-age" or "expires" attribute to make the cookie read-only: This sets a specific time period for how long the cookie will be valid, after which it will expire and become read-only.
- We can use a 3rd service like Cloudflare or Aws Shield to protect application attacks

## Solution for scale up and resolve problem the duplicate or collision

* 
 