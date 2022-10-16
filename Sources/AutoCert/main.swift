import Foundation

extension NameCheapAPIConfig {
    static var almondmilkdev: NameCheapAPIConfig {
        NameCheapAPIConfig(
            host: .prod,
            apiKey: "abcde123",
            loginId: "almondmilkdev",
            clientIp: "1.1.1.1"
        )
    }
}

extension CertBotCommand {
    static var avolabInfo: CertBotCommand {
        CertBotCommand(
            domain: "my.com",
            validation: "abcd",
            token: "__TOKEN__",
            remainingClallenges: 0,
            allDomains: ""
        )
    }
}

let api = NameCheapAPI(config: .almondmilkdev, networking: URLSession.shared)
let service = NameCheapService(api: api)
let controller = CertBotController(domain: Domain(service: service), recordFactory: NameCheapRecordFactory())
do {
    try await controller.authenticateDomain(with: .avolabInfo)
} catch {
    preconditionFailure(error.localizedDescription)
}
