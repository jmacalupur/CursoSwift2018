import Foundation

var transactionsDict : [String: [Float]] = [
    "1nov" : [20,10,100.0],
    "2nov" : [],
    "3nov" : [1000],
    "4nov" : [],
    "5nov" : [10]
]

print(transactionsDict.keys)
print(transactionsDict.values)
print(transactionsDict.isEmpty)
print(transactionsDict.count)
