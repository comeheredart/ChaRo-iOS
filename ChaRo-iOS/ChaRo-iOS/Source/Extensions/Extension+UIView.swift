//
//  Extension+UIView.swift
//  ChaRo-iOS
//
//  Created by 장혜령 on 2021/06/29.
//

import UIKit

extension UIView{
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    func removeAllSubViews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func getDeviceHeight() -> Int{
        return Int(UIScreen.main.bounds.height)
        }
    func getDeviceWidth() -> Int{
        return Int(UIScreen.main.bounds.width)
    }

}

