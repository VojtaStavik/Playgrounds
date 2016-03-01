//: Playground - noun: a place where people can play

import UIKit

extension Int {
    func times(@noescape closure: () -> Void) {
        for _ in 0...self {
            closure()
        }
    }
}

func mergeSort<Element: Comparable>(inputArray: [Element], comparator: (Element, Element) -> Bool) -> [Element] {
    if inputArray.count == 1 {
        return inputArray
    }
    
    let leftArray = mergeSort(Array(inputArray[0...inputArray.count/2 - 1]), comparator: comparator)
    let rightArray = mergeSort(Array(inputArray[(inputArray.count/2)...inputArray.count - 1]), comparator: comparator)
    
    print("\(leftArray) \(rightArray)")
    
    var finalArray = [Element]()
    
    var leftIndex = 0, rightIndex = 0

    for _ in 0...(leftArray.count + rightArray.count) {
        if leftIndex < leftArray.count && rightIndex < rightArray.count {
            if  comparator(leftArray[leftIndex], rightArray[rightIndex]) {
                finalArray.append(leftArray[leftIndex])
                leftIndex += 1
            } else {
                finalArray.append(rightArray[rightIndex])
                rightIndex += 1
            }
        } else if rightIndex == rightArray.count && leftIndex < leftArray.count {
            finalArray.append(leftArray[leftIndex])
            leftIndex += 1
        } else if leftIndex == leftArray.count && rightIndex < rightArray.count {
            finalArray.append(rightArray[rightIndex])
            rightIndex += 1
        }
    }
    return finalArray
}

var array = [Int]()

100.times {
    array.append(Int(rand()))
}

 let sorted = mergeSort(array) { $0 < $1 }

 let newArrayMerge = sorted




func bulbeSort<T: Comparable>(array: [T], compare: (T, T) -> Bool) -> [T] {
    var finished = false
    var workingArray = array
    repeat {
        var index = 0
        finished = true
        print("\nOuter loop --- ")
        repeat {
            let first = workingArray[index]
            let second = workingArray[index + 1]
            if compare(first, second) == false {
                workingArray[index] = second
                workingArray[index + 1] = first
                finished = false
                print("|-Inner loop")
            }
            index += 1
    
        } while index < workingArray.count - 1
        print(" -------------")
    } while finished == false
    
    return workingArray
}

let bubleSorted = bulbeSort(array) { $0 < $1 }

let newArrayBuble = bubleSorted

 