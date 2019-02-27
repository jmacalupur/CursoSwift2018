import Foundation

var transactionsDict : [String: [Float]] = [
    "1nov" : [20,10,100.0],
    "2nov" : [],
    "3nov" : [1000],
    "4nov" : [],
    "5nov" : [10]
]
//Las funciones es la agrupación de ejecución de código para evitar repeticiones.


func totalAccount() {
    var total : Float = 0
    for key in transactionsDict.keys {
        let array = transactionsDict[key]!
        total += array.reduce(0.0, +)
    }
    print(total)
}

totalAccount()


