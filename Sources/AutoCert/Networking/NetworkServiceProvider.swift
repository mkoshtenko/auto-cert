import Foundation

enum NetworkServiceError: Error {
    case missingURL
}

protocol NetworkServiceProvider {
    func fetchData(_ request: URLRequest) async throws -> Data
}
