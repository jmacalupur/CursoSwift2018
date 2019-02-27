import Foundation

var transactionsDict : [String: [Float]] = [
    "1nov" : [20,10,100.0],
    "2nov" : [],
    "3nov" : [1000],
    "4nov" : [],
    "5nov" : [10]
]


//Utlizamos el Where como una condicional para indicar que solo buscamos un valor mayor a 10 dentro de las transacciones. Evitamos colocar un "if", ya que lo colocamos dentor de la línea del ciclo For.

var total2 : Float = 0.0
for key in transactionsDict.keys {
    for transaction in transactionsDict[key]! where transaction > 10 {
        
        total2 += transaction
    }
}
print(transactionsDict)
print(total2)
