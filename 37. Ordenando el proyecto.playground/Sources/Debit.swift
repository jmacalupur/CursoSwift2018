import Foundation

public protocol TransactionDebit : Transaction{
    var category: DebitCategories {get}
}

public enum DebitCategories : String {
    case health
    case food, rent, tax, transportation
    case entertainment = "Entretenimiento"
}

public class Debit : TransactionDebit {
   public var confirmation: Date?
   public var completed: Bool = false
   public var handler: TransactionHandler?
   public var date: Date
   public var validateDelegate: IsValidateTransaction?
   public var delegate: InvalidateTransaction?
   public var value: Float
   public var name: String
   public var isValid: Bool = Bool.random()
   public var category : DebitCategories
    public init (value : Float, name : String, category: DebitCategories, date: Date) {
        self.category = category
        self.value = value
        self.name = name
        self.date = date
        DispatchQueue.main.asyncAfter(deadline: .now()) {self.handler?(true, Date())}
        print("Confirmed transaction", Date())
    }
}
