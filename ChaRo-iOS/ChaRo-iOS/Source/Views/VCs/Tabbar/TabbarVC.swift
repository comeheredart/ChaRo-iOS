//
//  TabbarVCViewController.swift
//  ChaRo-iOS
//
//  Created by 장혜령 on 2021/07/02.
//

import UIKit


class TabbarVC: UITabBarController {
    
    static let identifier = "TabbarVC"
    public var addressMainVC: AddressMainVC?
    public var tabs: [UIViewController] = []
    private var comeBackIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbar()
        setTabbarCustomFrame()
    }


    private func setTabbarCustomFrame() {

        let customTabbar = tabBar
        var newFrame = CGRect(x: 0,
                              y: self.view.frame.size.height - 250,
                              width:  self.view.frame.size.width,
                              height: 250)
        
        
        print(newFrame)
        
        // 이 로그는 나중에 지울게요!
       //customTabbar.backgroundImage = UIImage(named: "tabbarBackground")
//        newFrame.size.height = 150
//        newFrame.origin.y = self.view.frame.size.height - newFrame.size.height
        customTabbar.frame = newFrame
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedViewController = tabs[comeBackIndex]
    }
    
    
    internal override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        
        if item.title == "작성하기" {
            let createStoryboard = UIStoryboard(name: "CreatePost", bundle: nil)

            let createVC = createStoryboard.instantiateViewController(identifier: CreatePostVC.identifier)
            let createTab = UINavigationController(rootViewController: createVC)

            createTab.modalPresentationStyle = .fullScreen
            self.present(createTab, animated: false, completion: nil)
        }else if item.title == "나의 차로" {
            comeBackIndex = 2
        }else {
            comeBackIndex = 0
        }
        
        print("comeBackIndex = \(comeBackIndex)")
        
    }
    
    
    private func configTabbar(){
        
        let customTabbar = tabBar
        customTabbar.tintColor = .blue
        customTabbar.backgroundColor = UIColor.white

        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = homeStoryboard.instantiateViewController(identifier: "HomeVC")
        let homeTab = UINavigationController(rootViewController: homeVC)
        homeTab.tabBarItem = UITabBarItem(title: "구경하기", image: UIImage(named: "tabbarIcHomeInactive"), selectedImage: UIImage(named: "tabbarIcHomeActive"))
        
       
        let createStoryboard = UIStoryboard(name: "CreatePost", bundle: nil)

        let createVC = createStoryboard.instantiateViewController(identifier: CreatePostVC.identifier)
        let createTab = UINavigationController(rootViewController: createVC)
        
        createTab.tabBarItem = UITabBarItem(title: "작성하기", image: UIImage(named: "tabbarIcPostWrite"), selectedImage: UIImage(named: "tabbarIcPostWrite"))
        createTab.tabBarItem.imageInsets = UIEdgeInsets(top: -13, left: 0, bottom: 5, right: 0)

        
        let myPageStoryboard = UIStoryboard(name: "MyPage", bundle: nil)
        let myPageVC = myPageStoryboard.instantiateViewController(identifier: "MyPageVC")
        let myPageTab = UINavigationController(rootViewController: myPageVC)
        myPageTab.navigationBar.isHidden = true
        myPageTab.tabBarItem = UITabBarItem(title: "나의차로", image: UIImage(named: "tabbarIcMypageInactive"), selectedImage: UIImage(named: "tabbarIcMypageActive"))
        

        tabs = [homeTab,createTab, myPageTab]
        
        setViewControllers(tabs, animated: true)
        selectedViewController = homeTab
    }
    
}

