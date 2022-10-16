import Foundation

class NameCheapService {
    let api: NameCheapRepository

    init(api: NameCheapRepository) {
        self.api = api
    }

    func addOrReplace(_ record: HostRecord) async throws {
        let newRecord = NameCheapRecord(record: record)
        let hostRecords = try await api.getHosts(forDomain: record.domain)
        print("GET<", hostRecords, separator: "\n")
        var recordsToAdd = hostRecords.filter { host in
            return host.name != newRecord.name
        }
        recordsToAdd.append(newRecord)
        print("SET>", recordsToAdd, separator: "\n")
        try await api.setHosts(recordsToAdd, forDomain: record.domain)
    }
}

extension NameCheapService: DomainService {}
