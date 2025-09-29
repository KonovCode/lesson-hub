# Security Policy

## Supported Versions

We actively support the following versions with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | :white_check_mark: |

## Reporting a Vulnerability

We take the security of Lesson Hub seriously. If you discover a security vulnerability, please report it responsibly.

### How to Report

1. **DO NOT** create a public GitHub issue
2. Send details to: [security@your-domain.com](mailto:security@your-domain.com)
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

### What to Expect

- **Acknowledgment:** We'll acknowledge your report within 24 hours
- **Updates:** Regular updates on our progress every 72 hours
- **Timeline:** We aim to resolve critical issues within 7 days
- **Credit:** Security researchers will be credited (unless requested otherwise)

### Scope

Security issues in scope:
- Authentication bypass
- SQL injection
- Cross-site scripting (XSS)
- Cross-site request forgery (CSRF)
- Server-side request forgery (SSRF)
- Remote code execution
- Data exposure

Out of scope:
- Social engineering
- Physical security
- Denial of service attacks
- Issues in third-party dependencies

## Security Measures

Our application implements:

- **Authentication:** JWT-based authentication
- **Authorization:** Role-based access control
- **Input Validation:** Symfony Validator component
- **SQL Injection Protection:** Doctrine ORM with prepared statements
- **CSRF Protection:** Symfony CSRF tokens
- **HTTPS:** All production traffic encrypted
- **Security Headers:** CSP, HSTS, X-Frame-Options
- **Rate Limiting:** API rate limiting enabled
- **Error Handling:** No sensitive information in error responses

## Development Security

For developers:

1. Never commit secrets to version control
2. Use `.env.local` for local development secrets
3. Regularly update dependencies
4. Follow secure coding practices
5. Enable all security features in production

## Contact

For security-related questions: [security@your-domain.com](mailto:security@your-domain.com)