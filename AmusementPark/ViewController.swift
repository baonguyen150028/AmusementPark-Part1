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
        // Do any additional setup after loading the view, typically from a nib.
     let person = Information(firstName: "a", lastName: "b", streetAddress: "c", city: "d", state: "e", zipCode: 23, socialSecurityNumber: 45, dateOfBirth: nil, ManagementTier: "CEO")
     let pass = PersonGeneration(entrant: person, entrantType: HourlyEmployeeType.FoodServices)
        pass.printEntrant()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

