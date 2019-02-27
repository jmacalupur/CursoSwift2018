import Foundation

class Account {
    var amount : Float = 0 {
        //Se puede agregar eventos en las propiedades.
        didSet {
            print("Tenemos nuevo valor:", amount)
        }
    }
    var name : String = ""
    var transactions: [Float] = []
    
    //Siempre requiere inicializadores
    init(amount: Float, name : String) {
        self.amount = amount
        self.name = name
    }
    
    @discardableResult
    //Con mutating, indica que son valores mutables
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
