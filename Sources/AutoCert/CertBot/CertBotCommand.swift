import Foundation

/**
 Certbot will pass us these variables:
 - CERTBOT_DOMAIN: The domain being authenticated
 - CERTBOT_VALIDATION: The validation string
 - CERTBOT_TOKEN: Resource name part of the HTTP-01 challenge (HTTP-01 only)
 - CERTBOT_REMAINING_CHALLENGES: Number of challenges remaining after the current challenge
 - CERTBOT_ALL_DOMAINS: A comma-separated list of all domains challenged for the current
 */
struct CertBotCommand {
    // The domain being authenticated
    let domain: String
    // The validation string
    let validation: String
    // Resource name part of the HTTP-01 challenge (HTTP-01 only)
    let token: String
    // Number of challenges remaining after the current challenge
    let remainingClallenges: Int
    // A comma-separated list of all domains challenged for the current
    let allDomains: String
}
