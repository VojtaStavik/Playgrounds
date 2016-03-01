//: Playground - noun: a place where people can play

import Foundation

struct MyArray<Element> : CustomStringConvertible {
    
    var description: String {
        var mutableDescription = "["
        
        for i in 0..<count {
            mutableDescription += "\""
            mutableDescription += "\(elementAtIndex(i))"
            mutableDescription += "\""
            if i != count - 1 {
                mutableDescription += ", "
            }
        }
        mutableDescription += "]"
        
        return mutableDescription
    }
    
    private var dataRepresentation: NSMutableData!
    
    init(element: Element) {
        var copyElement = element
        dataRepresentation = NSMutableData(bytes: &copyElement, length: sizeof(Element))
    }
    
    init(elements: Element ...) {
        dataRepresentation = NSMutableData()
        for element in elements {
            append(element)
        }
    }
    
    private var elementLength: Int { return sizeof(Element) }
    
    var numberOfElements: Int { return dataRepresentation.length / elementLength }
    
    subscript (index: Int) -> Element {
        return elementAtIndex(index)
    }
    
    var count: Int { return numberOfElements }
    
    var elements: MyArray<Element> {
        return self
    }
    
    func elementAtIndex(index: Int) -> Element {
        let subdata = dataRepresentation.subdataWithRange(NSRange(location: index * elementLength, length:
            elementLength))
        return UnsafeMutablePointer<Element>(subdata.bytes).memory
    }
    
    mutating func append(element: Element) {
        var copyElement = element
        dataRepresentation.appendBytes(&copyElement, length: sizeof(Element))
    }
    
    mutating func insert(element: Element, toIndex index: Int) {
        var newElement = element
        func adjustIndex(oldIndex: Int) -> Int {
            if oldIndex < index {
                return oldIndex
            } else {
                return oldIndex + 1
            }
        }
        
        let newData = NSMutableData()
        for i in 0..<numberOfElements {
            if index == i {
                newData.appendBytes(&newElement, length: elementLength)
            }
            var copyElement = elementAtIndex(i)
            newData.appendData(NSMutableData(bytes: &copyElement, length: sizeof(Element)))
        }
        dataRepresentation = newData
    }
    
    mutating func removeElementAtIndex(index: Int) {
        let newData = NSMutableData()
        for i in 0..<numberOfElements {
            if index != i {
                var copyElement = elementAtIndex(i)
                newData.appendData(NSMutableData(bytes: &copyElement, length: sizeof(Element)))
            }
        }
        dataRepresentation = newData

    }
}

var array = MyArray(elements: "test1", "test2")
array.append("2")
array.append("3")

let pokus = array.elements

array.insert("new 1", toIndex: 0)
let pokus2 = array.elements

array.insert("new 3", toIndex: 3)

let pokus3 = array.elements
let pokus3count = array.elements.count

array.removeElementAtIndex(0)

let pokus4 = array.elements

let pokus5 = array[0]

