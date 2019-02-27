import Foundation
//Clousures:
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

typealias TransactionHandler  = ((_ completed: Bool, _ confirmation: Date) -> Void)


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
    var handler: TransactionHandler? {get set}
    var confirmation : Date? {get set}
    var completed : Bool {get}
}

extension Transaction {
    mutating func invalidateTransaction() {
        if completed {
            isValid = false
            delegate?.invalidateTransaction(transaction: self)
        }
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
    var confirmation: Date?
    var completed: Bool = false
    var handler: TransactionHandler?
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
        DispatchQueue.main.asyncAfter(deadline: .now()) {self.handler?(true, Date())}
        print("Confirmed transaction", Date())
    }
}

class Gain : TransactionGain {
    var confirmation: Date?
    var completed: Bool = false
    var handler: TransactionHandler?
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {self.handler?(true, Date())}
        print("Confirmed transaction", Date())
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
            if amount - dValue < 0 {
                return nil
            }
            let debit = Debit(value: dValue, name: dDescription, category: dType, date: dDate)
            debit.delegate = self
            debit.validateDelegate = self
            debit.handler = {(completed, confirmation) in
                debit.confirmation = confirmation
                self.amount -= debit.value
                self.transactions.append(debit)
                self.debits.append(debit)
            }
            return debit
        case .gain(let gValue, let gDescription, let gType, let gDate):
            let gain = Gain(value: gValue, name: gDescription, category: gType, date: gDate)
            gain.delegate = self
            gain.validateDelegate = self
            gain.handler = {(completed, confirmation) in
                gain.confirmation = confirmation
                self.amount += gain.value
                self.transactions.append(gain)
                self.gains.append(gain)
            }
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


DispatchQueue.main.asyncAfter(deadline: .now()+1){salary0?.isValidateTransaction()
    print(salary0?.isValid)
    print(salary0?.completed)
}


DispatchQueue.main.asyncAfter(deadline: .now()+1){salary1?.isValidateTransaction()
    print(salary1?.isValid)
    print(salary1?.completed)
}

DispatchQueue.main.asyncAfter(deadline: .now()+1){salary2?.isValidateTransaction()
    print(salary2?.isValid)
    print(salary2?.completed)
}

DispatchQueue.main.asyncAfter(deadline: .now()+1){salary3?.isValidateTransaction()
    print(salary3?.isValid)
    print(salary3?.completed)
}


DispatchQueue.main.asyncAfter(deadline: .now()+1) {salary4?.invalidateTransaction()
    print(salary4?.isValid)
    print(salary4?.completed)
    print("Invalidated")
}




//Como son asìncronas no se visualizan las transacciones para que se vean, se tiene que hacer un Dispacth:
print(me.account!.amount)
DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
}



print(me.account?.amount ?? 0)
