import Foundation
//Enums: Numeradores son casi como constantes pero agrupados en una misma categoría
//reto: Agregar un enum a la categoría de ganancias

enum DebitCategories {
    case health
    case food, rent, tax, transportation
    case entertainment
    
}

enum GainCategories {
    case salary, freelance, tip, smallBusiness, bigBusiness
}


class Transaction {
    var value : Float
    var name : String
    init(value : Float, name : String) {
        self.value = value
        self.name = name
    }
    
}

class Debit : Transaction {
    var category : DebitCategories
    init (value : Float, name : String, category: DebitCategories) {
        self.category = category
        super.init(value: value, name: name)
    }
}


class Gain : Transaction {
    var category : GainCategories
    init (value: Float, name: String, category: GainCategories) {
        self.category = category
        super.init(value: value, name: name)
    }
}

class Account {
    var amount : Float = 0 {
        //Esto es antes de que el valor se cambie. El valoer newValue es un valor implicito, podemos cambiarlo. El newValue es el valor futuro que obtendrá
        willSet {
            print("Vamos a cambiar el valor", amount, newValue)
        }
        
        //Se puede agregar eventos en las propiedades. Se ejecuta cuando la varuable ha sido modificada.
        didSet {
            print("Tenemos nuevo valor:", amount)
        }
    }
    var name : String = ""
    var transactions: [Transaction] = []
    
    init(amount: Float, name : String) {
        self.amount = amount
        self.name = name
    }
    
    @discardableResult
    func addTransaction(transaction: Transaction) -> Float {
        if transaction is Gain {
            amount += transaction.value
        }
        if transaction is Debit {
            if amount - transaction.value < 0 {
                return 0
            }
            amount -= transaction.value
        }
        transactions.append(transaction)
        return amount
    }
    
    func debits() -> [Transaction] {
        return transactions.filter({$0 is Debit})
    }
    func gains() -> [Transaction] {
        return transactions.filter({$0 is Gain})
    }
    func transactionFor(category: DebitCategories) -> [Transaction] {
        return transactions.filter({(transaction) -> Bool in
            guard let transaction = transaction as? Debit else {
                return false
            }
            return transaction.category == category
        })
    }
    func transactionFor(category: GainCategories) -> [Transaction] {
        return transactions.filter({(transaction) -> Bool in
            guard let transaction = transaction as? Gain else {
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





me.account?.addTransaction(transaction: Debit(value: 20, name: "Cafe con amigos", category: DebitCategories.food))
me.account?.addTransaction(transaction: Debit(value: 100, name: "Juego de Nintendo Switch", category: .entertainment))
me.account?.addTransaction(transaction: Debit(value: 1200, name: "Nintendo Switch", category: .entertainment))

me.account?.addTransaction(
    transaction: Gain(
        value: 2000,
        name: "Salario",
        category: .salary))

me.account?.addTransaction(
    transaction: Gain(
        value: 1500,
        name: "Proyecto Diseño de App",
        category: .freelance))

me.account?.addTransaction(
    transaction: Gain(
        value: 100,
        name: "Venta de accesorios de Smartphones",
        category: .smallBusiness))

me.account?.addTransaction(
    transaction: Gain(
        value: 40000,
        name: "Venta de 100 iPhones",
        category: .bigBusiness))

print(me.account!.amount)

let transactions = me.account?.transactionFor(category: .entertainment) as? [Debit]
for transaction in transactions ?? [] {
    print(transaction.name, transaction.value, transaction.category)
}

let transactionsGain = me.account?.transactionFor(category: .bigBusiness) as? [Gain]
for transaction in transactionsGain ?? [] {
    print(transaction.name, transaction.value, transaction.category)
}
