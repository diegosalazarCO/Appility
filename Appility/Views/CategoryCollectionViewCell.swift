//
//  CategoryCollectionViewCell.swift
//  Appility
//
//  Created by Diego Salazar on 2/26/17.
//  Copyright © 2017 Diego Salazar. All rights reserved.
//

import UIKit

/*!
 Styles for the Categories
 - Table: Display the cell in a table style. (iPhone)
 - Grid:  Display the cell in a grid style. (iPad)
 */
enum CategoryCellDisplayStyle {
    case table
    case grid
}

private struct BorderSettings {
    static let width: CGFloat = 1.0 / UIScreen.mainScreen().scale
    static let colour = UIColor(white: 0.9, alpha: 1.0)
}

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    /// The display style of the receiver.
    var displayStyle: CategoryCellDisplayStyle = .table {
        didSet {
            switch (displayStyle) {
            case .table:
                stackView.axis = .Horizontal
            case .grid:
                stackView.axis = .Vertical
            }
        }
    }
    
    var category: String? {
        didSet {
            if let category = category {
                categoryNameLabel.text = category
                categoryIcon.image = UIImage(named: category)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = BorderSettings.colour
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay() // Redraw the border
    }
    

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let path: UIBezierPath
        switch (displayStyle) {
        case .table:
            path = UIBezierPath()
            path.moveToPoint(CGPoint(x: layoutMargins.left, y: rect.maxY - BorderSettings.width))
            path.addLineToPoint(CGPoint(x: rect.maxX, y: rect.maxY - BorderSettings.width))
        case .grid:
            path = UIBezierPath(rect: rect)
        }
        
        path.lineWidth = BorderSettings.width;
        BorderSettings.colour.set()
        path.stroke()
    }

}

