//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Jeanette Henriette BURGER on 2018/10/15.
//  Copyright © 2018 Jeanette Henriette BURGER. All rights reserved.
//

import UIKit
import SwiftyJSON

var code: String = "code"
var accessToken: String = "token"

var token: String = ""

var userToken: String = ""
var uname: String = ""
var uid: String = ""

struct Message: Decodable {
    let email: String
    let login: String
    let firstname: String

}

///////// JOHANNESBURG /campus.id = 5


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "WTC_bg"))
        let apiCall = ApiController(); //called from ApiController.swift
        apiCall.getToken();
        print("this is token \(token)")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var searchInput: UITextField!
    
    @IBAction func searchButton(_ sender: UIButton) {
        uname = searchInput.text!
        getUserInfo()
    }

    func getUserInfo() {
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/users/" + (uname) + "?access_token=" + (token))!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
//            print(response as Any)
            if error != nil {
                print(error as Any)
            }
            else if let d = data {
                do {
                    let json = JSON(d)
                    print("this is CoRrEcTiOn_PoInt: \(json["correction_point"]) for \(uname)")
                    
                }
                catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
        self.searchInput.text = ""
    }
}

