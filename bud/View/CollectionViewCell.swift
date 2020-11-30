//
//  CollectionViewCell.swift
//  bud
//
//  Created by Ashlee Muscroft on 30/11/2020.
//

import UIKit

@IBDesignable
class CollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "transaction-cell-reuse-identifier"
    @IBOutlet weak var productImageView: UIImageView?
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var itemAmount: UILabel!
    var showSeperatorView: Bool = true {
        didSet {
            toggleSeperatorView()
        }
    }
    var defaultBackgroundColor: UIColor!
    var selectedBackgroundColor: UIColor!
    //override default is selected for highlighted text effect.
    override var isSelected: Bool {
        didSet {
            super.isSelected = self.isSelected
            self.backgroundColor = self.isSelected ? selectedBackgroundColor : defaultBackgroundColor
        }
    }
    
}
extension CollectionViewCell {
    func toggleSeperatorView(){
        seperatorView.isHidden = !showSeperatorView
    }
}
