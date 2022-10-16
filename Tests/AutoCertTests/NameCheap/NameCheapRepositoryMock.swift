import Foundation
@testable import AutoCert

final class NameCheapRepositoryMock: NameCheapRepository {
    var getHostsResults: [AutoCert.NameCheapRecord] = []
    func getHosts(forDomain domain: String) async throws -> [NameCheapRecord] {
        getHostsResults
    }

    var setHostsArguments: [AutoCert.NameCheapRecord]?
    func setHosts(_ hosts: [AutoCert.NameCheapRecord], forDomain domain: String) async throws {
        setHostsArguments = hosts
    }
}
