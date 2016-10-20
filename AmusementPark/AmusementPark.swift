//
//  AmusementPark.swift
//  AmusementPark
//
//  Created by The Bao on 10/20/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation

// PROTOCOLS

protocol AreaAccess {
    func accessToArea() -> AreaAccessType
}
protocol RideAccess {
    func accessToRide() -> RideAccessType
}
protocol DiscountAccess {
    func accessToDiscount() -> DiscountAccessType
}
protocol EntrantType: AreaAccess, RideAccess, DiscountAccess {


}

protocol InformationType {
    var firstName: String? { get }
    var lastName: String? { get }
    var streetAddress: String? { get }
    var city: String? { get }
    var state: String? { get }
    var zipCode: Int? { get }
    var socialSecurityNumber: Int? { get }
    var dateOfBirth: NSDate? { get }
    var ManagementTier: String? { get }
}

struct Information: InformationType{
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: Int?
    var socialSecurityNumber: Int?
    var dateOfBirth: NSDate?
    var ManagementTier: String?
}
struct AreaAccessType {
    var asumementAreas: Bool
    var kitchenAreas: Bool
    var rideControlAreas: Bool
    var maintenanceAreas: Bool
    var officeAreas: Bool
}
struct RideAccessType {
    var accessAllRides: Bool
    var skipsAllRideLines: Bool
}
struct DiscountAccessType {
    var discountOnFood: Int?
    var discountOnMerchandise: Int?
}
// Entrant Type 

enum GuestType: EntrantType {

    case Classic,VIP,FreeChild

    func accessToDiscount() -> DiscountAccessType {
        switch self {
            case .Classic: return DiscountAccessType()
            case .FreeChild: return DiscountAccessType()
            case .VIP: return DiscountAccessType(discountOnFood: 10, discountOnMerchandise: 20)
        }
    }
    func accessToRide() -> RideAccessType {
        switch self {
            case .Classic: return RideAccessType(accessAllRides: true, skipsAllRideLines: false)
            case .FreeChild: return RideAccessType(accessAllRides: true, skipsAllRideLines: false)
            case .VIP: return RideAccessType(accessAllRides: true, skipsAllRideLines: true)
        }
    }
    func accessToArea() -> AreaAccessType {
        switch self {
        case .Classic: return AreaAccessType(asumementAreas: true, kitchenAreas: false, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
            case .FreeChild: return AreaAccessType(asumementAreas: true, kitchenAreas: false, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
        case .VIP: return AreaAccessType(asumementAreas: true, kitchenAreas: false, rideControlAreas: false,    maintenanceAreas: false, officeAreas: false)
        }
    }

}

enum HourlyEmployeeType: EntrantType{

    case FoodServices,RideServices,Maintenance
    func accessToDiscount() -> DiscountAccessType {
        switch self {
            case .FoodServices: return DiscountAccessType(discountOnFood: 15, discountOnMerchandise: 25)
            case .RideServices: return DiscountAccessType(discountOnFood: 15, discountOnMerchandise: 25)
            case .Maintenance: return DiscountAccessType(discountOnFood: 15, discountOnMerchandise: 25)
        }
    }
    func accessToRide() -> RideAccessType {
        switch self {
        case .FoodServices: return RideAccessType(accessAllRides: true, skipsAllRideLines: false)
        case .RideServices: return  RideAccessType(accessAllRides: true, skipsAllRideLines: false)
        case .Maintenance: return RideAccessType(accessAllRides: true, skipsAllRideLines: false)
        }
    }
    func accessToArea() -> AreaAccessType {
        switch self {
        case .FoodServices: return AreaAccessType(asumementAreas: true, kitchenAreas: true, rideControlAreas: false, maintenanceAreas: false, officeAreas: false)
        case .RideServices: return AreaAccessType(asumementAreas: true, kitchenAreas: false, rideControlAreas: true, maintenanceAreas: false, officeAreas: false)
        case .Maintenance: return AreaAccessType(asumementAreas: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: true, officeAreas: false)
        }
    }
}
enum Manager: EntrantType{
    func accessToDiscount() -> DiscountAccessType {
        return DiscountAccessType(discountOnFood: 25, discountOnMerchandise: 25)
    }
    func accessToRide() -> RideAccessType {
        return RideAccessType(accessAllRides: true, skipsAllRideLines: false)
    }
    func accessToArea() -> AreaAccessType {
        return AreaAccessType(asumementAreas: true, kitchenAreas: true, rideControlAreas: true, maintenanceAreas: true, officeAreas: true)
    }
}











