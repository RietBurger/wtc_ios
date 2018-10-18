//
//  ProfileViewController.swift
//  Swifty Companion
//
//  Created by Lance CHANT on 2018/10/15.
//  Copyright © 2018 Lance CHANT. All rights reserved.
//

import UIKit
import SwiftyJSON
import moa

var jsonData: JSON?

struct ProjectList {
    static var data: [(Bool, Int, String)] = []
    
}

struct SkillsList {
    static var skills: [(String, Double)] = []
}

class ProfileViewController: UIViewController {

    
//    @IBAction func Back(_ sender: UIButton) {
//       self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//    }
    @IBAction func Back(_ sender: UIButton) {
        SkillsList.skills.removeAll()
        ProjectList.data.removeAll()
    }
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var LevelLabel: UILabel!
    @IBOutlet weak var Profile: UIImageView!
    @IBOutlet weak var bar: UIProgressView!
    @IBOutlet weak var username: UILabel!
    var i = 0
    var counter = jsonData!["projects_users"].count
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "background"))
        LoadText()
        LoadImage()
//        print(jsonData!["cursus_users"][0]["skills"])
        for skills in jsonData!["cursus_users"][0]["skills"] {
            SkillsList.skills.append((skills.1["name"].stringValue, skills.1["level"].doubleValue))
        }
        
        while counter > 0 {
            
            ProjectList.data.append((jsonData!["projects_users"][i]["validated?"].boolValue, jsonData!["projects_users"][i]["final_mark"].intValue, jsonData!["projects_users"][i]["project"]["slug"].stringValue))
            counter -= 1
            i += 1
        }
        // Do any additional setup after loading the view.
        
    }
//self.dismiss(animated: true, completion: nil) on button press to go back
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LoadText() {
        let level = jsonData!["cursus_users"][0]["level"].doubleValue
        
        username.text = jsonData!["login"].string!
        LevelLabel.text = "Level " + String(level) + " %"
        email.text = jsonData!["email"].string
        year.text = jsonData!["pool_year"].string
        
        _ = floor(level)
        let decimal = level.truncatingRemainder(dividingBy: 1)
        
        bar.setProgress(Float(decimal), animated: true)
        bar.transform = bar.transform.scaledBy(x: 1, y: 20)
    }
    
    func LoadImage() {
        if jsonData!["image_url"].string != nil {
            Profile.moa.onError = { error, response in
//                Alert.showBasicAlert(on: self, with: "Error loading image", message: (error?.localizedDescription)!)
//                self.Profile.moa.url = "https://cdn.intra.42.fr/users/medium_default.jpg"
            }
            Profile.moa.errorImage = UIImage(named: "default")
            Profile.moa.url = "https://cdn.intra.42.fr/users/medium_\(jsonData!["login"].string!).jpg"
            Profile.layer.cornerRadius = Profile.frame.size.width / 2;
            Profile.clipsToBounds = true;
        }
    }

}
