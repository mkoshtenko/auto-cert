import Foundation

final class NameCheapRecordFactory: CertBotRecordFactory {
    func makeAuthRecord(command: CertBotCommand) -> HostRecord {
        let nameCheapRecord = NameCheapRecord.acmeChallenge(value: command.validation)
        return HostRecord(parent: nameCheapRecord, domain: command.domain)
    }
}

private extension NameCheapRecord {
    static let acmeName = "_acme-challenge"

    static func acmeChallenge(value: String) -> NameCheapRecord {
        NameCheapRecord(properties: [
            Keys.name: acmeName,
            Keys.type: "TXT",
            Keys.address: value
        ])
    }
}
