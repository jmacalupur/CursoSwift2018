import Foundation

public protocol TransactionGain : Transaction{
    var category: GainCategories {get}
}

public enum GainCategories {
    case salary, freelance, tip, smallBusiness, bigBusiness
}

public class Gain : TransactionGain {
   public var confirmation: Date?
   public var completed: Bool = false
   public var handler: TransactionHandler?
   public var date: Date
   public var validateDelegate: IsValidateTransaction?
   public var delegate: InvalidateTransaction?
   public var value: Float
   public var name: String
   public var isValid: Bool = Bool.random()
   public var category : GainCategories
   public init (value: Float, name: String, category: GainCategories, date: Date) {
        self.category = category
        self.value = value
        self.name = name
        self.date = date
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {self.handler?(true, Date())}
        print("Confirmed transaction", Date())
    }
}
