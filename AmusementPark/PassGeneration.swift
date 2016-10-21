//
//  PersonGeneration.swift
//  AmusementPark
//
//  Created by The Bao on 10/20/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation

// ERROR TYPE

enum ErrorInformation: Error {
    case MissingDateOfBirth, MissingFirstName, MissingLastName,
        MissingAddress, MissingCity, MissingState, MissingZipCode,
        MissingSocicalSecurityNumber,MissingManagementTier
}

class PassGeneration {

//    var entrant: Information
//    var entrantType: EntrantType
//
//    init(entrant: Information, entrantType: EntrantType) {
//        self.entrant = entrant
//        self.entrantType = entrantType
//    }
    // CHECKING: Required informations
//    func verifyingFilledInformation() throws -> Bool{
//        switch self.entrantType {
//            case GuestType.FreeChild:
//                guard self.entrant.dateOfBirth != nil else {
//                    throw ErrorInformation.MissingDateOfBirth
//            }
//            case is HourlyEmployeeType:
//                guard self.entrant.firstName != nil else {
//                    throw ErrorInformation.MissingFirstName
//                }
//                guard self.entrant.lastName != nil else {
//                    throw ErrorInformation.MissingLastName
//                }
//                guard self.entrant.streetAddress != nil else {
//                    throw ErrorInformation.MissingAddress
//                }
//                guard self.entrant.state != nil else {
//                    throw ErrorInformation.MissingAddress
//                }
//                guard self.entrant.city != nil else {
//                    throw ErrorInformation.MissingCity
//                }
//                guard self.entrant.zipCode != nil else {
//                    throw ErrorInformation.MissingZipCode
//                }
//            default: print("Do not require information.")
//        }
//        return true
//    }
//
    func printEntrant() {
        print(self.entrant)
        print(self.entrantType)
    }


}

class Reader {
    // AREA TYPE & DISCOUNT TYPE
    enum AreaType {
        case Asumement
        case RideControl
        case Maintenance
        case Kitchen
        case Rides
        case Office
        case SkipRideLines
    }
    enum DiscountType {
        case FoodDiscount
        case MerchDiscount
    }

    //SWIPE METHOD
    func check() {
        // Check BirthDay
//        if compareDate(){
//            print("Happy Birthday!!! Today is your birthday.")
//        }

    }

//    func checkAccessArea(entrant: EntrantType, areaType: AreaType) -> Bool {
//
//        switch areaType {
//        case .Asumement: return entrant.accessToArea().asumementAreas
//        case .Kitchen: return entrant.accessToArea().kitchenAreas
//        case .RideControl: return entrant.accessToArea().rideControlAreas
//        case .Office: return entrant.accessToArea().officeAreas
//        case .Maintenance: return entrant.accessToArea().maintenanceAreas
//        case .Rides: return entrant.accessToRide().accessAllRides
//        case .SkipRideLines: return entrant.accessToRide().skipsAllRideLines
//        }
//    }
//
//    static func checkAccessDiscount( entrant: EntrantType, discountType: DiscountType) -> Int? {
//        switch discountType {
//        case .FoodDiscount: return entrant.accessToDiscount().discountOnFood
//        case .MerchDiscount: return entrant.accessToDiscount().discountOnMerchandise
//        }
//    }
//    func compareDate(information: Information) -> Bool {
//        let dateOfBirth = information.dateOfBirth?.toDateTime()
//
//        return (dateOfBirth?.isBirthDay())!
//    }
//

}
