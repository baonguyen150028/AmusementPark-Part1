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

    var entrant: Information
    var entrantType: EntrantType

    init(entrant: Information, entrantType: EntrantType) {
        self.entrant = entrant
        self.entrantType = entrantType
    }
    // CHECKING: Required informations
    func verifyingFilledInformation() throws -> Bool{
        switch self.entrantType {
            case GuestType.FreeChild:
                guard self.entrant.dateOfBirth != nil else {
                    throw ErrorInformation.MissingDateOfBirth
            }
            case is HourlyEmployeeType:
                guard self.entrant.firstName != nil else {
                    throw ErrorInformation.MissingFirstName
                }
                guard self.entrant.lastName != nil else {
                    throw ErrorInformation.MissingLastName
                }
                guard self.entrant.streetAddress != nil else {
                    throw ErrorInformation.MissingAddress
                }
                guard self.entrant.state != nil else {
                    throw ErrorInformation.MissingAddress
                }
                guard self.entrant.city != nil else {
                    throw ErrorInformation.MissingCity
                }
                guard self.entrant.zipCode != nil else {
                    throw ErrorInformation.MissingZipCode
                }
            default: print("Do not require information.")
        }
        return true
    }

    func printEntrant() {
        print(self.entrant)
        print(self.entrantType)
    }

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
    func checkAccessArea(areaType: AreaType) -> Bool {
        switch areaType {
            case .Asumement: return self.entrantType.accessToArea().asumementAreas
            case .Kitchen: return self.entrantType.accessToArea().kitchenAreas
            case .RideControl: return self.entrantType.accessToArea().rideControlAreas
            case .Office: return self.entrantType.accessToArea().officeAreas
            case .Maintenance: return self.entrantType.accessToArea().maintenanceAreas
            case .Rides: return self.entrantType.accessToRide().accessAllRides
            case .SkipRideLines: return self.entrantType.accessToRide().skipsAllRideLines
        }
    }
    func checkAccessDiscount( discountType: DiscountType) -> Int? {
        switch discountType {
            case .FoodDiscount: return self.entrantType.accessToDiscount().discountOnFood
            case .MerchDiscount: return self.entrantType.accessToDiscount().discountOnMerchandise
        }
    }
}

