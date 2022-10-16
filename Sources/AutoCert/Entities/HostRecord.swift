import Foundation

final class HostRecord: BaseEntity {
    enum Keys {
        static let domain = "domain"
    }

    init(parent: BaseEntity, domain: String) {
        super.init(parent: parent, properties: [Keys.domain: domain])
    }

    var domain: String {
        guard let domain = value(forKey: Keys.domain) as? String else {
            fatalError("HostRecord should not have empty domain field")
        }
        return domain
    }
}
