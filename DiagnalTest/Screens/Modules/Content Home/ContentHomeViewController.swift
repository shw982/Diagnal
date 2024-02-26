//
//  ContentHomeViewController.swift
//  DiagnalTest
//
//  Created by Sweta Jaiswal on 26/02/24.
//

import UIKit

class ContentHomeViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var button: UIButton!
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    //MARK: - Action handling
    
    @IBAction func showContent(_ sender: UIButton) {
        if let contentListVC = self.storyboard?.instantiateViewController(withIdentifier: ContentListViewController.identifier) as? ContentListViewController {
            self.navigationController?.pushViewController(contentListVC, animated: true)
        }
    }
}


//MARK: - Private methods

extension ContentHomeViewController {
    
    func setupUI() {
        /// Navigation bar
        self.navigationItem.title = Strings.homeTitle
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        /// View
        self.view.backgroundColor = .placeholderText
        
        /// Button
        button.setTitle(Strings.showContentList, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
    }
}
