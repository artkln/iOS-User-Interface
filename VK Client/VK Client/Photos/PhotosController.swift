//
//  PhotosController.swift
//  VK Client
//
//  Created by Артём Калинин on 11.03.2021.
//

import UIKit

class PhotosController: UIViewController {

    var selectedIndex: Int = 0
    var selectedPhotos: [UIImage] {
        get {
            let friendName = FriendsController.selectedFriend!
            let friend = FriendsController.filteredData[FriendsController.filteredData.firstIndex(where: {(friend) -> Bool in
                                                                                                        friend.name == friendName})!]
            return friend.photos
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor(red: 0.83, green: 0.80, blue: 0.72, alpha: 1.00)
    }
}

extension PhotosController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        
        let friendPhotos = selectedPhotos
        cell.configure(image: friendPhotos[indexPath.item])
        
        return cell
    }
    
    private func willDisplayCellAnimation(cell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.5,
                       delay: 0.25,
                       options: [],
                       animations: {
                        cell.alpha = 1
                       },
                       completion: nil)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.25,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    private func didEndDisplayingCellAnimation(cell: UICollectionViewCell) {
        UIView.animate(withDuration: 0.5,
                       delay: 0.25,
                       options: [],
                       animations: {
                        cell.alpha = 0
                       },
                       completion: nil)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.25,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplayCellAnimation(cell: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        didEndDisplayingCellAnimation(cell: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = collectionView.bounds.width
        let insets = collectionView.contentInset.left + collectionView.contentInset.right
        width -= insets
        width -= 8
        width /= 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        performSegue(withIdentifier: "toBrowse", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBrowse",
           let destination = segue.destination as? BrowsingPhotosViewController {
            destination.selectedIndex = selectedIndex
            destination.browsingPhotos = selectedPhotos
        }
    }
}
