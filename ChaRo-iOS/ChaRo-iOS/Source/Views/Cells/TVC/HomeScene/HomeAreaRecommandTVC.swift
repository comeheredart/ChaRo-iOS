//
//  HomeAreaRecommandTVC.swift
//  ChaRo-iOS
//
//  Created by JEN Lee on 2021/07/06.
//

import UIKit

class HomeAreaRecommandTVC: UITableViewCell {

    //MARK:- IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreLabel: UILabel!
    var delegate: IsSelectedCVCDelegate?
    var buttonDelegate: SeeMorePushDelegate?
    var postDelegate: PostIdDelegate?
    let cellTag : Int = 5
    //MARK:- Variable
    static let identifier = "HomeAreaRecommandTVC"

    var headerText: String = ""
    var localList: [DriveElement] = []
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollctionView()
        setLabelUI()
        //cellInit()
    }

    
    //MARK:- default Setting Function Part
    func setCollctionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCustomXib(xibName: "CommonCVC")
        
    }
    
    func setLabelUI() {
        
        titleLabel.text = headerText
        moreLabel.text = "더보기"
        
        titleLabel.font = UIFont.notoSansBoldFont(ofSize: 17)
        moreLabel.font = UIFont.notoSansRegularFont(ofSize: 12)
        
        titleLabel.textColor = UIColor.mainBlack
        moreLabel.textColor = UIColor.gray40
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        titleLabel.text = headerText
        collectionView.reloadData()
    }
    @IBAction func seeMoreButtonClicked(_ sender: Any) {
        buttonDelegate?.seeMorePushDelegate(data: cellTag)

    }
    
    //MARK:- Function
    
}

//MARK:- extension

extension HomeAreaRecommandTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.isSelectedCVC(indexPath: indexPath)
        
        let cell = collectionView.cellForItem(at: indexPath) as? CommonCVC
        let postid = cell!.postID
        postDelegate?.sendPostID(data: postid)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommonCVC", for: indexPath) as? CommonCVC else { return UICollectionViewCell() }
      
        
        if localList.count == 0 {
            return cell
        }
        else {
            
            let element = localList[indexPath.row]
            
            var tags = [element.region, element.theme,
                        element.warning ?? ""] as [String]
                        
            
            cell.setData(image: element.image,
                         title: element.title,
                         tagCount: tags.count,
                         tagArr: tags,
                         isFavorite: element.isFavorite,
                         postID: element.postID)
            
            return cell
            
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommonCVC", for: indexPath) as? CommonCVC
        cell!.imageView.kf.cancelDownloadTask()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let factor = UIScreen.main.bounds.width / 375
        
        let size = CGSize(width: 160 * factor, height: 230 * factor)
        
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    
}
