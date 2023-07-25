//
//  FoodCollectionView.swift
//  SchoolFoodAlarm
//
//  Created by 최영우 on 7/25/23.
//

import Foundation
import UIKit

class FoodCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    private var CollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout : layout)
        cv.backgroundColor = .gray
        
        return cv
    }()
    
    func configureFoodcollectionView() {
        CollectionView.register(MainCell.self, forCellWithReuseIdentifier: "mainCellID")
        CollectionView.delegate = self
        CollectionView.dataSource = self
    }
}

