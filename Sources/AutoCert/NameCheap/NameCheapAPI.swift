import Foundation
import SWXMLHash

class NameCheapAPI {
    enum APIError: Error {
        case unknownStatus
        case responseError(String)
        case hostsParsingFailed
    }

    let config: NameCheapAPIConfig
    let networking: NetworkServiceProvider

    init(config: NameCheapAPIConfig, networking: NetworkServiceProvider) {
        self.config = config
        self.networking = networking
    }

    func getHosts(forDomain domain: String) async throws -> [NameCheapRecord] {
        let request = try URLRequest(url: config.makeURL(domain: domain, command: .getHosts))
        let data = try await networking.fetchData(request)
        let xml = XMLHash.parse(data)

        let apiResponse = xml["ApiResponse"]
        guard let status = apiResponse.element?.attribute(by: "Status")?.text else {
            throw APIError.unknownStatus
        }

        guard status == "OK" else {
            throw APIError.responseError(apiResponse["Errors"]["Error"][0].element?.text ?? "No error description")
        }

        let hostNodes = apiResponse["CommandResponse"]["DomainDNSGetHostsResult"]["host"].all
        let hosts = try hostNodes.compactMap { indexer in
            guard let properties = indexer.element?.allAttributes.mapValues(\.text) else {
                throw APIError.hostsParsingFailed
            }
            return NameCheapRecord(properties: properties)
        }

        return hosts
    }

    func setHosts(_ hosts: [NameCheapRecord], forDomain domain: String) async throws {
        var request = try URLRequest(url: config.makeURL(domain: domain, command: .setHosts))
        request.httpMethod = "POST"
        var argumentsList: [String] = []
        for (index, host) in hosts.enumerated() {
            try host.requestArguments().forEach { key, value in
                argumentsList.append("\(key)\(index + 1)=\(value)")
            }
        }
        let argumentsString = argumentsList.joined(separator: "&")
        print(argumentsString)
        request.httpBody = argumentsString.data(using: .utf8)

        let data = try await networking.fetchData(request)
        let xml = XMLHash.parse(data)

        let apiResponse = xml["ApiResponse"]
        guard let status = apiResponse.element?.attribute(by: "Status")?.text else {
            throw APIError.unknownStatus
        }

        guard status == "OK" else {
            throw APIError.responseError(apiResponse["Errors"]["Error"][0].element?.text ?? "No error description")
        }
    }
}

extension NameCheapAPI: NameCheapRepository {}
