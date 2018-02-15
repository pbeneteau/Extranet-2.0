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
            }
            
        }
        
    }

    func login() {
        
        let parameters = [ "username" : user, "password" : password, "_csrf" : token]
        
        Alamofire.request("https://auth.myefrei.fr/uaa/login").responseString { response in // method defaults to `.get`
            print(response.result.value!)
            
            
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
