//
//  ViewController.swift
//  Swifty Companion
//
//  Created by Lance CHANT on 2018/10/15.
//  Copyright © 2018 Lance CHANT. All rights reserved.
//

import UIKit
import SwiftyJSON

var code: String = "code"
var accessToken: String = "token"
var token: String = ""

class ViewController: UIViewController {

    let apiCall = ApiController();
    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
    
    @IBOutlet weak var Username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteralResourceName: "background"))
        apiCall.getToken();
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func Search(_ sender: UIButton) {
//        guard Username.text != "" else {return}
        let username = Username.text?.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        if username != "" {
            self.view.isUserInteractionEnabled = false
            apiCall.getUser(username: username!) {
                completion in
                
                if completion != nil {
                    jsonData = completion
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                    self.appDelegate.window?.rootViewController = vc
                    self.appDelegate.window?.makeKeyAndVisible()
                    self.view.isUserInteractionEnabled = true
                    
                } else {
                    self.view.isUserInteractionEnabled = true
                    Alert.showBasicAlert(on: self, with: "No User", message: "User doesn't exist")
                }
            }
        }else {
            self.view.isUserInteractionEnabled = true
            Alert.showBasicAlert(on: self, with: "Error", message: "cannot search with that")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

