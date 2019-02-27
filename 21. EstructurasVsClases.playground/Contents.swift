//La diferencia entre ambas, es que en la estructura se genera una "copia" donde no se modifica, mientras que en una Clase, si existe una modificación, se aplica a cada instancia con la clase creada.
import Foundation

struct Account {
    var amount : Float = 0
    var name : String = ""
    
}

struct Person {
    var name : String
    var lastName : String
    var account : Account?
}
var me = Person(name: "Jonathan", lastName: "Macalupu", account: nil)
let account = Account(amount: 100_000, name: "X bank")

me.account = account

print(me.account!)


