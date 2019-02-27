import Foundation

public class Account {
    public var amount : Float = 0 {
        willSet {
            print("Vamos a cambiar el valor", amount, newValue)
        }
        didSet {
            print("Tenemos nuevo valor:", amount)
        }
    }
    public var name : String = ""
    public var transactions: [Transaction] = []
    
    public var debits : [Debit] = []
    public var gains : [Gain] = []
    
    public init(amount: Float, name : String) {
        self.amount = amount
        self.name = name
    }
    
    @discardableResult
    public func addTransaction(transaction: TransactionType) throws-> Transaction? {
        switch transaction {
        case .debit(let dValue, let dDescription, let dType, let dDate):
            if amount - dValue < 0 {
                throw AccountExceptions.amountExeded
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
    
    public func transactionFor(category: DebitCategories) -> [Transaction] {
        return transactions.filter({(transaction) -> Bool in
            guard let transaction = transaction as? Debit else {
                return false
            }
            return transaction.category == category
        })
    }
}

public enum TransactionType {
    case debit(value : Float, name: String, category: DebitCategories, date: Date)
    case gain(value : Float, name: String, category: GainCategories, date: Date)
}


extension Account: InvalidateTransaction, IsValidateTransaction {
    public func invalidateTransaction(transaction: Transaction) {
        if transaction is Debit {
            amount += transaction.value
        }
        if transaction is Gain {
            amount -= transaction.value
        }
    }
    public func isValidateTransaction(transaction: Transaction) {
        if !transaction.isValid {
            invalidateTransaction(transaction: transaction)
        }
    }
}
