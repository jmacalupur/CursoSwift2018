import Foundation

var accountTotal : Float = 1_000_000


var transactions : [Float] = [20, 10, 100]




var total : Float = 0
for transaction in transactions {
    total += (transaction * 100)
}

print(total)
print(accountTotal)
accountTotal -= total
print(accountTotal)



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

print(transactionsDict)
print(total2)
