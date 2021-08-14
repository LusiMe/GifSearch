//
//  ViewController.swift
//  GifSearch
//
//  Created by Luda Parfenova on 08/08/2021.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController  {
    
    var gifUrls = [URL]()
    var isSearching = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        ServerCommunication.sharedInstance.getTrandingGIFs(onSuccess: onSuccess, onFailure: onFailure)
    }
    
}
extension ViewController : UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        if !searchText.isEmpty {
        ServerCommunication.sharedInstance.getGIFURLsByName(key: searchText, onSuccess: onSuccess, onFailure: onFailure)
        } else {
            ServerCommunication.sharedInstance.getTrandingGIFs(onSuccess: onSuccess, onFailure: onFailure)
        }
    }
    
    private func onSuccess(result: JSON) {
        gifUrls = Helpers.getGIFURLs(result: result)
        self.collectionView.reloadData()
    }
    
    private func onFailure(error: Error) {
        print(error)
    }
}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            if gifUrls.count > 0 {
                cell.setGif(url:  gifUrls[indexPath.row])
            }
        return cell
    }
}

