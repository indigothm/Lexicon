//
//  Networking.swift
//  Lexicon
//
//  Created by Ilia Tikhomirov on 09/02/16.
//  Copyright © 2016 Ilia Tikhomirov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation
import SwiftSpinner

class Networking: NSObject {
    
     static let sharedInstance = Networking()
    
    func getVenueTypeForLocation(location: CLLocation, completionHandler: (String) -> Void) {
        
        Alamofire.request(.GET, "https://api.foursquare.com/v2/venues/search", parameters: ["client_id": "RDW0E0DD4V1UFGVCFG44EHTMZWNFY3UKBUCP5BCD1AFQAKG1", "client_secret": "FLUFLJOP0ULA5G04VD302PVQX4WWCHQ434T53WDMUW2ZRUYY", "ll": String(location.coordinate.latitude) + "," + String(location.coordinate.longitude), "limit": 3, "intent": "checkin", "v": "20140806"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                print("STATUS CODE!!!")
                print(response.response?.statusCode)
                
                if response.response?.statusCode == nil {
                    SwiftSpinner.show("Failed to connect", animated: false).addTapHandler({
                        completionHandler("Error")
                    })
                }
                
                if let code = response.response?.statusCode {
                
                    if code == 200 {
               
                let json = JSON(response.result.value!)
    
                    print("JSON: \(json)")
                
                    print("Venues!")
                    print(json["response"]["venues"])
                    print("categories!")
                    print(json["response"]["venues"][0]["categories"])
                    print("Meow!")
                    print(json["response"]["venues"][0]["categories"][0]["shortName"].string)
                
                
                    let value = json["response"]["venues"][0]["categories"][0]["shortName"].string
                        
                    if let returVal = value {
                
                    completionHandler(returVal)
                        
                        
                    } else {
                        
                        SwiftSpinner.show("Server Error", animated: false).addTapHandler({
                            completionHandler("Error")
                        })
                        
                    }
                    
                    } else {
                        SwiftSpinner.show("Server Error", animated: false).addTapHandler({
                            completionHandler("Error")
                        })
                    }
                
                }

                
                
        }
        
    }
    

}