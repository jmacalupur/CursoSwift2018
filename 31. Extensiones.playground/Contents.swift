import Foundation

extension Date {
    init(year: Int, month: Int, day: Int) {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        self = calendar.date(from: dateComponents) ?? Date()
    }
}

protocol IsValidateTransaction {
    func isValidateTransaction(transaction: Transaction)
}


protocol InvalidateTransaction {
    func invalidateTransaction(transaction: Transaction)
}

protocol Transaction {
    var value: Float {get}
    var name: String {get}
    var isValid : Bool {get set}
    var delegate : InvalidateTransaction? {get set}
    var validateDelegate : IsValidateTransaction? {get set}
    var date: Date {get}
}

extension Transaction {
    mutating func invalidateTransaction() {
        isValid = false
        delegate?.invalidateTransaction(transaction: self)
    }
    func isValidateTransaction() {
        validateDelegate?.isValidateTransaction(transaction: self)
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
    case debit(value : Float, name: String, category: DebitCategories, date: Date)
    case gain(value : Float, name: String, category: GainCategories, date: Date)
}


class Debit : TransactionDebit {
    var date: Date
    var validateDelegate: IsValidateTransaction?
    var delegate: InvalidateTransaction?
    var value: Float
    var name: String
    var isValid: Bool = Bool.random()
    var category : DebitCategories
    init (value : Float, name : String, category: DebitCategories, date: Date) {
        self.category = category
        self.value = value
        self.name = name
        self.date = date
    }
}

class Gain : TransactionGain {
    var date: Date
    var validateDelegate: IsValidateTransaction?
    var delegate: InvalidateTransaction?
    var value: Float
    var name: String
    var isValid: Bool = Bool.random()
    var category : GainCategories
    init (value: Float, name: String, category: GainCategories, date: Date) {
        self.category = category
        self.value = value
        self.name = name
        self.date = date
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
        case .debit(let dValue, let dDescription, let dType, let dDate):
            let debit = Debit(value: dValue, name: dDescription, category: dType, date: dDate)
            debit.delegate = self
            debit.validateDelegate = self
            if amount - debit.value < 0 {
                return nil
            }
            amount -= debit.value
            transactions.append(debit)
            debits.append(debit)
            return debit
        case .gain(let gValue, let gDescription, let gType, let gDate):
            let gain = Gain(value: gValue, name: gDescription, category: gType, date: gDate)
            gain.delegate = self
            gain.validateDelegate = self
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

extension Account: InvalidateTransaction, IsValidateTransaction {
    func invalidateTransaction(transaction: Transaction) {
        if transaction is Debit {
            amount += transaction.value
        }
        if transaction is Gain {
            amount -= transaction.value
        }
    }
    func isValidateTransaction(transaction: Transaction) {
        if !transaction.isValid {
            invalidateTransaction(transaction: transaction)
        }
    }
}

class Person {
    var name : String = ""
    var lastName : String = ""
    var account : Account?
    
    var fullName : String {
        
        get {
            return "\(name) \(lastName)"
        }
        
        set {
            name = String(newValue.split(separator: " ").first ?? "")
            lastName = "\(newValue.split(separator: " ").last ?? "")"
        }
    }
    
    
    init(name : String, lastName : String) {
        self.name = name
        self.lastName = lastName
    }
}
var me = Person(name: "Jonathan", lastName: "Macalupu")
var account = Account(amount: 10_000, name: "X bank")

me.account = account

print(me.account!)




var salary0 = me.account?.addTransaction(transaction: .debit(value: 20, name: "Cafe con amigos", category: .food, date: Date(year: 2019, month: 1, day: 31)))

var salary1 = me.account?.addTransaction(transaction: .debit(value: 100, name: "Juego de Nintendo Switch", category: .entertainment, date: Date(year: 2019, month: 2, day: 14)))

var salary2 = me.account?.addTransaction(transaction: .debit(value: 1200, name: "Nintendo Switch", category: .entertainment, date: Date(year: 2019, month: 2, day: 16)))

var salary3 = me.account?.addTransaction(transaction: .gain(value: 2000, name: "Sueldo", category: .salary, date: Date(year: 2019, month: 1, day: 1)))

var salary4 = me.account?.addTransaction(transaction: .gain(value: 2000, name: "Sueldo", category: .salary, date: Date(year: 2019, month: 1, day: 1)))

salary0?.isValidateTransaction()
salary1?.isValidateTransaction()
salary2?.isValidateTransaction()
salary4?.invalidateTransaction()




print(me.account!.amount)

let transactions = me.account?.transactionFor(category: .entertainment) as? [Debit]
for transaction in transactions ?? [] {
    print(transaction.name, transaction.value, transaction.category.rawValue)
}

print("--LISTA DE DEBITOS--")
for debit in me.account?.debits ?? [] {
    print(debit.name, debit.value, debit.isValid, debit.date)
}
print("--LISTA DE INGRESOS--")
for gain in me.account?.gains ?? [] {
    print(gain.name, gain.value, gain.isValid, gain.date)
}

print(me.account?.amount ?? 0)
