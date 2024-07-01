//
//  FavouriteViewController.swift
//  Jaydip_Practical
//
//  Created by Moksh Marakana on 01/07/24.
//

import UIKit
import SDWebImage

class FavouriteViewController: UIViewController {
    var arrFav = [String]() 
    var arrCategory = [String]()
    @IBOutlet weak var collectionviewFavorite: UICollectionView!
    @IBOutlet weak var btnFilter: UIButton!
    
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var tblFilter: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        arrFav = DatabaseManager.shared.getfavourite()
        if arrFav.count > 0 {
            btnFilter.setTitle("All", for: .normal)
            btnFilter.isHidden = false
        } else {
            btnFilter.isHidden = true
        }
        arrCategory = DatabaseManager.shared.getUniqueCategory()
        if arrCategory.count > 0 {
            self.arrCategory.insert("All", at: 0)
            tblFilter.reloadData()
            print(min(200, tblFilter.contentSize.height))
            tblHeightConstraint.constant = min(200, tblFilter.contentSize.height)
            self.view.layoutIfNeeded()
        }
       
    }
    
    @IBAction func btnFilterPress(_ sender: UIButton) {
        viewFilter.isHidden = !viewFilter.isHidden
    }
    
    @IBAction func btnBackPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func registerCell() {
        collectionviewFavorite.register(UINib(nibName: "BreedDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BreedDetailCollectionViewCell")
    }

}

extension FavouriteViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFav.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreedDetailCollectionViewCell", for: indexPath) as! BreedDetailCollectionViewCell
        cell.imgBreed.sd_setImage(with: URL(string: arrFav[indexPath.item]))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.view.layoutIfNeeded()
        return CGSize(width: (collectionView.bounds.width-20)/3, height: (collectionView.bounds.width-20)/3)
    }
}
extension FavouriteViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCategory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell")!
        let lblName = cell.contentView.viewWithTag(101) as! UILabel
        lblName.text = arrCategory[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrFav.removeAll()
        if indexPath.item == 0 {
            arrFav = DatabaseManager.shared.getfavourite()
        } else {
            arrFav = DatabaseManager.shared.filterCategory(arrCategory[indexPath.row])
        }
        collectionviewFavorite.reloadData()
        viewFilter.isHidden = true
        btnFilter.setTitle(arrCategory[indexPath.row], for: .normal)
    }
}
