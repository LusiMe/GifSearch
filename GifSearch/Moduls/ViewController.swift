//
//  ViewController.swift
//  GifSearch
//
//  Created by Luda Parfenova on 08/08/2021.
//

import UIKit
import SwiftyJSON
import FLAnimatedImage

class ViewController: UIViewController  {

    var isSearching = false
    var gifUrls = [URL]()
    var gifSearchResult = [Model]()
    var gifImage = [String]()
    var root = [Root]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
}
extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        isSearching = true
        ServerCommunication.sharedInstance.searchRequest(key: searchText, onSuccess: onSearchSuccess, onFailure: onSearchFailure)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return isSearching == false
    }
    
    
   private func onSearchSuccess(result: JSON){
    let jsonData = result.rawString()?.data(using: .utf8);
    if let root = try? JSONDecoder().decode(Root.self, from: jsonData!) {
        for r in root.data {
            gifUrls.append(r.images.downsized.url.absoluteURL)
        }
        self.collectionView.reloadData()
    }
   }

    private func onSearchFailure(error: Error) {
        print(error)
    }
}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? gifUrls.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        if isSearching {
            if gifUrls.count > 0 {
                cell.setGif(url:  gifUrls[indexPath.row])
            }
        }
        return cell
    }
}

