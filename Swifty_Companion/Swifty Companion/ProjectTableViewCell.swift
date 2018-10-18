//
//  ProjectTableViewCell.swift
//  Swifty Companion
//
//  Created by Lance CHANT on 2018/10/16.
//  Copyright © 2018 Lance CHANT. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var projectScore: UILabel!
    var ProjectList : (Bool, Int, String)? {
        didSet {
            if let projects = ProjectList {
                projectName?.text = projects.2
                projectScore?.text = String(projects.1)
            }
        }
    }

}
