//
//  AmusementPark.swift
//  AmusementPark
//
//  Created by The Bao on 10/20/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation

// MARK: ENTRANTS PROTOCOLS

protocol Nameable {
    var name: Name { get }
}
protocol Addressable {
    var address: Address { get }
}

protocol Dateable {
    var dateOfBirth: String? { get }
}
protocol SocialSecurityNumberable {
    var socialSecurityNumber: Int? { get }
}
protocol ManagementTierable{
    var managementTier: String? { get }
}

// MARK: INFORMATIONS

enum FillingError: Error {
    case MissingInformation(required: String)

}
struct Name {
    let firstName: String?
    let lastName: String?
    init(firstName: String?, lastName: String?) throws {
        guard let firstName = firstName else {
            throw FillingError.MissingInformation(required: "Missing First Name ")
        }
        guard let lastName = lastName else {
            throw FillingError.MissingInformation(required: "Missing Last Name ")
        }
        self.firstName = firstName
        self.lastName = lastName
    }
}
struct Address {
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: Int?
    init(streetAddress: String?, city: String?, state: String?, zipCode: Int?) throws {
        guard let streetAddress = streetAddress else {
            throw FillingError.MissingInformation(required: "Missing Street Address")
        }
        guard let city = city else {
            throw FillingError.MissingInformation(required: "Missing City")
        }
        guard let state = state else {
            throw FillingError.MissingInformation(required: "Missing State")
        }
        guard let zipCode = zipCode else {
            throw FillingError.MissingInformation(required: "Missing ZipCode")
        }
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
}


// MARK: AREA ACCESS PROTOCOL 

protocol AreaAccessible {}

protocol AsumementAccessible: AreaAccessible {}

protocol KitchenAccessible: AreaAccessible {}

protocol RideControlAccessible: AreaAccessible {}

protocol MaintenanceAccessible: AreaAccessible {}

protocol OfficeAccessible: AreaAccessible {}

// MARK: RIDE ACCESS PROTOCOL

protocol RideAccessible {}

protocol AllRidesAccessible: RideAccessible {}

protocol SkipAllRideLinesAccessible: RideAccessible {}

// MARK: DISCOUNT ACCESS PROTOCOL

protocol DiscountAccessible {}

protocol FoodDiscountAccessible : DiscountAccessible {
    var foodDiscount: Int? { get }
}

protocol MerchanDiscountAccesible: DiscountAccessible {
    var merchanDiscount: Int? { get }
}

// MARK: ENTRANT TYPE PROTOCOL 

protocol EntrantType: AsumementAccessible {
}

protocol Guest: EntrantType, AllRidesAccessible {}

protocol Employee: EntrantType, Nameable,Addressable,Dateable,SocialSecurityNumberable,AllRidesAccessible {}

protocol HourlyEmployee: Employee,FoodDiscountAccessible,MerchanDiscountAccesible {}

protocol Manager: Employee,AreaAccessible,ManagementTierable, FoodDiscountAccessible,MerchanDiscountAccesible{}


// GUEST Type

class ClassicGuest: Guest{}

class VipGuest: Guest,SkipAllRideLinesAccessible,FoodDiscountAccessible,MerchanDiscountAccesible{
    var foodDiscount: Int? = 10
    var merchanDiscount: Int? = 20
}

class FreeChildGuest: Guest,Dateable{
    var dateOfBirth: String?
    init(dateOfBirth: String?) throws {
        guard let dateOfBirth = dateOfBirth else {
            throw FillingError.MissingInformation(required: "Missing Date Of Birth")
        }
        self.dateOfBirth = dateOfBirth
    }
}

// EMPLOYEE Type 

class EmployeeType: Employee {
    let name: Name
    let address: Address
    let dateOfBirth: String?
    var socialSecurityNumber: Int?

    init(name: Name, address: Address,dateOfBirth: String?, socialSecurityNumber: Int?) throws {
        guard let socialSercurityNumber = socialSecurityNumber else {
            throw FillingError.MissingInformation(required: "Missing Social Security Number")
        }
        self.name = name
        self.address = address
        self.dateOfBirth = dateOfBirth
        self.socialSecurityNumber = socialSercurityNumber
    }
}
class HourlyEmployeeType: EmployeeType {
    var foodDiscount: Int? = 15
    var merchanDiscount: Int? = 25
}
class ManagerType: EmployeeType,Manager {
    var managementTier: String?
    var foodDiscount: Int? = 25
    var merchanDiscount: Int? = 25
     init(name: Name, address: Address,dateOfBirth: String?, socialSecurityNumber: Int?, managementTier: String?) throws {
        guard let managementTier = managementTier else {
            throw FillingError.MissingInformation(required: "Missing Management Tier")
        }
        self.managementTier = managementTier
        do {
            try super.init(name: name, address: address, dateOfBirth: dateOfBirth, socialSecurityNumber: socialSecurityNumber)
        }catch let error {
            fatalError("\(error)")
        }

    }

}

class FoodServicesEmployee: HourlyEmployeeType,KitchenAccessible {}
class MaintenanceEmployee: HourlyEmployeeType,MaintenanceAccessible,RideControlAccessible,KitchenAccessible {}
class RideServicesEmployee: HourlyEmployeeType,RideControlAccessible {}

class ManagerEmployee: ManagerType {}

protocol SwipeDelegate{
    func hasRecentlySwiped(lastTimeSwiped: Date?) -> Bool
}
class SwipeDelegateType: SwipeDelegate {
    let timeToWait: Double = 300.0
    func hasRecentlySwiped(lastTimeSwiped: Date?) -> Bool {
        let newSwipe = Date()
        guard let lastTime: Date = lastTimeSwiped else {
            print("This is you first Ride!")
            return false
        }
        //check if the interval since the last date is < timeToWait
        if newSwipe.timeIntervalSince(lastTime) < timeToWait {
            return true
        } else {
            return false
        }
    }
}


// DATE FORMATER

enum ConversionError : Error {
    case DateConversionError
}

extension String{
     func toDateTime() -> Date
    {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        //Specify Format of String to Parse
        dateFormatter.dateFormat = "MM/dd/yyyy"

        //Parse into NSDate
        let dateFromString : Date = dateFormatter.date(from: self)!
        //Return Parsed Date
        return dateFromString
    }
}

extension Date {
     func isBirthDay() -> Bool {
        let today = Date()
        let todayComponents = Calendar.current.dateComponents([.month,.day], from: today)
        let birthDayComponents = Calendar.current.dateComponents([.month,.day], from: self)
        return todayComponents.day == birthDayComponents.day && todayComponents.month == birthDayComponents.month
    }
}








