//
//  PersonGeneration.swift
//  AmusementPark
//
//  Created by The Bao on 10/20/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import AudioToolbox





class PassGeneration {

    enum EntrantInfoKind {
        case Classic
        case Vip
        case FreeChild(String)
        case FoodServices(Name, Address, String?, Int?)
        case Maintenance(Name, Address, String?, Int?)
        case RideServices(Name, Address, String?, Int?)
        case Manager(Name, Address, String?, Int?, String?)
    }
    
    static func generate(kind: EntrantInfoKind) -> EntrantType {
        do {
        switch kind {
        case .Classic:
            return ClassicGuest()
        case .Vip:
            return VipGuest()
        case .FreeChild(let dateOfBirth):
            return try FreeChildGuest(dateOfBirth: dateOfBirth)
        case .FoodServices(let name, let address, let dateOfBirth, let socialSecurityNumber):
            return try FoodServicesEmployee(name: name, address: address, dateOfBirth: dateOfBirth, socialSecurityNumber: socialSecurityNumber)
        case .Maintenance(let name, let address, let dateOfBirth, let socialSecurityNumber):
            return try MaintenanceEmployee(name: name, address: address, dateOfBirth: dateOfBirth, socialSecurityNumber: socialSecurityNumber)
        case .RideServices(let name, let address, let dateOfBirth, let socialSecurityNumber):
            return try RideServicesEmployee(name: name, address: address, dateOfBirth: dateOfBirth, socialSecurityNumber: socialSecurityNumber)
        case .Manager(let name, let address, let dateOfBirth, let socialSecurityNumber, let managementTier):
            return try ManagerEmployee(name: name, address: address, dateOfBirth: dateOfBirth, socialSecurityNumber: socialSecurityNumber, managementTier: managementTier)
        }
        }catch let error {
            fatalError("\(error)")
        }
    }
}

class Swiper {
    // AREA TYPE & DISCOUNT TYPE
    enum Permission {
        /// An accessbile Area
        case Amusement, Kitchen, RideControl, Maintenance, Office

        /// A Ride's privilege
        case AllRides, SkipRideLines

        /// A Discount privilege
        case FoodDiscount, MerchanDiscount

    }
    enum Access {

        /// The access is granted
        case granted
        /// The access is denied
        case denied

        /// The name of the sound to play
        var filename: String {
            switch ( self ) {
            case .granted: return "AccessGranted"
            case .denied: return "AccessDenied"
            }
        }

        ///The url of the file to play
        var fileUrl: URL {
            let path = Bundle.main.path(forResource: self.filename, ofType: "wav")!
            return  URL(fileURLWithPath: path) as URL
        }
    }

    static var sound: SystemSoundID = 0

    //SWIPE METHOD
    static func check(entrant: EntrantType, access: Permission) -> Bool {

        if let birthdayEntrant = entrant as? Dateable, let birthday = birthdayEntrant.dateOfBirth?.toDateTime() {
            if birthday.isBirthDay() {
                print("Happy Birthday")
            }
        }

        var accessGranted: Bool = false

        switch access {
        // Area Access
        case .Amusement:
            accessGranted = entrant is AsumementAccessible
        case .Kitchen:
            accessGranted = entrant is KitchenAccessible
        case .RideControl:
            accessGranted = entrant is RideControlAccessible
        case .Maintenance:
            accessGranted = entrant is MaintenanceAccessible
        case .Office:
            accessGranted = entrant is OfficeAccessible
        // Ride Access
        case .AllRides:
            accessGranted = entrant is AllRidesAccessible
        case .SkipRideLines:
            accessGranted = entrant is SkipAllRideLinesAccessible
        // Discount Access
        case .FoodDiscount:
            accessGranted = entrant is FoodDiscountAccessible
        case .MerchanDiscount:
            accessGranted = entrant is MerchanDiscountAccesible
        }

        if accessGranted {
            print("Access to \(access) is granted")
            playSound(url: Access.granted.fileUrl)
        } else {
            print("Access to \(access) is denied")
            playSound(url: Access.denied.fileUrl)
        }

        return accessGranted

    }



    static func checkSwipeForRide(entrant: EntrantType, lastTimeSwiped: Date?) -> Bool {
        //Check the privilege
        guard Swiper.check(entrant: entrant, access: .AllRides) else {
            return false
        }
        var delegate: SwipeDelegate?
        delegate = SwipeDelegateType()
        
        guard let a = delegate?.hasRecentlySwiped(lastTimeSwiped: lastTimeSwiped) else {
            return true
        }
        if a {
            print("PLease wait at least 5 minutes between 2 rides")
            return false
        } else {
            print("Welcome !")
            return true
        }
        
    }
    static func checkSwipeForFoodDiscount(entrant: EntrantType) -> (Bool, Int) {
        guard Swiper.check(entrant: entrant, access: .FoodDiscount) else {
            return (false, 0)
        }
        let entrantFoodDiscount = entrant as! FoodDiscountAccessible
        return (true, entrantFoodDiscount.foodDiscount!)
    }

    static func checkSwipeForMerchanDiscount(entrant: EntrantType) -> (Bool, Int) {
        guard Swiper.check(entrant: entrant, access: .MerchanDiscount) else {
            return (false, 0)
        }
        let entrantMerchandiseDiscount = entrant as! MerchanDiscountAccesible
        return (true, entrantMerchandiseDiscount.merchanDiscount!)
    }

    static func playSound(url: URL) {
        AudioServicesCreateSystemSoundID(url as CFURL, &sound)
        AudioServicesPlaySystemSound(sound)
    }
    

}
