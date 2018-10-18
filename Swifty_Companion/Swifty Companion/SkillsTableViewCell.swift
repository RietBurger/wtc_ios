//
//  SkillsTableViewCell.swift
//  Swifty Companion
//
//  Created by Lance CHANT on 2018/10/17.
//  Copyright © 2018 Lance CHANT. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {

    @IBOutlet weak var SkillsName: UILabel!
    @IBOutlet weak var SkillsPercentage: UILabel!
    @IBOutlet weak var SkillsBar: UIProgressView!
    
    var SkillsList : (String, Double)? {
        didSet {
            if let skills = SkillsList {
                SkillsName?.text = skills.0
                SkillsPercentage?.text = String(skills.1)
                _ = floor(skills.1)
                let decimal = skills.1.truncatingRemainder(dividingBy: 1)
                SkillsBar.setProgress(Float(decimal), animated: true)
//                SkillsBar.transform = SkillsBar.transform.scaledBy(x: 1, y: 10)
            }
        }
    }

}
