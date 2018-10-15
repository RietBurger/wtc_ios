//
//  ViewController.swift
//  SwiftyCompanion
//
//  Created by Jeanette Henriette BURGER on 2018/10/15.
//  Copyright © 2018 Jeanette Henriette BURGER. All rights reserved.
//

import UIKit

var code: String = "code"
var accessToken: String = "token"
var token: String = ""
var userToken: String = ""
var uname: String = ""

struct Message: Decodable {
    let id: Int
//    let name: String
//    let users_count: Int
    let login: String
    let url: String

}

///////// JOHANNESBURG /campus.id = 5


class ViewController: UIViewController {
    
//    @IBOutlet weak var tableView: UITableView!
    
    //LOGOUT
//    @IBAction func Logout(_ sender: UIBarButtonItem) {
//        code = ""
//        accessToken = ""
//        userToken = ""
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "WTC_bg"))
        let apiCall = ApiController();
        apiCall.getToken();
        print("this is token \(token)")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var searchInput: UITextField!
    
    @IBAction func searchButton(_ sender: UIButton) {
//        if searchInput.text == "" {
//            print("Please input a username to search")
//        } else {
//            let success = getUser(1)
//        if success == true {
//            getUserInfo(uname: uname)
//        }
        getUser(1)
        getUserInfo(uname: uname)
//            print("this is search button ft")
//        }
    }
    
    func getUser(_ page: Int) {
//        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/users?access_token=" + (token) + "&page=\(page)")!)
        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/campus/5/users?access_token=" + (token) + "&page=\(page)")!) // -- to find jhb only students
//        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/users/rburger?access_token=" + (token) + "&page=\(page)")!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            //                    print(response as Any)
            if error != nil {
                print(error as Any)
            } else {
                guard let data = data else { return }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        do {
                            
                            print("enter d = data. this is response")
                            print(response as Any)
                            print("this is data")
                            print(data as Any)
                            //save data here?
                            let _messages = try JSONDecoder().decode([Message].self, from: data)
                            for message in _messages{
                                //                                Data.messages.append(message)
                                DispatchQueue.main.async {
                                    
                                    if message.login == self.searchInput.text! {
                                        uname = message.login
                                        print("Username found: \(message.login)")
//                                        return true
                                    }
                                }
//                                return true
                                print("hererererere", message.login)
//                                self.tableViewData = [cellData(opened: false, title: message.name, sectionData: ["Cell1", "Cell2", "Cell3", "cell4"], userData: message.created_at)
//                                ]
                            }
//                            DispatchQueue.main.async {
//                                self.tableView.reloadData()
//                            }

                            print("json finished")

                            
                        }
                        catch (let err) {
                            print(err)
                        }
                    }
                }
            }
        }
        task.resume()
//        return true
    }

    func getUserInfo(uname: String) {
        //        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/users?access_token=" + (token) + "&page=\(page)")!)
//        var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/campus/5/users?access_token=" + (token) + "&page=\(page)")!) // -- to find jhb only students
                var request = URLRequest(url: URL(string: "https://api.intra.42.fr/v2/users/" + (uname) + "?access_token=" + (token))!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            print(response as Any)
            if error != nil {
                print(error as Any)
            }
            else if let d = data {
                do {
                    print("enter d = data in getUserInfo")
                    print(data)
                    if let dic = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? [Any] {
                        print(dic)
                        for message in dic {
                            //                                Data.messages.append(message)
                            DispatchQueue.main.async {
                                    print("data: \(message)")
                                    //                                        return true
                                }
                            }
                            //                                return true
//                            print("hererererere", message.login)
                            //                                self.tableViewData = [cellData(opened: false, title: message.name, sectionData: ["Cell1", "Cell2", "Cell3", "cell4"], userData: message.created_at)
                            //                                ]
                        }
            }
            catch (let err) {
                print(err)
            }
            }
        }
        task.resume()
//        return true
    }
}

