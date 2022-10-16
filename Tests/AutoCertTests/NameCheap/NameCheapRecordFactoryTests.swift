import XCTest
@testable import AutoCert

final class NameCheapRecordFactoryTests: XCTestCase {
    let sut = NameCheapRecordFactory()

    func testMakeAuthRecord() {
        let record = sut.makeAuthRecord(command: .fixture())

        XCTAssertEqual(record.domain, "domain")
        XCTAssertEqual(record.value(forKey: "Name"), "_acme-challenge")
        XCTAssertEqual(record.value(forKey: "Type"), "TXT")
        XCTAssertEqual(record.value(forKey: "Address"), "abc")
    }
}
