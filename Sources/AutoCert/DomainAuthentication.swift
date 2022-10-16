import Foundation

protocol DomainAuthentication {
    func authenticate(with: HostRecord) async throws
}
