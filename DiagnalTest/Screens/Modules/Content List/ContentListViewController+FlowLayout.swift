//
//  ContentListViewController+FlowLayout.swift
//  DiagnalTest
//
//  Created by Sweta Jaiswal on 26/02/24.
//

import Foundation
import UIKit


//MARK: - UICollectionView Flow Layout

extension ContentListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width - 20
        return CGSize(width: Double(width / 3), height: 280.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
}
