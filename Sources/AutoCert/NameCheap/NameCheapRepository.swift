import Foundation

protocol NameCheapRepository {
    func getHosts(forDomain domain: String) async throws -> [NameCheapRecord]
    func setHosts(_ hosts: [NameCheapRecord], forDomain domain: String) async throws
}
