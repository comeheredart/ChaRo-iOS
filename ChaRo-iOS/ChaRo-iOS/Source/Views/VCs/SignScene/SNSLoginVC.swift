//
//  SNSLoginVC.swift
//  ChaRo-iOS
//
//  Created by JEN Lee on 2021/09/13.
//

import UIKit
import SnapKit
import Then

class SNSLoginVC: UIViewController {

    static let identifier = "SNSLoginVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    let logoImageView = UIImageView().then {
        $0.image = UIImage(named: "logo")
    }
    
    let logoLabel = UILabel().then {
        $0.text = "당신의 드라이브 메이트"
        $0.font = UIFont.notoSansBoldFont(ofSize: 14)
        $0.textColor = .mainBlue
    }
    
    let appleLoginBtn = UIButton().then {
        $0.backgroundColor = .mainBlack
        $0.setTitle("Apple로 로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.notoSansMediumFont(ofSize: 14)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let googleLoginBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("Google 로그인", for: .normal)
        $0.setTitleColor(.mainBlack, for: .normal)
        $0.titleLabel?.font = UIFont.notoSansMediumFont(ofSize: 14)
        $0.layer.borderColor = UIColor.gray30.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let kakaoLoginBtn = UIButton().then {
        $0.backgroundColor = UIColor(red: 254.0 / 255.0, green: 229.0 / 255.0, blue: 0.0, alpha: 1.0)
        $0.setTitle("카카오 로그인", for: .normal)
        $0.setTitleColor(.mainBlack, for: .normal)
        $0.titleLabel?.font = UIFont.notoSansMediumFont(ofSize: 14)
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let emailLoginBtn = UIButton().then {
        $0.setTitle("이메일 로그인", for: .normal)
        $0.setTitleColor(.gray30, for: .normal)
        $0.titleLabel?.font = UIFont.notoSansMediumFont(ofSize: 14)
    }
    
    let emailJoinBtn  = UIButton().then {
        $0.setTitle("이메일로 가입", for: .normal)
        $0.setTitleColor(.gray30, for: .normal)
        $0.titleLabel?.font = UIFont.notoSansMediumFont(ofSize: 14)
    }
    
    
    func configureUI() {
        
        view.addSubviews([logoImageView,
                          logoLabel,
                          appleLoginBtn,
                          googleLoginBtn,
                          kakaoLoginBtn,
                          emailLoginBtn,
                          emailJoinBtn])
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(273)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(221)
            $0.height.equalTo(83)
        }
        
        logoLabel.snp.makeConstraints {
            $0.bottom.equalTo(logoImageView.snp.top)
            $0.height.equalTo(20)
            $0.centerX.equalToSuperview()
        }
        
        appleLoginBtn.snp.makeConstraints {
            $0.bottom.equalTo(googleLoginBtn.snp.top).offset(-14)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(48)
        }

        googleLoginBtn.snp.makeConstraints {
            $0.bottom.equalTo(kakaoLoginBtn.snp.top).offset(-14)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(48)
        }

        kakaoLoginBtn.snp.makeConstraints {
            $0.bottom.equalTo(emailLoginBtn.snp.top).offset(-39)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(48)
        }

        emailLoginBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-55)
            $0.width.equalTo(81)
            $0.height.equalTo(21)
            $0.trailing.equalTo(view.snp.centerX).offset(-12.5)
        }
        
        emailJoinBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-55)
            $0.width.equalTo(81)
            $0.height.equalTo(21)
            $0.leading.equalTo(view.snp.centerX).offset(12.5)
        }
        
    }
    
    
}
