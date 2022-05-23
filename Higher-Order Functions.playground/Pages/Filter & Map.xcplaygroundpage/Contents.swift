//: [Previous](@previous)

import Foundation

// MARK: - Filter

let cast = ["Vivien", "Marlon", "Kim", "Karl"]

let shortNames = cast.filter { $0.count < 5 }

print(shortNames)
// Prints "["Kim", "Karl"]"

// MARK: - Map

let lowercaseNames = cast.map({ (element: String) -> String in return element.lowercased() })
// 'lowercaseNames' == ["vivien", "marlon", "kim", "karl"]

let letterCounts = cast.map { $0.count }
// 'letterCounts' == [6, 6, 3, 4]

// MARK: - CompactMap

let possibleNumbers = ["1", "2", "three", "///4///", "5"]

let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
// [1, 2, nil, nil, 5]

let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
// [1, 2, 5]

// MARK: - FlatMap

let numbers = [1, 2, 3, 4]

let mappedNumbers = numbers.map { Array(repeating: $0, count: $0) }
// [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]

let flatMapped = numbers.flatMap { Array(repeating: $0, count: $0) }
// [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

let flatMappedNumbers = mappedNumbers.flatMap { $0 }
// [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]


// map, compactMap, flatMap and filter all keep the data structure unchanged. Array goes in, array goes out.
// The amount and the contents of the array may change, but the array-shape stays.
