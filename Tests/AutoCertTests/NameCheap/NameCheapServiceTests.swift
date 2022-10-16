import XCTest
@testable import AutoCert

final class NameCheapServiceTests: XCTestCase {
    let apiMock = NameCheapRepositoryMock()
    var sut: NameCheapService!

    override func setUp() {
        super.setUp()
        sut = NameCheapService(api: apiMock)
    }


    func testAddOrReplace_withNoExistingHosts_callsSetHostWithNewRecord() async throws {
        let record = NameCheapRecord.fixture()
        let hostRecord = HostRecord(parent: record, domain: "a")
        try await sut.addOrReplace(hostRecord)

        let arguments = try XCTUnwrap(apiMock.setHostsArguments)
        XCTAssertEqual(arguments.count, 1)
        XCTAssertTrue(arguments.first?.name == "name")
    }

    func testAddOrReplace_whenHasHosts_callsSetHostWithOldAndNewRecords() async throws {
        apiMock.getHostsResults.append(.fixture(name: "old"))

        let record = NameCheapRecord.fixture(name: "new")
        let hostRecord = HostRecord(parent: record, domain: "a")
        try await sut.addOrReplace(hostRecord)

        let arguments = try XCTUnwrap(apiMock.setHostsArguments)
        XCTAssertEqual(arguments.count, 2)
        XCTAssertEqual(arguments.first?.name, "old")
        XCTAssertEqual(arguments.last?.name, "new")
    }

    func testAddOrReplace_whenSameRecordExists_callsSetHostWithNewRecord() async throws {
        apiMock.getHostsResults.append(.fixture())

        let record = NameCheapRecord.fixture()
        let hostRecord = HostRecord(parent: record, domain: "a")
        try await sut.addOrReplace(hostRecord)

        let arguments = try XCTUnwrap(apiMock.setHostsArguments)
        XCTAssertEqual(arguments.count, 1)
        XCTAssertTrue(arguments.first?.name == "name")
    }
}

private extension NameCheapRecord {
    static func fixture(name: String = "name") -> NameCheapRecord {
        NameCheapRecord(properties: [
            Keys.name: name
        ])
    }
}
