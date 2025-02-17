//
//  AddressDateModel.swift
//  ChaRo-iOS
//
//  Created by 장혜령 on 2021/07/06.
//

import UIKit
import TMapSDK

struct AddressDataModel: Codable {
    
    var title: String = ""
    var address: String = ""
    var latitude: String = ""
    var longitude: String = ""
    
    
    func displayContent(){
        print("title = \(title)")
        print("address = \(address)")
        print("latitude = \(latitude)")
        print("longtitude = \(longitude)")
    }
    
    func getPoint() -> CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
    }
    
    func getKeywordResult() -> KeywordResult{
        return KeywordResult(title: title,
                             address: address,
                             latitude: latitude,
                             longitude: longitude,
                             year: Date.getCurrentYear(),
                             month: Date.getCurrentMonth(),
                             day: Date.getCurrentDay())
    }
    
    func getAddressDataModel() -> Address{
        return Address(address: address,
                       latitude: latitude,
                       longtitude: longitude)
        
    }
    
}

struct AddressData {
    var title: String
    var address: String
    var latitude: String
    var longitude: String
}
