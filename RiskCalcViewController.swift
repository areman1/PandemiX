//
//  RiskCalcViewController.swift
//  PandemiX
//
//  Created by Abhinav Emani on 4/26/20.
//  Copyright © 2020 Abhinav Emani. All rights reserved.
//

import UIKit

var userRisk = 0

class RiskCalcViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //case 1
    @IBAction func city(_ sender: Any) {
        userRisk += 10
    }
    @IBAction func suburb(_ sender: Any) {
        userRisk += 5
    }
    @IBAction func rural(_ sender: Any) {
        userRisk += 2
    }
    
    //case 2
    @IBAction func yesOutsideCountry(_ sender: Any) {
        userRisk += 30
    }
    
    //case 3
    @IBAction func yesBeen14days(_ sender: Any) {
        userRisk += 10
    }
    @IBAction func noBeen14days(_ sender: Any) {
        userRisk += 30
    }
    
    //case 4
    @IBAction func householdYes(_ sender: Any) {
        userRisk += 80
    }
    @IBAction func householdNo(_ sender: Any) {
        userRisk += 0
    }
    
    //case 5
    @IBAction func below18(_ sender: Any) {
        userRisk += 15
    }
    
    @IBAction func above65(_ sender: Any) {
        userRisk += 25
    }
    
    //case 6
    var currentValue = 0
    @IBOutlet weak var numConditions: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBAction func conditionsSlider(_ sender: Any) {
        currentValue = Int(sliderOutlet.value)
        numConditions.text = String(currentValue)
    }

    @IBAction func continueScreen(_ sender: Any) {
       userRisk += (currentValue * 10)
        if (userRisk > 50){
            results.text = "You have a mid to high risk of Covid-19"
        } else {
            results.text = "You have a very low risk of Covid-19"
        }
    }
    @IBOutlet weak var results: UILabel!
    
    
}
