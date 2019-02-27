import Foundation

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
    var transactions: [Float] = []

    init(amount: Float, name : String) {
        self.amount = amount
        self.name = name
    }
    
    @discardableResult
    func addTransaction(value: Float) -> Float {
        if amount - value < 0 {
            return 0
        }
        amount -= value
        transactions.append(value)
        return amount
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

//en el caso de las Clases si sufre una moficación, tanto en account, como en me.account, por eso en el ejemplo, se resta 40.
account.addTransaction(value: 20)
me.account?.addTransaction(value: 20)
print(me.account!.amount)

print(me.fullName)

me.fullName = "Pedro Perez"
print(me.fullName)
