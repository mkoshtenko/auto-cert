import Foundation

class BaseEntity {
    typealias Properties = [String: Any?]

    private let properties: Properties
    private let parent: BaseEntity?

    init(parent: BaseEntity?, properties: Properties) {
        self.parent = parent
        self.properties = properties
    }

    /// Returns a value for provided key. Will return `value(forKey:)` from the parent if there is no such key.
    func value(forKey key: String) -> Any? {
        if let value = properties[key] {
            return value
        }
        guard let parent = parent, parent.hasValue(forKey: key) else { return nil }
        return parent.value(forKey: key)
    }

    /// Returns true if this entity or its parent has a value for the key.
    func hasValue(forKey key: String) -> Bool {
        if let value = properties[key] {
            return value != nil
        }
        return parent?.hasValue(forKey: key) ?? false
    }

    func iterate(_ body: (String, Any?) -> Void) {
        properties.forEach(body)
    }
}

extension BaseEntity {
    func value<T>(forKey key: String) -> T? {
        guard hasValue(forKey: key) else { return nil }
        return value(forKey: key) as? T
    }
}

extension BaseEntity: CustomStringConvertible {
    var description: String {
        var result: [String] = []
        var node: BaseEntity? = self
        var level = 0
        while let current = node {
            let tab = String(repeating: "\t", count: level) + (level == 0 ? "+ " : "-> ")
            let properties = current.properties.compactMapValues { $0 ?? nil }
            result.append("\(tab)\(type(of: current))=\(properties)")
            node = current.parent
            level += 1
        }
        return result.joined(separator: "\n")
    }
}
