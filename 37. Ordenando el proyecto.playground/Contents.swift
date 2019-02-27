import Foundation

var me = Person(name: "Jonathan", lastName: "Macalupu")
var account = Account(amount: 10_000, name: "X bank")

me.account = account

print(me.account!)


var salary0 = try me.account?.addTransaction(transaction: .debit(value: 20, name: "Cafe con amigos", category: .food, date: Date(year: 2019, month: 1, day: 31)))

do {
    var salary1 = try me.account?.addTransaction(transaction: .debit(value: 1_000_000, name: "Juego de Nintendo Switch", category: .entertainment, date: Date(year: 2019, month: 2, day: 14)))
}
catch {
    print("Error in NS Game",error)
}

var salary2 = try me.account?.addTransaction(transaction: .debit(value: 1200, name: "Nintendo Switch", category: .entertainment, date: Date(year: 2019, month: 2, day: 16)))

var salary3 = try me.account?.addTransaction(transaction: .gain(value: 2000, name: "Sueldo", category: .salary, date: Date(year: 2019, month: 1, day: 1)))

var salary4 = try me.account?.addTransaction(transaction: .gain(value: 2000, name: "Sueldo", category: .salary, date: Date(year: 2019, month: 1, day: 1)))


DispatchQueue.main.asyncAfter(deadline: .now()+1){salary0?.isValidateTransaction()
    print(salary0?.isValid)
    print(salary0?.completed)
}


//DispatchQueue.main.asyncAfter(deadline: .now()+1){salary1?.isValidateTransaction()
//    print(salary1?.isValid)
//    print(salary1?.completed)
//}

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
