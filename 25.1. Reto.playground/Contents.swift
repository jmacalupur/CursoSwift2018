import Foundation
//Herencia tengo un objeto con las mismas similitudes de las propiedades de otro objeto

class Transaction {
    var value : Float
    var name : String
    var category : String
    init(value : Float, name : String, category : String) {
        self.value = value
        self.name = name
        self.category = category
    }
    
}

class Debit : Transaction {
}

class Gain : Transaction {
}

class Account {
    var amount : Float = 0 {
        //Esto es antes de que el valor se cambie. El valoer newValue es un valor implicito, podemos cambiarlo. El newValue es el valor futuro que obtendrá
        willSet {
            //print("Vamos a cambiar el valor", amount, newValue)
            print("Monto inicial: \(amount). Monto final: \(newValue)")
        }
        
        //Se puede agregar eventos en las propiedades. Se ejecuta cuando la varuable ha sido modificada.
        didSet {
            print("Tu saldo actual es:", amount)
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
            print("Se ingresó \(transaction.value) por concepto de \(transaction.name). Se guardó en la categoría: \(transaction.category)")
        }
        if transaction is Debit {
            if amount - transaction.value < 0 {
                return 0
            }
            amount -= transaction.value
            print("Se gastó \(transaction.value) por concepto de \(transaction.name). Se guardó en la categoría: \(transaction.category)")
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


print("Cliente: \(me.fullName)")
print("Transacciones Realizadas")
me.account?.addTransaction(transaction: Debit(value: 20, name: "Cafe con amigos", category: "Comida"))
me.account?.addTransaction(transaction: Debit(value: 100, name: "Juego de Nintendo Switch", category: "Diversión"))
me.account?.addTransaction(transaction: Debit(value: 1200, name: "Nintendo Switch", category: "Diversión"))
me.account?.addTransaction(transaction: Gain(value: 2000, name: "Salario", category: "Ingresos Fijos"))
me.account?.addTransaction(transaction: Gain(value: 1500, name: "Proyecto de diseño web", category: "Ingresos Freelos"))
print("Saldo en tu cuenta es: \(me.account!.amount)")

