//: [Previous](@previous)

import Foundation

// MARK: - Reduce
// The basic idea is to reduce a sequence into a different shape utilizing an accumulator that can keep incremental state. To do this, we hand the function a combinator closure which is called once for each item in the sequence.

func reduce<T, S>(_ initialResult: T, _ nextPartialResult: (T, Array<S>.Element) -> T) -> T {
    0 as! T
}


func sum(accumulator: Int, current: Int) -> Int {
    let result = accumulator + current
    return result
}

var reduced = [1, 2, 3].reduce(0, sum)
print(reduced)

reduced = [0, 1, 2, 3, 4].reduce(0, +)
print(reduced)

reduced = [1, 2, 3, 4].reduce(1, *)
print(reduced)

var reducedArray = [1, 2, 3, 4, 5].reduce([Int]()) { [$1] + $0 }
// [1] + [] = [1]
// [2] + [1] = [2, 1]
// [3] + [2, 1] = [3, 2, 1]
// [4] + [3, 2, 1] = [4, 3, 2, 1]
// [5] + [4, 3, 2, 1] = [5, 4, 3, 2, 1]
print(reducedArray)

// MARK: - Performance

var timeBefore = Date.now

[1, 2, 3, 4, 5, 7, 8, 9, 10].map { $0 + 3 }.filter { $0 % 2 == 0 }.reduce(0, +)

print("Chaining", timeBefore.distance(to: Date.now))

timeBefore = Date.now

Array(0...10).reduce(0, mapEvenNumbers)

func mapEvenNumbers(accumulator: Int, element: Int) -> Int {
    return ((element + 3) % 2 == 0) ? (accumulator + element + 3) : accumulator
}

print("Reduce  ", timeBefore.distance(to: Date.now))

