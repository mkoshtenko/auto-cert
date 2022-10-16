import Foundation

final class CertBotController {
    let domain: Domain
    let recordFactory: CertBotRecordFactory

    init(domain: Domain, recordFactory: CertBotRecordFactory) {
        self.domain = domain
        self.recordFactory = recordFactory
    }

    func authenticateDomain(with command: CertBotCommand) async throws {
        let authRecord = recordFactory.makeAuthRecord(command: command)
        try await domain.authenticate(with: authRecord)
    }
}
