import Foundation

var age = 24
var tax = 1.0

switch age {
case 0...17:
    print("No podemos dar una tarjeta de crédito")
case 18...22:
    tax = 2
    print("la tasa de interés es del \(tax)%")
case 23...25:
    tax = 1.5
    print("la tasa de interés es del \(tax)%")
default:
    print("la tasa de interés es del \(tax)%")
}

let bankType = "B"

switch bankType {
case "B":
    print("Es el Banco B")
default:
    print("es otro Banco")
}
