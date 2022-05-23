//: [Previous](@previous)

import Foundation



// MARK: - Closures

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]



// MARK: - Closure Expression Syntax

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })



// MARK: - Inferring parameter and return value types from context

reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )



// MARK: - Implicit returns from single-expression closures
// Fat arrow version in Swift

reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )



// MARK: - Shorthand argument names

reversedNames = names.sorted(by: { $0 > $1 } )
// reversedNames = names.sorted(by: { $0, $1 in $0 > $1 } )



// MARK: - Operator Methods

reversedNames = names.sorted(by: >)



// MARK: - Trailing closure syntax

reversedNames = names.sorted() { $0 > $1 }

reversedNames = names.sorted { $0 > $1 }

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}


// MARK: - Multiple Trailing closure syntax

struct Server { func download(_ url: String, from: Server?) -> Picture { Picture() } }
struct Picture {}
struct SomeView { static var currentPicture: Picture? = nil }

func loadPicture(from server: Server?, completion: (Picture) -> Void, onFailure: () -> Void) {
    if let picture = server?.download("photo.jpg", from: server) {
        completion(picture)
    } else {
        onFailure()
    }
}

loadPicture(from: Server(), completion: complete, onFailure: failureHandler)

func complete(picture dowloadedPic: Picture) {
    SomeView.currentPicture = dowloadedPic
}

func failureHandler () -> Void {
    print("Couldn't download the next picture.")
}



// MARK: - Capturing Values

func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
// returns a value of 10
incrementByTen()
// returns a value of 20
incrementByTen()
// returns a value of 30

// it will have its own stored reference to a new, separate runningTotal variable:
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()

incrementByTen()
// returns a value of 40


// MARK: - Closures Are Reference Types

let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// returns a value of 50

incrementByTen()
// returns a value of 60



// MARK: - Escaping Closures

var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"

completionHandlers.first?()
print(instance.x)
// Prints "100"



// MARK: - Structures and enumerations don’t allow shared mutability

struct SomeStruct {
    var x = 10
    
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }    // Ok
        //someFunctionWithEscapingClosure { x = 100 }     // Error
    }
}

struct SomeStruct2 {
    var x = 10
    
    func doSomething() {
        someFunctionWithNonescapingClosure { x * 200 }  // Ok
        someFunctionWithEscapingClosure { x * 100 }     // Error
    }
}
