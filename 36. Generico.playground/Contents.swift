import Foundation

//Se usa mayor que y menor que antes de los parentesis de la funcion. Un generico es un valor compun que asignas.

func sum<T: Numeric>(a: T, b: T) -> T {
    return a + b
}

sum(a: 1.4, b: 5)

//En el caso de las clases los colocas antes de los parèntesis

class Stack<Element> {
    var items : [Element] = []
    func push(_ item : Element) {
        items.append(item)
    }
    func pop() -> Element {
        return items.removeLast()
    }
}

var stack = Stack<Int>()

stack.push(2)
stack.push(3)
stack.push(7)
stack.push(1)

stack.pop()

print(stack.items)

var stack2 = Stack<String>()

stack2.push("Jonathan")
stack2.push("Michell")
stack2.push("Lizbeth")
stack2.push("Lizzette")

stack2.pop()
print(stack2.items)

