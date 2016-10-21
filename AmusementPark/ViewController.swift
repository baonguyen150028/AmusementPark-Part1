//
//  ViewController.swift
//  AmusementPark
//
//  Created by The Bao on 10/20/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameDefault: Name
        let addressDefault: Address
        let dateOfBith: String? = "09/23/1997"
        let socialSecurityNumber: Int? = 243
        let managementTier: String? = "CEO"
        do {
            nameDefault = try Name(firstName: "Darth", lastName: "Vader")
            addressDefault = try Address(streetAddress: "QL14B", city: "Da Nang", state: "Da Nang", zipCode: 55000)
        } catch let error {
            fatalError("\(error)")
        }
        let aClassic = PassGeneration.generate(kind: .Classic)
        let aManager = PassGeneration.generate(kind: .Manager(nameDefault, addressDefault, dateOfBith, socialSecurityNumber, managementTier))
        print(swipeForRide(entrant: aClassic))
        print(swipeForFoodDiscount(entrant: aManager))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func swipeForRide(entrant: EntrantType) -> Bool {
        return Swiper.checkSwipeForRide(entrant: entrant)
    }
    func swipeForFoodDiscount(entrant: EntrantType) -> (Bool, Int) {
        return Swiper.checkSwipeForFoodDiscount(entrant: entrant)
    }
    func swipeForMerchanDiscount(entrant: EntrantType) -> (Bool, Int) {
        return Swiper.checkSwipeForMerchanDiscount(entrant: entrant)
    }


   }

