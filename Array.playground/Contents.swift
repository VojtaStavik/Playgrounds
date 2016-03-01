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
    
    private let dataRepresentation: NSMutableData!
    
    init() {
        dataRepresentation = NSMutableData()
    }
    
    init(elements: Element ...) {
        self.init()
        for element in elements {
            append(element)
        }
    }
    
    private var elementLength: Int { return sizeof(Element) }
    
    var count: Int { return dataRepresentation.length / elementLength }
    
    subscript(index: Int) -> Element {
        get {
            return elementAtIndex(index)
        }
        set {
            insert(newValue, toIndex: index)
        }
    }
    
    func elementAtIndex(index: Int) -> Element {
        let subdata = dataRepresentation.subdataWithRange(NSRange(location: index * elementLength, length: elementLength))
        return UnsafeMutablePointer<Element>(subdata.bytes).memory
    }
    
    mutating func append(element: Element) {
        var copyElement = element
        dataRepresentation.appendBytes(&copyElement, length: elementLength)
    }
    
    mutating func insert(element: Element, toIndex index: Int) {
        var newElement = element
        let newData = NSMutableData()
        for i in 0..<count {
            if index == i {
                newData.appendBytes(&newElement, length: elementLength)
            }
            var copyElement = elementAtIndex(i)
            newData.appendData(NSMutableData(bytes: &copyElement, length: elementLength))
        }
        dataRepresentation.setData(newData)
    }
    
    mutating func removeElementAtIndex(index: Int) {
        let newData = NSMutableData()
        for i in 0..<count {
            if index != i {
                var copyElement = elementAtIndex(i)
                newData.appendData(NSMutableData(bytes: &copyElement, length: elementLength))
            }
        }
        dataRepresentation.setData(newData)
    }
}

var array = MyArray(elements: "1", "2")
array.append("3")
array.append("4")
array.insert("new 1", toIndex: 0)
array[3] = "new 3"
let p = array
array.removeElementAtIndex(0)

let pokus4 = array
let pokus5 = array[0]
