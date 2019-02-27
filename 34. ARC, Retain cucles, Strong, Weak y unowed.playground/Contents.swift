import Foundation
//Caso practico

class Person {
    var account: Account?
    var name = "andres"
    deinit {
        print("vamos a eliminar a nuestra persona")
    }
}

class Account {
    unowned var person : Person
    var name = "bank x"
    init(person: Person) {
        self.person = person
    }
    
    deinit {
        print("vamos a eliminar a nuestra cuenta")
    }
}
var person: Person = Person()
var account : Account? = Account(person: person)

account?.person = person

print(person.account?.name)
print(account?.person.name)

account = nil

print(person.account?.name)
print(account?.person.name)

print(person.name   )
