//
//  GridTableViewCell.swift
//  TestApp
//
//  Created by Владимир on 26.06.2022.
//

import UIKit

class GridTableViewCell: UITableViewCell {
    @IBOutlet private var collectionView: UICollectionView!
    
    private let itemHeight: CGFloat = 80
    var gridItemNames = ["Машины", "Магазин запчастей",
                         "Запчасти", "Коммерческие",
                         "Штрафы и сервисы", "Ремонт и услуги",
                         "Kolesa Гид", "Прочее"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    private func setupCollectionView() {
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerCell(GridCollectionViewCell.self)
    }
    
}

extension GridTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gridItemNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(GridCollectionViewCell.self, for: indexPath)
        cell.nameLabel.text = gridItemNames[indexPath.row]
        return cell
    }
}

extension GridTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 4, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
