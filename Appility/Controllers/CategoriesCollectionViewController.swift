//
//  CategoriesCollectionViewController.swift
//  Appility
//
//  Created by Diego Salazar on 2/26/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CategoryCell"

class CategoriesCollectionViewController: UICollectionViewController, AppsManagerDelegate {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    let appManager = AppsManager()
    
    func didLoadApps() {
        self.collectionView!.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appManager.delegate = self
        appManager.loadApps()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
        if styleForTraitCollection(newCollection) != styleForTraitCollection(traitCollection) {
            self.collectionView!.reloadData() // Reload cells to adopt the new style
        }

    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        if styleForTraitCollection(traitCollection) == .table {
            flowLayout.invalidateLayout() // Called to update the cell sizes to fit the new collection view width
        }

    }
    
    // MARK: Private Methods
    private func styleForTraitCollection(traitCollection: UITraitCollection) -> CategoryCellDisplayStyle {
        return traitCollection.horizontalSizeClass == .Regular ? .grid : .table
    }

    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "listofAppsSegue" {
            let cell = sender as! CategoryCollectionViewCell
            if let indexPath = self.collectionView?.indexPathForCell(cell) {
                let appCVC = segue.destinationViewController as! AppsCollectionViewController
                appCVC.apps = appManager.categories[appManager.listOfCategories[indexPath.row]]!
            }
        }
        
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appManager.categories.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CategoryCollectionViewCell
        cell.categoryNameLabel.text = appManager.listOfCategories[indexPath.row]
        cell.categoryIcon.layer.cornerRadius = 27.0
        cell.categoryIcon.clipsToBounds = true
        getAppIcon(forCategory: cell.categoryNameLabel.text!, withOutlet: cell.categoryIcon)
        cell.displayStyle = styleForTraitCollection(traitCollection)
        
        return cell
    }
    
    // MARK: Cell download
    
    func getAppIcon(forCategory category: String, withOutlet outlet: UIImageView) {
        let iconURL = NSURL(string: (appManager.categories[category]?.first!.logo53)!)!
        let session = NSURLSession.sharedSession().dataTaskWithURL(iconURL) { (data, response, error) in
            guard let data = data else {
                print("Oops! something is wrong downloading the image 53x53..")
                return
            }
            let image = UIImage(data: data)
            dispatch_async(dispatch_get_main_queue(), {
                outlet.image = image
            })
        }
        session.resume()
    }
}


extension CategoriesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return styleForTraitCollection(traitCollection).collectionViewEdgeInsets
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return styleForTraitCollection(traitCollection).itemSizeInCollectionView(collectionView)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return styleForTraitCollection(traitCollection).collectionViewLineSpacing
    }
}


extension CategoryCellDisplayStyle {
    func itemSizeInCollectionView(collectionView: UICollectionView) -> CGSize {
        switch (self) {
        case .table:
            return CGSize(width: collectionView.bounds.width - 16, height: 60)
        case .grid:
            return CGSize(width: 300, height: 120)
        }
    }
    
    var collectionViewEdgeInsets: UIEdgeInsets {
        switch (self) {
        case .table:
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        case .grid:
            return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
    }
    
    var collectionViewLineSpacing: CGFloat {
        switch (self) {
        case .table:
            return 0
        case .grid:
            return 44
        }
    }
}
