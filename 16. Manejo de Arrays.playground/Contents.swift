import Foundation
var accountTotal : Float = 1_000_000

var transactions : [Float] = [20, 10, 100]

//Una forma de reducir la operación de la suma
var total3 = transactions.reduce(0.0) { (result, element) -> Float in
    return result + element
}
print(transactions)
print(total3)

//Otra forma de reducir la operazción de la suma
print(transactions.reduce(0.0, {return $0 + $1}))


//Una forma más de reducir la operación de la suma de los valores del array
print(transactions.reduce(0.0, {$0 + $1}))

//Una forma más de reducir la operación de la suma de los valores del array
print(transactions.reduce(0.0, +))

var newTransactions = transactions.map { (element) -> Float in
    return element * 100
}
print(newTransactions)

//Esta es la forma en Cómo ordenamos los valores, en este caso de mayor a menor
print(transactions.sorted(by: { (element1, element2) ->Bool in
    return element1 > element2}))

//Una forma simplificada es colocando el valor de mayor o menor
print(transactions.sorted(by: <))

print(transactions.filter {
    (element) -> Bool in
    return element > 10
})


//Elimina todos los valores de transacciones mayores a 10
transactions.removeAll(where: {
    $0 > 10
})
print(transactions)




var transactionsDict : [String: [Float]] = [
    "1nov" : [20,10,100.0],
    "2nov" : [],
    "3nov" : [1000],
    "4nov" : [],
    "5nov" : [10]
]


var total2 : Float = 0.0
for key in transactionsDict.keys {
    for transaction in transactionsDict[key] ?? [] {
        
        total2 += transaction
    }
}
print(total2)

//Una forma de reducir la suma de los valores
print(transactionsDict.reduce(0.0, {$0 + $1.value.reduce(0.0,+)}))

