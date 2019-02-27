import Foundation

var transactionsDict : [String: [Float]] = [
    "1nov" : [20,10,100.0],
    "2nov" : [],
    "3nov" : [1000],
    "4nov" : [],
    "5nov" : [10]
]

var transactionsDict2 : [String: [Float]] = [
    "2nov" : [1000],
    "3nov" : [1000],
    "4nov" : [1000],
]

//Las funciones es la agrupación de ejecución de código para evitar repeticiones.
func totalAccount(
    forTransactions transactions: [String: [Float]]) -> (Float, Int) {
    var total : Float = 0
    for key in transactions.keys {
        let array = transactions[key]!
        total += array.reduce(0.0, +)
    }
    return (total, transactions.count)
}

let total = totalAccount(forTransactions: transactionsDict)
let total2 = totalAccount(forTransactions: transactionsDict2)

print(total.0, total.1)
print(total2)

//Tuplas: nos permite agrupar valores, a la vez que nos permite asigarnle un "Name Parameters" para identificarlas.
let name = (name: "Jonathan", lastName: "Macalupu")
print(name.0)
print(name.name)

print(name.1)
print(name.lastName)

var a = 1
var b = 2

(a,b) = (b,a)

print(a,b)
