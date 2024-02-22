//
//  ContentListViewController.swift
//  DiagnalTest
//
//  Created by Sweta Jaiswal on 16/02/24.
//  

import UIKit

class ContentListViewController: UIViewController {

    /// IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    /// Variables
    private var viewModel: ContentListViewModel!
    private var totalPage = 3
    

    //MARK: - Life Cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ContentListViewModel()
        
        initialUISetup()
        loadData()
    }
}


//MARK: - Private methods

extension ContentListViewController {

    private func loadData() {
        viewModel.fetchContentList()

        viewModel.didReceiveContents = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func initialUISetup() {
        setupUI()
        setupNavigationBar()
        setupCollectionView()
    }

    private func setupUI() {
        self.view.backgroundColor = UIColor.black
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(Icons.navigationBar, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
       
        /// Search bar button
        let searchBtn = UIButton(type: .custom)
        searchBtn.setImage(Icons.search, for: .normal)
        searchBtn.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)

        /// Left bar button items
        /// Back Button
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(Icons.back, for: .normal)
        backBtn.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        /// Title
        let titleLbl = UILabel(frame: CGRect(x: 40, y: 0, width: 100, height: 30))
        titleLbl.text = "Romantic Comedy"
        titleLbl.textColor = UIColor.white
        titleLbl.font = Fonts.font(Fonts.Name.helveticaLight, size: 24)

        let backButton = UIBarButtonItem(customView: backBtn)
        let titleLabel = UIBarButtonItem(customView: titleLbl)

        self.navigationItem.leftBarButtonItems = [backButton, titleLabel]
    }

    private func setupCollectionView() {
        collectionView.register(UINib(nibName: ContentListCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: ContentListCell.identifier)
        collectionView.backgroundColor = UIColor.black
        collectionView.showsVerticalScrollIndicator = false
    }

    @objc func searchTapped(_ sender: UIButton) {
        print("Search button tapped!")
    }

    @objc func backButtonTapped(_ sender: UIButton) {
        print("Back button tapped")
    }
}



//MARK: - UICollectionView DataSource

extension ContentListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getContentListCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentListCell.identifier, for: indexPath) as? ContentListCell else {
            fatalError("Unable to dequeue ContentListCell")
        }
        cell.content = viewModel.getContent(indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.currentPage <= totalPage && indexPath.row == viewModel.getContentListCount() - 3 {
            viewModel.currentPage += 1
            viewModel.fetchContentList()
        }
    }
}



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
