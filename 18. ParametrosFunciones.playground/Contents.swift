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


func totalAccount(forTransactions transactions: [String: [Float]]) -> Float {
    var total : Float = 0
    for key in transactions.keys {
        let array = transactions[key]!
        total += array.reduce(0.0, +)
    }
    return total
}

let total = totalAccount(forTransactions: transactionsDict)
let total2 = totalAccount(forTransactions: transactionsDict2)

print(total)
print(total2)
