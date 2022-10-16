import Foundation

protocol DomainService {
    func addOrReplace(_ record: HostRecord) async throws
}
