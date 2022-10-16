import XCTest
@testable import AutoCert

extension CertBotCommand {
    static func fixture() -> CertBotCommand {
        CertBotCommand(
            domain: "domain",
            validation: "abc",
            token: "token",
            remainingClallenges: 123,
            allDomains: "all,domains"
        )
    }
}
