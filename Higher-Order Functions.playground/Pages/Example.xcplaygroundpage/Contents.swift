import UIKit

//  Get the average age from all people living in California

let persons: [[String: Any]] = [
    ["name": "Carl Saxon", "city": "New York, NY", "age": 44],
    
    ["name": "Travis Downing", "city": "El Segundo, CA", "age": 34],
    
    ["name": "Liz Parker", "city": "San Francisco, CA", "age": 32],
    
    ["name": "John Newden", "city": "New Jersey, NY", "age": 21],
    
    ["name": "Hector Simons", "city": "San Diego, CA", "age": 37],
    
    ["name": "Brian Neo", "age": 27]
]


let averageAge = persons.filter{
    ($0["city"] as? String)?.contains("CA") ?? false
}.reduce((count: 0, accumulatedAge: 0, average: 0), calcAverage).average

typealias Accumulator = (count: Int, accumulatedAge: Int, average: Int)

func calcAverage(accumulator: Accumulator, current: [String: Any]) -> Accumulator {
    let count = accumulator.count + 1
    let accumulatedAge = accumulator.accumulatedAge + (current["age"] as? Int ?? 0)
    let average = accumulatedAge / count
    
    return (count, accumulatedAge, average)
}

print(averageAge)



func printName() -> String {
    return "Wissa"
}


func returnString() -> ()-> String {
    return printName
}


let namePrinter = returnString()

print(namePrinter())
print(returnString()())

