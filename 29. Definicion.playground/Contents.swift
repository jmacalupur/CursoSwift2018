//Protocolos: es un contrato entre dos objetos o clases. Entendamos como protocolo:
//Estamos creando una cuenta ante el banco y necesito que acepten estos tèrminos.
//Los protocolos tienen propiedades y funciones. Cada parte que forma el contrato tiene que tener una implementación. En este caso, colocarlo dentor de las clases.
import Foundation


protocol Transaction {
    var value: Float {get}
    var name: String {get}
    var isValid : Bool {get set}
}

extension Transaction {
    mutating func invalidateTransaction() {
        isValid = false
    }
}

protocol TransactionDebit : Transaction{
    var category: DebitCategories {get}
}

protocol TransactionGain : Transaction{
    var category: GainCategories {get}
}

enum DebitCategories : String {
    case health
    case food, rent, tax, transportation
    case entertainment = "Entretenimiento"
}

enum GainCategories {
    case salary, freelance, tip, smallBusiness, bigBusiness
}

enum TransactionType {
    case debit(value : Float, name: String, category: DebitCategories)
    case gain(value : Float, name: String, category: GainCategories)
}


class Debit : TransactionDebit {
    var value: Float
    var name: String
    var isValid: Bool = true
    var category : DebitCategories
    init (value : Float, name : String, category: DebitCategories) {
        self.category = category
        self.value = value
        self.name = name
    }
}

class Gain : TransactionGain {
    var value: Float
    var name: String
    var isValid: Bool = true
    var category : GainCategories
    init (value: Float, name: String, category: GainCategories) {
        self.category = category
        self.value = value
        self.name = name
    }
}
class Account {
    var amount : Float = 0 {
        willSet {
            print("Vamos a cambiar el valor", amount, newValue)
        }
        didSet {
            print("Tenemos nuevo valor:", amount)
        }
    }
    var name : String = ""
    var transactions: [Transaction] = []
    
    var debits : [Debit] = []
    var gains : [Gain] = []
    
    init(amount: Float, name : String) {
        self.amount = amount
        self.name = name
    }
    
    @discardableResult
    func addTransaction(transaction: TransactionType) -> Transaction? {
        switch transaction {
        case .debit(let dValue, let dDescription, let dType):
            let debit = Debit(value: dValue, name: dDescription, category: dType)
            if amount - debit.value < 0 {
                return nil
            }
            amount -= debit.value
            transactions.append(debit)
            debits.append(debit)
            return debit
        case .gain(let gValue, let gDescription, let gType):
            let gain = Gain(value: gValue, name: gDescription, category: gType)
            amount += gain.value
            transactions.append(gain)
            gains.append(gain)
            return gain
        }
        
    }
    
    func transactionFor(category: DebitCategories) -> [Transaction] {
        return transactions.filter({(transaction) -> Bool in
            guard let transaction = transaction as? Debit else {
                return false
            }
            return transaction.category == category
        })
    }
}

class Person {
    var name : String = ""
    var lastName : String = ""
    var account : Account?
    
    var fullName : String {
        //también se puede hacer eso sin colocar el get.
        get {
            return "\(name) \(lastName)"
        }
        //Esta funcion puede hacer que se ejecute la funcion antes de que obtenga el valor
        set {
            name = String(newValue.split(separator: " ").first ?? "")
            lastName = "\(newValue.split(separator: " ").last ?? "")"
        }
    }
    
    //Un inicializador es una funcion que crea la clase como tal.
    init(name : String, lastName : String) {
        self.name = name
        self.lastName = lastName
    }
}
var me = Person(name: "Jonathan", lastName: "Macalupu")
var account = Account(amount: 100_000, name: "X bank")

me.account = account

print(me.account!)




me.account?.addTransaction(transaction: .debit(value: 20, name: "Cafe con amigos", category: .food))

me.account?.addTransaction(transaction: .debit(value: 100, name: "Juego de Nintendo Switch", category: .entertainment))

me.account?.addTransaction(transaction: .debit(value: 1200, name: "Nintendo Switch", category: .entertainment))


me.account?.addTransaction(transaction: .gain(value: 2000, name: "Sueldo", category: .salary))

var salary = me.account?.addTransaction(transaction: .gain(value: 2000, name: "Sueldo", category: .salary))

salary?.invalidateTransaction()


print(me.account!.amount)

let transactions = me.account?.transactionFor(category: .entertainment) as? [Debit]
for transaction in transactions ?? [] {
    print(transaction.name, transaction.value, transaction.category.rawValue)
}


for gain in me.account?.gains ?? [] {
    print(gain.name, gain.value, gain.isValid)
}
