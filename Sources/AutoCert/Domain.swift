import Foundation

final class Domain {
    let service: DomainService

    init(service: DomainService) {
        self.service = service
    }
}

extension Domain: DomainAuthentication {
    func authenticate(with record: HostRecord) async throws {
        try await service.addOrReplace(record)
        // TODO: verify authentication
    }
}
