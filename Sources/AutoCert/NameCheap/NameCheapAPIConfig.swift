import Foundation

struct NameCheapAPIConfig {
    enum URLError: Error {
        case cannotCreateURL(NameCheapAPICommand)
    }

    enum Host: String {
        case prod = "api.namecheap.com"
        case sandbox = "api.sandbox.namecheap.com"
    }

    let host: Host
    let apiKey: String
    let loginId: String
    let clientIp: String

    func makeURL(domain: String, command: NameCheapAPICommand) throws -> URL {
        // TODO: throw an exception if the domain is not valid
        var components = URLComponents()
        components.scheme = "https"
        components.host = host.rawValue
        components.path = "/xml.response"
        components.queryItems = [
            .init(name: "ApiKey", value: apiKey),
            .init(name: "APIUser", value: loginId),
            .init(name: "UserName", value: loginId),
            .init(name: "ClientIp", value: clientIp),
            .init(name: "Command", value: command.rawValue),
            .init(name: "SLD", value: domain.components(separatedBy: ".")[0]),
            .init(name: "TLD", value: domain.components(separatedBy: ".")[1])
        ]
        guard let url = components.url else {
            throw URLError.cannotCreateURL(command)
        }
        return url
    }
}
