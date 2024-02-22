//
//  ContentListCell.swift
//  DiagnalTest
//
//  Created by Sweta Jaiswal on 16/02/24.
//

import UIKit

class ContentListCell: UICollectionViewCell {

    /// IBOutlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    /// Variables
    static var identifier: String {
        return String(describing: self)
    }

    var content: Content? {
        didSet {
            showContentListDetails()
        }
    }


    //MARK: - Life cycle

    override func awakeFromNib() {
        super.awakeFromNib()

        titleLbl.sizeToFit()
    }

    /// Show content details
    private func showContentListDetails() {
        guard let content = content else { return }
        
        self.titleLbl.text = content.name
        self.imageView.image = UIImage(named: content.posterImage) ?? Icons.placeholderImage
    }

}
