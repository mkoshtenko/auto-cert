import XCTest
@testable import AutoCert

final class BaseEntityTests: XCTestCase {
    fileprivate let mockParent = MockEntity()

    override func setUp() {
        super.setUp()
        mockParent.valueForKey(willReturn: 100)
    }

    func testHasValueForKey_whenNotSet_returnsFalse() {
        let entity = BaseEntity.fixture()
        XCTAssertFalse(entity.hasValue(forKey: "a"))
    }

    func testHasValueForKey_whenNotSetAndParentFalse_returnsFalse() {
        let entity = BaseEntity.fixture(parent: mockParent)
        XCTAssertFalse(entity.hasValue(forKey: "a"))
    }

    func testHasValueForKey_whenNotSetAndParentTrue_returnsTrue() {
        mockParent.hasValueForKey(willReturn: true)
        let entity = BaseEntity.fixture(parent: mockParent)
        XCTAssertTrue(entity.hasValue(forKey: "a"))
    }

    func testHasValueForKey_whenSet_returnsTrue() {
        let entity = BaseEntity.fixture(properties: ["a": 1])
        XCTAssertTrue(entity.hasValue(forKey: "a"))
    }

    func testHasValueForKey_whenSetAndParentFalse_returnsTrue() {
        let entity = BaseEntity.fixture(parent: mockParent, properties: ["a": 1])
        XCTAssertTrue(entity.hasValue(forKey: "a"))
    }

    func testHasValueForKey_whenSetAndParentTrue_returnsTrue() {
        let entity = BaseEntity.fixture(parent: mockParent, properties: ["a": 1])
        XCTAssertTrue(entity.hasValue(forKey: "a"))
    }

    func testHasValueForKey_whenSetNil_returnsFalse() {
        let entity = BaseEntity.fixture(properties: ["a": nil])
        XCTAssertFalse(entity.hasValue(forKey: "a"))
    }

    func testHasValueForKey_whenSetNilAndParentFalse_returnsFalse() {
        let entity = BaseEntity.fixture(parent: mockParent, properties: ["a": nil])
        XCTAssertFalse(entity.hasValue(forKey: "a"))
    }

    func testHasValueForKey_whenSetNilAndParentTrue_returnsFalse() {
        let entity = BaseEntity.fixture(parent: mockParent, properties: ["a": nil])
        XCTAssertFalse(entity.hasValue(forKey: "a"))
    }

    func testValueForKey_whenNotSet_returnsNil() {
        let entity = BaseEntity.fixture()
        XCTAssertNil(entity.value(forKey: "a"))
    }

    func testValueForKey_whenNotSetAndParentFalse_returnsNil() {
        let entity = BaseEntity.fixture(parent: mockParent)
        XCTAssertNil(entity.value(forKey: "a"))
    }

    func testValueForKey_whenNotSetAndParentTrue_returnsParentValue() {
        mockParent.hasValueForKey(willReturn: true)
        let entity = BaseEntity.fixture(parent: mockParent)
        XCTAssertEqual(entity.value(forKey: "a") as? Int, 100, "returns value from the parent")
    }

    func testValueForKey_whenSet_returnsValue() {
        let entity = BaseEntity.fixture(properties: ["a": 1])
        XCTAssertEqual(entity.value(forKey: "a") as? Int, 1)
    }

    func testValueForKey_whenSetAndParentFalse_returnsValue() {
        let entity = BaseEntity.fixture(parent: mockParent, properties: ["a": 1])
        XCTAssertEqual(entity.value(forKey: "a") as? Int, 1)
    }

    func testValueForKey_whenSetAndParentTrue_returnsValue() {
        let entity = BaseEntity.fixture(parent: mockParent, properties: ["a": 1])
        XCTAssertEqual(entity.value(forKey: "a") as? Int, 1)
    }

    func testValueForKey_whenSetNil_returnsNil() {
        let entity = BaseEntity.fixture(properties: ["a": nil])
        XCTAssertNil(entity.value(forKey: "a"))
    }

    func testValueForKey_whenSetNilAndParentFalse_returnsNil() {
        let entity = BaseEntity.fixture(parent: mockParent, properties: ["a": nil])
        XCTAssertNil(entity.value(forKey: "a"))
    }

    func testValueForKey_whenSetNilAndParentTrue_returnsNil() {
        let entity = BaseEntity.fixture(parent: mockParent, properties: ["a": nil])
        XCTAssertNil(entity.value(forKey: "a"))
    }

    func testIterate_whenEmpty_doesNotExecuteBody() {
        let entity = BaseEntity.fixture(parent: mockParent, properties: [:])
        var isIterated = false
        entity.iterate { _, _ in
            isIterated = true
        }
        XCTAssertFalse(isIterated)
    }

    func testIterate_withSinglePair_executesBody() {
        let entity = BaseEntity.fixture(parent: mockParent, properties: ["a": "b"])
        var isIterated = false
        entity.iterate { _, _ in
            isIterated = true
        }
        XCTAssertTrue(isIterated)
    }

    func testIterate_withMultiplelePair_executesBody() {
        let entity = BaseEntity.fixture(parent: mockParent, properties: ["a": "b", "c": "d"])
        var iterations = 0
        entity.iterate { _, _ in
            iterations += 1
        }
        XCTAssertEqual(iterations, 2)
    }
}

private class MockEntity: BaseEntity {
    private var property: Any?
    private var availability = false

    init() {
        super.init(parent: nil, properties: [:])
    }

    func valueForKey(willReturn value: Any?) {
        property = value
    }

    override func value(forKey key: String) -> Any? {
        property
    }

    func hasValueForKey(willReturn value: Bool) {
        availability = value
    }

    override func hasValue(forKey key: String) -> Bool {
        availability
    }
}

private extension BaseEntity {
    static func fixture(parent: BaseEntity? = nil, properties: Properties = [:]) -> BaseEntity {
        BaseEntity(parent: parent, properties: properties)
    }
}
