import XCTest
@testable import AutoCert

final class NameCheapRecordTests: XCTestCase {
    func testInitWithProperties() {
        let entity = NameCheapRecord(properties: ["a": "b"])
        XCTAssertEqual(entity.value(forKey: "a"), "b")
    }

    func testInitWithParent() {
        let parent = BaseEntity(parent: nil, properties: ["a": "b"])
        let hostRecord = HostRecord(parent: parent, domain: "c.d")
        let sut = NameCheapRecord(record: hostRecord)
        XCTAssertEqual(sut.value(forKey: "a"), "b")
        XCTAssertEqual(sut.value(forKey: HostRecord.Keys.domain), "c.d")
    }

    func testNameReturnsValueFromProperties() {
        let entity = NameCheapRecord(properties: ["Name": "a"])
        XCTAssertEqual(entity.name, "a")
    }

    func testRequestArguments_withAllFields_returnsCorrectArguments() throws {
        let sut = NameCheapRecord.fixture()
        let arguments = try sut.requestArguments()

        XCTAssertEqual(arguments["HostName"], "a")
        XCTAssertEqual(arguments["RecordType"], "b")
        XCTAssertEqual(arguments["Address"], "c")

        // Optional arguments
        XCTAssertEqual(arguments["IsDDNSEnabled"], "d")
        XCTAssertEqual(arguments["MXPref"], "e")
        XCTAssertEqual(arguments["TTL"], "f")
        XCTAssertEqual(arguments["FriendlyName"], "g")
        XCTAssertEqual(arguments["IsActive"], "h")
        XCTAssertEqual(arguments["HostId"], "i")
        XCTAssertEqual(arguments["AssociatedAppTitle"], "j")
    }

    func testRequestArguments_noOptionalFields_noOptionalArgumentsAdded() throws {
        let sut = NameCheapRecord.fixture(incudeOptional: false)
        let arguments = try sut.requestArguments()

        XCTAssertNil(arguments["IsDDNSEnabled"])
        XCTAssertNil(arguments["MXPref"])
        XCTAssertNil(arguments["TTL"])
        XCTAssertNil(arguments["FriendlyName"])
        XCTAssertNil(arguments["IsActive"])
        XCTAssertNil(arguments["HostId"])
        XCTAssertNil(arguments["AssociatedAppTitle"])
    }

    func testRequestArguments_noName_throwsException() {
        let sut = NameCheapRecord.fixture(name: nil)
        XCTAssertThrowsError(try sut.requestArguments())
    }

    func testRequestArguments_noType_throwsException() {
        let sut = NameCheapRecord.fixture(type: nil)
        XCTAssertThrowsError(try sut.requestArguments())
    }

    func testRequestArguments_noAddress_throwsException() {
        let sut = NameCheapRecord.fixture(address: nil)
        XCTAssertThrowsError(try sut.requestArguments())
    }
}

private extension NameCheapRecord {
    static func fixture(
        name: String? = "a",
        type: String? = "b",
        address: String? = "c",
        incudeOptional: Bool = true
    ) -> NameCheapRecord {
        var properties: [String: String] = [:]
        if let name = name {
            properties[Keys.name] = name
        }
        if let type = type {
            properties[Keys.type] = type
        }
        if let address = address {
            properties[Keys.address] = address
        }
        if incudeOptional {
            properties[Keys.isDDNS] = "d"
            properties[Keys.mxPref] = "e"
            properties[Keys.ttl] = "f"
            properties[Keys.friendlyName] = "g"
            properties[Keys.isActive] = "h"
            properties[Keys.hostId] = "i"
            properties[Keys.associatedAppTitle] = "j"
        }
        return NameCheapRecord(properties: properties)
    }
}
