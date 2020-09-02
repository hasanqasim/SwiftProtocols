import Foundation

// To restrict conforming types to classes only, inherit from AnyObject protocol
// this means value types wont be able to adopt protocols
// this would throw an error for the mutating keyword because class methods can always modify the instance
// no need for the mutating keyword in class only protocols
protocol Taggable {
    // var defines an immutable property
    var tag: String {get set}
    // if its only gettable, in other words it is only readable
    var data: Data {get}
    // define type property requirements using ths static keyword
    // since its static, its value gets shared by all instances
    // {get} is read only g
    static var counter: Int {get}
    
    // protocols can also define instance and type method requirements
    // type methods are called on the type and not on an instance of type
    
    // if a method modifies the instance, mark with a mutating keyword
    mutating func update(data: Data) -> Bool
    //func update(data: Data) -> Bool
    
    // mutating keyword allows value types to adopt the protocol
    
    // static method requirements in a protocol
    static func incrementCounter()
    
    // protocols can dictate initializers to be implemented by conforming types
    init(tag: String, data: Data)
    
    // everythings pretty similar to class definition except cant use let keyowrds to declare cosntants
    // also default values, computed proerties, initializers and method definitions not allowed in the protocol
    // since no default value shence the type inference engine has no way of knowing types hence explicitly specify property types
}

 // ADOPTING PROTOCOLS

// tagged data type conforms to the taggable protocol
struct Tagged: Taggable {
    var tag: String
    
    var data: Data
    
    static var counter: Int = 0
    
    mutating func update(data: Data) -> Bool {
        self.data = data
        return true
    }
    
    static func incrementCounter() {
        counter += 1
    }
    
    init(tag: String, data: Data) {
        self.tag = tag
        self.data = data
    }
    
}

// CONFORMING TO PROTOCOLS VIA EXTENSION

// we want to build a cryptography framework
// define a single method requirement
protocol Encrypting {
    func xor(key: UInt8) -> Self?
}

// make the string type conform to the protocol
// use type extension toa dd new properties or methods to an existing type

extension String: Encrypting {
    func xor(key: UInt8) -> String? {
        // first retrieve the strings content as a collection of UTF-8 codes
        // then use map to combine each element with the provided key using the xor opration
        String(bytes: self.utf8.map {$0 ^ key}, encoding: .utf8)
    }
}

// this just enhanced String type with the new cryptography feature
let target = "Hello, World"
let result = target.xor(key: 42)
print(result ?? "encoding failed")
print(result?.xor(key: 42) ?? "decoding failed")

// type extensions let us add protocols requirements to any type
