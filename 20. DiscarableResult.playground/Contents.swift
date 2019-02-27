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

var accountTotal : Float = 1_000

var transactions : [Float] = [20, 10, 100]


//La manera de evitar que eso suceda y se ejecute correctamente en memoria es colocar una palabra reservada antes de la palabra func que es @discardableResult.
@discardableResult
func addTransaction(transactionValue value: Float?) -> Bool {
    guard let value = value else {
        return false
    }
    
    if (accountTotal - value) < 0 {
        return false
    }
    accountTotal -= value
    transactions.append(value)
    return true
}

addTransaction(transactionValue: 30)

addTransaction(transactionValue: nil)


//Reto: Se ha agregado las transacciones en el diccionario, haciendo que puedas agregar transacciones con fechas, a la vez quye puedes agregar más transacciones en la misma fecha.

var totalAccountMount : Float = transactionsDict2.reduce(0.0, {$0 + $1.value.reduce(0.0,+)})

@discardableResult
func addTransaction2 (transactionValue value : Float?, date dateValue : String) -> (transactionSuceed : Bool, valueActual : Float) {
    guard let value = value else {
        return (false, totalAccountMount)
    }
    if (totalAccountMount - value) < 0 {
        return (false, totalAccountMount)
    }
    
    if transactionsDict2.keys.contains(dateValue) {
        transactionsDict2[dateValue]?.append(value)
        totalAccountMount = transactionsDict2.reduce(0.0, {$0 + $1.value.reduce(0.0,+)})
        return(true, totalAccountMount)
    } else {
        transactionsDict2.updateValue([value], forKey: dateValue)
        totalAccountMount = transactionsDict2.reduce(0.0, {$0 + $1.value.reduce(0.0,+)})
        return(true, totalAccountMount)
    }
    
    
    
}
print(transactionsDict2)
print(totalAccountMount)
let mount = addTransaction2(transactionValue: 10, date: "10nov")
print(transactionsDict2)
print(mount.transactionSuceed)
print(mount.valueActual)

let mount2 = addTransaction2(transactionValue: 100, date: "10nov")
print(transactionsDict2)
print(mount2.transactionSuceed)
print(mount2.valueActual)
