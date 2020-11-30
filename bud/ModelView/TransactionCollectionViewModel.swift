//
//  TransactionCollectionViewModel.swift
//  bud
//
//  Created by Ashlee Muscroft on 29/11/2020.
//

import Foundation
import UIKit



class TransactionCollectionViewModel {
    enum Section {
        case main
    }
    // MARK - Type Values
    typealias DataSource = UICollectionViewDiffableDataSource <Section,TransactionItemModel>

    typealias Snapshot = NSDiffableDataSourceSnapshot<Section,TransactionItemModel>
    
    // MARK - Data Model
    var dataSource: DataSource!
    var initSnapShot: Snapshot!
    
    var uiCollectionViewBackgroundSelectedColor: UIColor = UIColor(red: 250/255, green: 118/255, blue: 120/255, alpha: 1.0)
    var uiCollectionViewCellSelectedTextColor: UIColor = .white
    
}
extension TransactionCollectionViewModel {
    
    func configureDataSource(collectionView: UICollectionView, listItems: [TransactionItemModel]) {
        dataSource = DataSource(collectionView: collectionView) { [self]
            //using custom cell
            collectionView, indexPath, item -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as! CollectionViewCell
            cell.setContentHuggingPriority(.defaultLow, for: .horizontal)
            //fetch images Asynchronously
//            ImageCache.publicCache.load(url: NSURL(string: item.imageUrl)! as NSURL, item: item) {
//                //closure process fetchedItem, fails
//                (fetchedItem, image) in
//                print(fetchedItem)
//                if let img = image, img != fetchedItem.image {
//                    updateItemImage(fetchedItem: fetchedItem, img: img, listItems: listItems)
//                }
//            }
            cell.productImageView?.image = item.image
            cell.itemTitle.text = item.datumDescription
            cell.itemAmount.text = item.amount
            cell.itemDescription.text = item.category
            cell.defaultBackgroundColor = self.uiCollectionViewCellSelectedTextColor
            cell.selectedBackgroundColor = self.uiCollectionViewBackgroundSelectedColor
            cell.showSeperatorView = indexPath.item !=  listItems.count - 1
            return cell
        }
    }
    
    func applySnapshotToSection(listItems: [TransactionItemModel], section: Section = .main) {
        
        var currentSnapshot = Snapshot()
        currentSnapshot.appendSections([.main])
        currentSnapshot.appendItems(listItems, toSection: section)
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    func updateItemImage(fetchedItem: TransactionItemModel, img: UIImage, listItems: [TransactionItemModel]) {
        var updatedSnapshot = self.dataSource.snapshot()
        if let datasourceIndex = updatedSnapshot.indexOfItem(fetchedItem) {
            var item = listItems[datasourceIndex]
            item.image = img
            updatedSnapshot.reloadItems([item])
            dataSource.apply(updatedSnapshot, animatingDifferences: true)
        }
    }
    func reloadSnapshotToSection(listItems: [TransactionItemModel], section: Section = .main) {
        //capture current state of dataSource
        var currentSnapshot = dataSource.snapshot()
        currentSnapshot.reloadSections([section])
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
    func deleteSelectFromSnapshotForSection(selectedListItems: [TransactionItemModel], section: Section = .main) {
        //capture current state of dataSource
        var currentSnapshot = dataSource.snapshot()
        currentSnapshot.deleteItems(selectedListItems)
        dataSource.apply(currentSnapshot, animatingDifferences: true)
    }
    
}
