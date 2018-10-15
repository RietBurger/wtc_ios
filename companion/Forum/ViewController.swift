//
//  ViewController.swift
//  tables
//
//  Created by Jeanette Henriette BURGER on 2018/10/04.
//  Copyright © 2018 Jeanette Henriette BURGER. All rights reserved.
//

import UIKit

var code: String = "code"
var accessToken: String = "token"
var token: String = ""
var userToken: String = ""

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func Logout(_ sender: UIBarButtonItem) {
        code = ""
        accessToken = ""
        userToken = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "WTC-4-crop.jpg"))
        let apiCall = ApiController();
        apiCall.getToken();
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    var data = Data.info

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Data.info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "New Topic")
        cell?.textLabel?.text = Data.info[indexPath.row].0
        cell?.detailTextLabel?.text = Data.info[indexPath.row].1
        return cell!
    }
}

