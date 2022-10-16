import Foundation

enum NameCheapAPICommand: String {
    // https://www.namecheap.com/support/api/methods/domains-dns/get-hosts/
    case getHosts = "namecheap.domains.dns.getHosts"
    // https://www.namecheap.com/support/api/methods/domains-dns/set-hosts/
    case setHosts = "namecheap.domains.dns.setHosts"
}
