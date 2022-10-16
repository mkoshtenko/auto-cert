import XCTest
@testable import AutoCert

final class NameCheapAPIConfigTests: XCTestCase {
    let config = NameCheapAPIConfig(
        host: .prod,
        apiKey: "a",
        loginId: "b",
        clientIp: "c"
    )

    func testMakeUrlUsesGetHostsCommand() throws {
        let url = try config.makeURL(domain: "test.com", command: .getHosts)

        let queryItems = url.allQueryItems
        XCTAssertEqual(queryItems["Command"], "namecheap.domains.dns.getHosts")
    }

    func testMakeUrlUsesSetHostsCommand() throws {
        let url = try config.makeURL(domain: "test.com", command: .setHosts)

        let queryItems = url.allQueryItems
        XCTAssertEqual(queryItems["Command"], "namecheap.domains.dns.setHosts")
    }

    func testMakeURLSetsCorrectQueryItems() throws {
        let url = try config.makeURL(domain: "test.com", command: .setHosts)

        let queryItems = url.allQueryItems
        XCTAssertEqual(queryItems["ApiKey"], "a")
        XCTAssertEqual(queryItems["APIUser"], "b")
        XCTAssertEqual(queryItems["UserName"], "b")
        XCTAssertEqual(queryItems["ClientIp"], "c")
        XCTAssertEqual(queryItems["SLD"], "test")
        XCTAssertEqual(queryItems["TLD"], "com")
    }

    func testMakeURLString() throws {
        let url = try config.makeURL(domain: "test.com", command: .getHosts)
        XCTAssertEqual(
            url.absoluteString,
            "https://api.namecheap.com/xml.response?ApiKey=a&APIUser=b&UserName=b&ClientIp=c&Command=namecheap.domains.dns.getHosts&SLD=test&TLD=com"
        )
    }
}

private extension URL {
    var allQueryItems: [String: String] {
        guard let items = URLComponents(url: self, resolvingAgainstBaseURL: true)?.queryItems else {
            return [:]
        }
        return items.reduce(into: [:]) { result, item in
            result[item.name] = item.value
        }
    }
}
