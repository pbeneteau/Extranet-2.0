//
//  ViewController.swift
//  Extranet 2.0
//
//  Created by Paul Bénéteau on 14/02/2018.
//  Copyright © 2018 Paul Bénéteau. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Alamofire.request("https://auth.myefrei.fr/uaa/login").responseString { response in // method defaults to `.get`
            print(response.result.value!)
            
            if let data = response.result.value {
            
                let csrf = data.slice(from: "value=\"", to: "\"/>")
            
                print(csrf!)
                
                self.login(user: "20160018", password: "M0nsterk@t", token: csrf!)
            }
            
        }
        
    }

    func login(user: String, password: String, token: String) {
        
        let parameters = [ "username" : user, "password" : password, "csrf_token" : token]
        
        Alamofire.request("https://auth.myefrei.fr/uaa/login", method: .post , parameters: parameters).responseString { response in
            
            print(response)
            
            self.load()
            
            
        }
        
    }
    
    func load() {
        
        let url = "https://www.myefrei.fr/api/extranet/student/queries/student-courses-semester?semester=S4&year=2017-2018"
        
        Alamofire.request(url, method: .get).responseString { response in
            
            print(response)
            
            
        }
        
    }

}

extension String {
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
