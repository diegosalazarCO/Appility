//
//  AppsCollectionViewController.swift
//  Appility
//
//  Created by Diego Salazar on 2/24/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "AppCell"

class AppsCollectionViewController: UICollectionViewController {
    
    var apps: [App]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = apps!.first!.category
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AppDetailSegue" {
            let appDetailViewController = segue.destinationViewController as! AppDetailViewController
            let cell = sender as! AppCell
            if let indexPath = self.collectionView?.indexPathForCell(cell) {
                appDetailViewController.app = apps![(indexPath.row)]
            }
        }
    }

    
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps!.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! AppCell
        cell.appNameLabel.text = apps![indexPath.row].name
        cell.appIcon.layer.cornerRadius = 27.0
        cell.appIcon.clipsToBounds = true
        getAppIcon(forItemAtIndex: indexPath.row, withOutlet: cell.appIcon)
        
        return cell
    }
    
    func getAppIcon(forItemAtIndex indexPath: Int, withOutlet outlet: UIImageView) {
        let iconURL = NSURL(string: apps![indexPath].logo100!)!
        let session = NSURLSession.sharedSession().dataTaskWithURL(iconURL) { (data, response, error) in
            guard let data = data else {
                print("Oops! something is wrong downloading the image..")
                return
            }
            let image = UIImage(data: data)
            dispatch_async(dispatch_get_main_queue(), { 
                outlet.image = image
            })
        }
        session.resume()
    }

    // MARK: UICollectionViewDelegate

}
