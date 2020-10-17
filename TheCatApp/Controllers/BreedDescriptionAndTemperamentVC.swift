//
//  BreedDescriptionAndTemperamentVC.swift
//  TheCatApp
//
//  Created by Nathan Novacek on 10/16/20.
//

import Foundation
import UIKit

class BreedDescriptionAndTemperamentVC: UIViewController {
    
    var descriptionAndTemperament: [Mirror.Child]!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperament: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.contentMode = .scaleToFill
        temperament.contentMode = .scaleToFill
        descriptionLabel.numberOfLines = 0
        temperament.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        temperament.lineBreakMode = .byWordWrapping
        
        if let description = descriptionAndTemperament[0].value as? String {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "Unknown"
        }
        
        if let temp = descriptionAndTemperament[1].value as? String {
            temperament.text = temp
        } else {
            temperament.text = "Unknown"
        }
    }
}
