import Foundation
var accountTotal = 1_100_000
accountTotal -= 200_000

if accountTotal > 0 {
    print("tenemos dinero")
} else if accountTotal >= 1_000_000 {
    print("Somos Ricos")
} else {
    print("No tenemos dinero")
}


//Este es la condicion Inline If:
let hasMoney = accountTotal > 1_000_000 ? "Somos Ricos" : "No tenemos dinero"

print(hasMoney)

