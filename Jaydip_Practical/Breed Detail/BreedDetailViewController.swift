//
//  BreedDetailViewController.swift
//  Jaydip_Practical
//
//  Created by Moksh Marakana on 01/07/24.
//

import UIKit

class BreedDetailViewController: UIViewController {

    var nameStr = String()
    private var breedDetailViewModel = BreedDetailViewModel()
    
    var arrBreed = [String]() {
        didSet {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.collectionviewBreed.reloadData()
            }
            
        }
    }
    @IBOutlet weak var collectionviewBreed: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = nameStr
        registerCell()
        breedDetailViewModel.fetchBreedsDetail(name: nameStr){ result in
            switch result {
            case .success(let breedsResponse):
                self.arrBreed = breedsResponse.message ?? []
            case .failure(let error):
                // Handle error
                print("Failed to fetch dog breeds: \(error)")
            }
        }
    }

    func registerCell() {
        collectionviewBreed.register(UINib(nibName: "BreedDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BreedDetailCollectionViewCell")

    }
    
    @IBAction func btnBackAction(_ sender:UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension BreedDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrBreed.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BreedDetailCollectionViewCell", for: indexPath) as! BreedDetailCollectionViewCell
        cell.imgBreed.sd_setImage(with: URL(string: arrBreed[indexPath.item]))
        if DatabaseManager.shared.isFav(arrBreed[indexPath.item]) {
            cell.btnfav.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            
        } else {
            cell.btnfav.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        let smallConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        cell.btnfav.setPreferredSymbolConfiguration(smallConfig, forImageIn: .normal)
        cell.btnfav.addTarget(self, action: #selector(addremoveFav(_:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width-20)/3, height: (collectionView.bounds.width-20)/3)
    }
    @objc func addremoveFav(_  sender:UIButton) {
        let point: CGPoint = sender.convert(.zero, to: collectionviewBreed)
        if let indexPath = collectionviewBreed.indexPathForItem(at: point) {
            if DatabaseManager.shared.isFav(arrBreed[indexPath.item]) {
                DatabaseManager.shared.removeFav(arrBreed[indexPath.item])
            } else {
                DatabaseManager.shared.addFav(name: nameStr, imgUrl: arrBreed[indexPath.item])
            }
            collectionviewBreed.reloadData()
        }
    }
}
