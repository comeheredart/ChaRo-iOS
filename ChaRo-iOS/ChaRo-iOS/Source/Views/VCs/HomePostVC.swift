//
//  HomePostVC.swift
//  ChaRo-iOS
//
//  Created by 박익범 on 2021/07/07.
//

import UIKit

protocol SetTopTitleDelegate {
    func setTopTitle(name: String)
}

class HomePostVC: UIViewController {
    @IBOutlet weak var NavigationTitleLabel: UILabel!
    @IBOutlet weak var homePostNavigationView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var famousButton: UIButton!
    @IBOutlet weak var newUpdateButton: UIButton!
    @IBOutlet weak var dropDownTableview: UITableView!
    var delegate : SetTopTitleDelegate?
    var isFirstLoaded = true
    var cellCount = 6
    var topCVCCell : HomePostDetailCVC?
    
    func cellInit(){
        
            }
    
    
    static let identifier : String = "HomePostVC"
    
    func setTableView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCustomXib(xibName: "CommonCVC")
        collectionView.registerCustomXib(xibName: "HomePostDetailCVC")
    }
    
    func setDropdown(){
        dropDownTableview.registerCustomXib(xibName: "HotDropDownTVC")
        dropDownTableview.registerCustomXib(xibName: "NewTVC")
        dropDownTableview.delegate = self
        dropDownTableview.dataSource = self
        dropDownTableview.separatorStyle = .none
    }
    func setShaow(){
        homePostNavigationView.getShadowView(color: UIColor.black.cgColor, masksToBounds: false, shadowOffset: CGSize(width: 0, height: 0), shadowRadius: 8, shadowOpacity: 0.3)
    }
    func setRound(){
        dropDownTableview.layer.masksToBounds = true
        dropDownTableview.layer.cornerRadius = 20
        dropDownTableview.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setShaow()
        setDropdown()
        setRound()


        // Do any additional setup after loading the view.
    }
 
    @IBAction func backButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension HomePostVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommonCVC", for: indexPath) as? CommonCVC else { return UICollectionViewCell() }
        
        guard let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePostDetailCVC", for: indexPath) as? HomePostDetailCVC else {return UICollectionViewCell()}
        topCell.delegateT = self
        if isFirstLoaded {
            isFirstLoaded = false
            topCVCCell = topCell
        }
        switch indexPath.row {
        case 0:
            topCVCCell!.setLabel()
            return topCVCCell!
        default:
            cell.imageView.image = UIImage(named: "tempImageBig.png")
            return cell
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let Cellwidth = UIScreen.main.bounds.width - 40
        
        switch indexPath.row {
        case 0:
            return CGSize(width: Cellwidth, height: 55)
        default:
            return CGSize(width: Cellwidth, height: 260)
        
        }
        
    }
    
    
}

extension HomePostVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: HotDropDownTVC = tableView.dequeueReusableCell(for: indexPath)
            var bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.mainBlue.withAlphaComponent(0.2)
            cell.selectedBackgroundView = bgColorView
            cell.setLabel()
            cell.setCellName(name: "인기순")
            cell.delegate = self
            return cell

        case 1:
            let cell: HotDropDownTVC = tableView.dequeueReusableCell(for: indexPath)
            var bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.mainBlue.withAlphaComponent(0.2)
            cell.selectedBackgroundView = bgColorView
            cell.setCellName(name: "최신순")
            cell.delegate = self
            return cell

        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let HotCell: HotDropDownTVC = tableView.dequeueReusableCell(for: indexPath)
        if indexPath.row == 0 {
            HotCell.setSelectedCell()
            
        }

    }
}

extension HomePostVC: MenuClickedDelegate{
    func menuClicked(){
        dropDownTableview.isHidden = false
    }
    
}

extension HomePostVC: SetTitleDelegate {
    func setTitle(cell: HotDropDownTVC) {

        delegate?.setTopTitle(name: cell.name)
        dropDownTableview.isHidden = true
        topCVCCell?.setTitle(data: cell.name)
        
    }
    
}
