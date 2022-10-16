import XCTest
@testable import AutoCert

final class HostRecordTests: XCTestCase {
    func testInitWithDomain() {
        let parent = BaseEntity(parent: nil, properties: [:])
        let hostRecord = HostRecord(parent: parent, domain: "a.b")
        XCTAssertTrue(hostRecord.domain == "a.b")
    }
}
