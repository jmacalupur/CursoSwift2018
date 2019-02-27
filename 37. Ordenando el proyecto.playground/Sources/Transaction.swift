import Foundation

public protocol IsValidateTransaction {
    func isValidateTransaction(transaction: Transaction)
}

public typealias TransactionHandler  = ((_ completed: Bool, _ confirmation: Date) -> Void)


public protocol InvalidateTransaction {
    func invalidateTransaction(transaction: Transaction)
}

public protocol Transaction {
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
public extension Transaction {
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

