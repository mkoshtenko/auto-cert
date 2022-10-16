import Foundation

final class NameCheapRecord: BaseEntity {
    enum Keys {
        // Mandatory keys
        static let name = "Name"
        static let type = "Type"
        static let address = "Address"
        // Optional keys
        static let isDDNS = "IsDDNSEnabled"
        static let mxPref = "MXPref"
        static let ttl = "TTL"
        static let friendlyName = "FriendlyName"
        static let isActive = "IsActive"
        static let hostId = "HostId"
        static let associatedAppTitle = "AssociatedAppTitle"
    }

    var name: String {
        guard let name: String = value(forKey: Keys.name) else {
            fatalError("NameCheap host records should always have a name")
        }
        return name
    }

    init(properties: [String: String]) {
        super.init(parent: nil, properties: properties)
    }

    init(record: HostRecord) {
        super.init(parent: record, properties: [:])
    }
}

extension NameCheapRecord {
    enum ParsingError: Error {
        case missingField(String)
    }

    // The API requires different names for the name and type fields
    private enum RequestKeys {
        static let name = "HostName"
        static let type = "RecordType"
    }

    func requestArguments() throws -> [String: String] {
        var arguments: [String: String] = [:]
        // Mandatory arguments
        arguments.updateValue(try argument(forKey: Keys.name), forKey: RequestKeys.name)
        arguments.updateValue(try argument(forKey: Keys.type), forKey: RequestKeys.type)
        arguments.updateValue(try argument(forKey: Keys.address), forKey: Keys.address)

        // Add optional arguments
        arguments.updateValueIfNotEmpty(value(forKey: Keys.isDDNS), forKey: Keys.isDDNS)
        arguments.updateValueIfNotEmpty(value(forKey: Keys.mxPref), forKey: Keys.mxPref)
        arguments.updateValueIfNotEmpty(value(forKey: Keys.ttl), forKey: Keys.ttl)
        arguments.updateValueIfNotEmpty(value(forKey: Keys.friendlyName), forKey: Keys.friendlyName)
        arguments.updateValueIfNotEmpty(value(forKey: Keys.isActive), forKey: Keys.isActive)
        arguments.updateValueIfNotEmpty(value(forKey: Keys.hostId), forKey: Keys.hostId)
        arguments.updateValueIfNotEmpty(value(forKey: Keys.associatedAppTitle), forKey: Keys.associatedAppTitle)

        return arguments
    }

    private func argument(forKey key: String) throws -> String {
        guard let value: String = value(forKey: key) else {
            throw ParsingError.missingField(key)
        }
        return value
    }
}

private extension Dictionary where Key==String, Value==String {
    // Will set value only if it is not nil and not empty
    mutating func updateValueIfNotEmpty(_ value: String?, forKey key: String) {
        guard let value = value, !value.isEmpty else { return }
        updateValue(value, forKey: key)
    }
}
