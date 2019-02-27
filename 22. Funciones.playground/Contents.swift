import Foundation

struct Account {
    var amount : Float = 0
    var name : String = ""
    var transactions: [Float] = []
    
    //Siempre requiere inicializadores
    init(amount: Float, name : String) {
        self.amount = amount
        self.name = name
    }
    
    @discardableResult
    //Con mutating, indica que son valores mutables
    mutating func addTransaction(value: Float) -> Float {
        if amount - value < 0 {
            return 0
        }
        amount -= value
        transactions.append(value)
        return amount
    }
    
}

struct Person {
    var name : String
    var lastName : String
    var account : Account?
}
var me = Person(name: "Jonathan", lastName: "Macalupu", account: nil)
var account = Account(amount: 100_000, name: "X bank")

me.account = account

print(me.account!)

//Tener cuidado donde haces las asignaciones, en este caso, debe de estar en "me"
account.addTransaction(value: 20)
print(me.account!)

me.account?.addTransaction(value: 20)
print(me.account!)
