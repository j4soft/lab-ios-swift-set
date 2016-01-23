struct FirstName {
    let value: String
    
    init(value: String) {
        self.value = value
    }
}

struct LastName {
    let value: String
    
    init(value: String) {
        self.value = value
    }
}

//: The struct Person must implement the Hashable protocol, which inherits from the Equatable protocol to be used with sets.
//: Additionally, the struct Person implements the CustomStringConvertible protocol for displaying purposes.
struct Person : Hashable, CustomStringConvertible {
    let firstName: FirstName
    let lastName: LastName

    init(firstName: FirstName, lastName: LastName) {
        self.firstName = firstName
        self.lastName = lastName
    }

    // Hashable protocol implementation.
    var hashValue: Int {
        get {
            return "\(firstName.value.hashValue),\(lastName.value.hashValue)".hashValue
        }
    }
    
    // CustomStringConvertible protocol implementation.
    var description: String {
        get {
            return "[\(firstName.value) \(lastName.value)]"
        }
    }
}

//: This function implements the Equatable protol.
//: Weired, but the == function must be defined globally, i.e. outside the Person struct.
func == (lhs: Person, rhs: Person) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

let person1 = Person(firstName: FirstName(value: "John"), lastName: LastName(value: "Foe"))
let person2 = Person(firstName: FirstName(value: "David"), lastName: LastName(value: "White"))
let person3 = Person(firstName: FirstName(value: "Brian"), lastName: LastName(value: "Westwood"))
let person4 = Person(firstName: FirstName(value: "Adrian"), lastName: LastName(value: "Westwood"))
let person5 = Person(firstName: FirstName(value: "Adrian"), lastName: LastName(value: "White"))

var personsSet = Set<Person>()

//: Initialising an unsorted set.
personsSet.insert(person5)
personsSet.insert(person3)
personsSet.insert(person2)
personsSet.insert(person1)
personsSet.insert(person4)

//: Printing set's unsorted elements.
print("*** Unsorted set ***\n", personsSet)

//: Sorting set by last and first name ascending.
let ascendingSortedSet = personsSet.sort { (first, second) -> Bool in
    return (first.lastName.value + first.firstName.value < second.lastName.value + second.firstName.value)
}
print("*** Set sorted by last and first name ascending ***\n", ascendingSortedSet)
