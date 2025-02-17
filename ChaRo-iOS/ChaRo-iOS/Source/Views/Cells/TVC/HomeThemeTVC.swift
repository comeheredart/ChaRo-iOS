//
//  ThemeTVC.swift
//  ChaRo-iOS
//
//  Created by JEN Lee on 2021/07/03.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: HomeThemeCVC?, index: Int, didTappedInTableViewCell: HomeThemeTVC)
}


class HomeThemeTVC: UITableViewCell {

    //MARK:- IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var TitleLabel: UILabel!
    
    
    //MARK:- Variable
    static let identifier = "HomeThemeTVC"
    var themeList: [String] = ["산", "바다", "호수", "강", "봄", "여름", "가을", "겨울", "해안도로", "벚꽃", "단풍", "여유", "스피드", "야경", "도심"]
    var ThemeDic: Dictionary = ["봄":"spring", "여름":"summer", "가을":"fall", "겨울":"winter", "산":"mountain", "바다":"sea", "호수":"lake", "강":"river", "해안도로":"oceanRoad", "벚꽃":"blossom", "단풍":"maple", "여유":"relax", "스피드":"speed", "야경":"nightView", "도심":"cityView"]
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setDelegate()
        setLabelUI()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none


    }
    
    
    //MARK:- default Setting Function Part
    func setDelegate() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCustomXib(xibName: HomeThemeCVC.identifier)
    
        
        collectionView.showsHorizontalScrollIndicator = false
    
        
    }
    
    func setLabelUI() {
        
        TitleLabel.text = "테마"
        TitleLabel.textColor = UIColor.mainBlack
        TitleLabel.font = UIFont.notoSansBoldFont(ofSize: 17)
        
    }
    

    
    
    //MARK:- Function
    
}

//MARK:- extension
extension HomeThemeTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeThemeCVC.identifier, for: indexPath) as? HomeThemeCVC else { return UICollectionViewCell() }
        let themeName = themeList[indexPath.row]
        
        cell.themeLabel.textColor = .gray50
        cell.setThemeTitle(name: themeName)
        cell.themeImageView?.image = UIImage(named: ThemeDic[themeName] ?? "gear")
        cell.location = .HomeThemeTVC
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //일단 고정
        return CGSize(width: 64, height: 90)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? HomeThemeCVC
        
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
        
        //홈에서는 선택되었을 때 색이 들어가면 안됨
        cell?.highLightView.backgroundColor = .systemBackground
        cell?.themeImageView.layer.borderWidth = 0
        cell?.themeLabel.textColor = .gray50
        

    }
    
    override func prepareForReuse() {
        
    }
    
    
    
}

