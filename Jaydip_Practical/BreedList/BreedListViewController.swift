//
//  BreedListViewController.swift
//  Jaydip_Practical
//
//  Created by Moksh Marakana on 01/07/24.
//

import UIKit

class BreedListViewController: UIViewController {
    
    @IBOutlet weak var collectionviewBreed: UICollectionView!
    private var breedlistViewModel = BreedListViewModel()
    var arrBreed : [String]? = nil {
        didSet {
            if arrBreed != nil {
                DispatchQueue.main.async {
                    self.collectionviewBreed.reloadData()
                }
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() {
            breedlistViewModel.fetchDogBreeds{ result in
                switch result {
                case .success(let breedsResponse):
                    if breedsResponse.status == "success" {
                        self.arrBreed = breedsResponse.message.keys.sorted()
                    } else {
                        self.show_alert(msg: "Something wrong")
                    }
                case .failure(let error):
                    // Handle error
                    print("Failed to fetch dog breeds: \(error)")
                    self.show_alert(msg: "Something wrong")
                }
            }
        } else {
            self.show_alert(msg: NO_INTERNET)
        }
        
    }

    @IBAction func btnFavouriteAction(_ sender: UIButton) {
        let favPage = self.storyboard?.instantiateViewController(withIdentifier: "FavouriteViewController") as! FavouriteViewController
        self.navigationController?.pushViewController(favPage, animated: true)
    }
    
}

extension BreedListViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrBreed?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "breedCell", for: indexPath)
        let lblName = cell.contentView.viewWithTag(101) as! UILabel
        lblName.text = arrBreed?[indexPath.row] ?? ""
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailPage = self.storyboard?.instantiateViewController(withIdentifier: "BreedDetailViewController") as! BreedDetailViewController
        detailPage.nameStr = arrBreed?[indexPath.item] ?? ""
        self.navigationController?.pushViewController(detailPage, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.view.layoutIfNeeded()
        return CGSize(width: (collectionView.bounds.width-20)/3, height: 60)
    }
}
