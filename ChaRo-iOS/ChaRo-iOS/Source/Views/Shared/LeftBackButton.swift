//
//  LeftBackButton.swift
//  ChaRo-iOS
//
//  Created by 장혜령 on 2021/07/11.
//

import UIKit

class LeftBackButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(toPop vc: UIViewController) {
        super.init(frame: .zero)
        setBackgroundImage()
        initAction(vc: vc)
    }
    
   private func setBackgroundImage(){
        setBackgroundImage(UIImage(named: "icBackButton"), for: .normal)
    }
    
    private func initAction(vc: UIViewController) {
        let popAction = UIAction { _ in
            vc.navigationController?.popViewController(animated: true)
        }
        addAction(popAction, for: .touchUpInside)
    }
}
