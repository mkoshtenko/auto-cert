import Foundation

protocol CertBotRecordFactory {
    func makeAuthRecord(command: CertBotCommand) -> HostRecord
}
