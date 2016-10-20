//
//  PersonGeneration.swift
//  AmusementPark
//
//  Created by The Bao on 10/20/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation

enum ErrorInformation: Error{
    case MissingDateOfBirth, MissingFirstName, MissingLastName, MissingAddress, MissingCity, MissingState, MissingZipCode, MissingSocicalSecurityNumber,MissingManagementTier

}
class PersonGeneration {

    var entrant: Information
    var entrantType: EntrantType

    init(entrant: Information, entrantType: EntrantType) {
        self.entrant = entrant
        self.entrantType = entrantType
    }

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

}

