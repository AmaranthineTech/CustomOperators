//:# Custom Operators
//: - Date: 16th September 2020
//: - Author: Arun Patwardhan
//: - Copyright: Copyright (c) Amaranthine 2020
/*:
 
 **Contact Details**
 
 [arun@amaranthine.co.in](mailto:arun@amaranthine.co.in)
 
 [www.amaranthine.in](https://www.amaranthine.in)
 
 - note: For more information about how these markups were written please visit: [Adding formatted Text to Swift](https://arunpatwardhan.com/2017/11/09/adding-formatted-text-to-swift-in-xcode/)
 */

//:#### Frameworks
import Foundation

/*: ## Rules for custom operators
 - Note: Can begin with: `/, =, -, +, !, *, %, <, >, &, |, ^, ?, or ~`
 - Note: Can begin with: `.`
 - Note: Cannot containt a `.` if it doesn't begin with a `.`
 - Note: Cannot begin with `?` or `!`
 - Note: Cannot contain only `?` or `!`
 */

//: - Note: The following tokes are reserved & cannot be overloaded or used as custom operators: `=, ->, //, \/*, \*/, ., !, &, <, >, ?, !, ?`

//MARK: - Prefix
//:### Prefix

//: Declaration
prefix operator **

//: Implementation
/**
 This function performs squaring operation
 - important: This function does not perform data validation.
 - returns: `T` which conforms to `Numeric`.
 - requires: iOS 13 or later, macOS 10.15 or later
 - Since: iOS 13, macOS 10.15
 - parameter input: This is the value that is to be squared
 - Example: `var answer =  **9` or `var area = **side`
 - author: Arun Patwardhan
 - copyright: Copyright (c) Amaranthine 2020
 - date: 16th September 2020
 - version: 1.0
 */
@available(*, message: "This is used to perform squaring operations on all Numeric types")
prefix func **<T : Numeric> (input : T) -> T {
    input * input
}

//MARK: - Postfix
//:### Postfix
//: Declaration
/**
 - Example: This is an example of how you would use it.\
 \
 ```
 struct Person {
 var name : String = ""
 var age : Int = 0
 }
 
 extension Person {
 static postfix func ~> (argument : Person) -> String {
 "Name: \(argument.name), AGE: \(argument.age)"
 }
 }
 
 `var john : Person = Person(name: "John", age: 30)`\
 `john~>`
 */
postfix operator ~>

/**
 This function performs squaring operation
 - important: This function does not perform data validation.
 - returns: `T` which conforms to `CustomStringConvertible`.
 - requires: iOS 13 or later, macOS 10.15 or later along with conformance to `CustomStringConvertible`
 - Since: iOS 13, macOS 10.15
 - parameter input: This is the value that is to be converted to a string
 - Example: `var personDetails =  person~>`
 - author: Arun Patwardhan
 - copyright: Copyright (c) Amaranthine 2020
 - date: 16th September 2020
 - version: 1.0
 */
@available(*, message: "This is used to get the string value of the data")
postfix func ~> <T : CustomStringConvertible> (argument : T) -> String {
    return argument.description
}

//MARK: - Infix

/**
 `DegreeOfSimilarity` enum represents the level of similarity
 
 - Author: Arun Patwardhan
 - Version: 1.0
 - Date: 14th September 2020
 - Copyright: Copyright (C) Amaranthine 2020
 */
public enum DegreeOfSimilarity {
    case exactly_the_same
    case almost_the_same
    case slightly_similar
    case completely_different
}

//: -Note: Only infix operators can have precedence group.
/**
 `AlmostEqualToPrecedence` is the precedence for our operator
 
 - Note: The priority is in higher than AdditionPrecedence and lower than MultiplicationPrecedence
 - Author: Arun Patwardhan
 - Version: 1.0
 - Date: 14th September 2020
 - Copyright: Copyright (C) Amaranthine 2020
 */
precedencegroup AlmostEqualToPrecedence {
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
    associativity: left
    assignment: true
}

//:## Infix operators
//: Declaration
//:Unicode: U+2248
infix operator ≈ : AlmostEqualToPrecedence

/**
 - Example:
 ```
 struct PersonalAddress {
    var buildingNumber  : Int       = 0
    var buildingName    : String?
    var streetName      : String    = ""
    var landmark        : String    = ""
    var area            : String    = ""
    var city            : String    = ""
    var postcode        : String    = ""
    var state           : String    = ""
    var country         : String    = ""
 }
 
 extension PersonalAddress {
    static func ≈ (lhsValue : PersonalAddress, rhsValue : PersonalAddress) -> DegreeOfSimilarity {
        var countOfMatchingItems : UInt8 = 0
 
        guard lhsValue.country == rhsValue.country
        else {
            return DegreeOfSimilarity.completely_different
        }
 
        //Slightly similar
        countOfMatchingItems += 1
 
        if lhsValue.state == rhsValue.state {
            countOfMatchingItems += 1
        }
        else {
            return DegreeOfSimilarity.slightly_similar
        }
 
        if lhsValue.city == rhsValue.city {
            countOfMatchingItems += 1
        }
        else {
            return DegreeOfSimilarity.slightly_similar
        }
 
        if lhsValue.postcode == rhsValue.postcode {
            countOfMatchingItems += 1
        }
 
        //Almost the same
        if lhsValue.area == rhsValue.area {
            countOfMatchingItems += 1
        }
        else {
            return DegreeOfSimilarity.almost_the_same
        }
 
        if lhsValue.landmark == rhsValue.landmark {
            countOfMatchingItems += 1
        }
        else {
            return DegreeOfSimilarity.almost_the_same
        }
 
        if lhsValue.streetName == rhsValue.streetName {
            countOfMatchingItems += 1
        }
        else {
            return DegreeOfSimilarity.almost_the_same
        }
 
        //Exactly same
        if lhsValue.buildingName == rhsValue.buildingName {
            countOfMatchingItems += 1
        }
 
        if lhsValue.buildingNumber == rhsValue.buildingNumber {
            countOfMatchingItems += 1
        }
 
        switch countOfMatchingItems {
            case 1...4:
                return DegreeOfSimilarity.slightly_similar
            case 5...7:
                return DegreeOfSimilarity.almost_the_same
            case 8,9:
                return DegreeOfSimilarity.exactly_the_same
            default:
                return DegreeOfSimilarity.completely_different
        }
    }
 }
 
 //: Usage
 var homeAddress     : PersonalAddress   = PersonalAddress(buildingNumber: 10,
                                                            buildingName: "Trees",
                                                             streetName: "10th Street",
                                                             landmark: "Next to Golf Course",
                                                             area: "Suburb",
                                                             city: "Mumbai",
                                                             postcode: "123001",
                                                             state: "MH",
                                                             country: "India")
 
 var officeAddress   : PersonalAddress   = PersonalAddress(buildingNumber: 22,
                                                             buildingName: "City IT Center",
                                                             streetName: "15th Street",
                                                             landmark: "Next to Golf Course",
                                                             area: "Suburb",
                                                             city: "Mumbai",
                                                             postcode: "123001",
                                                             state: "MH",
                                                             country: "India")
 
 var similarity : DegreeOfSimilarity = homeAddress ≈ officeAddress
 */
