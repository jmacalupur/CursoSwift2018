import Foundation

var accountTotal: Float = 1_000_000
let name = "jonathan"
let lastName = "macalupu"

let fullName = "\(name) \(lastName)"

print(fullName.capitalized)

accountTotal += 100_000

print(accountTotal)

var account = 1e6

print(account)

var isActive = !fullName.isEmpty

print(isActive)
