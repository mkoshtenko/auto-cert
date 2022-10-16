import Foundation

extension URLSession: NetworkServiceProvider {
    func fetchData(_ request: URLRequest) async throws -> Data {
        guard let urlString = request.url?.absoluteString else {
            throw NetworkServiceError.missingURL
        }
        log(urlString)
        let (data, response) = try await data(for: request)
        log(response.description)
        return data
    }

    private func log(_ string: String) {
        print("url-session", string, separator: "/")
    }
}
