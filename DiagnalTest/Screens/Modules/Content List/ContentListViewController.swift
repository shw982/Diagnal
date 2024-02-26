//
//  ContentListViewController.swift
//  DiagnalTest
//
//  Created by Sweta Jaiswal on 26/02/24.
//  

import UIKit

class ContentListViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Variables
    
    private var viewModel: ContentListViewModel!
    private var totalPage = 3
    private var searchBar = UISearchBar()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ContentListViewModel()
        initialUISetup()
        loadData()
    }
}


//MARK: - UICollectionView DataSource

extension ContentListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let inSearchMode = viewModel.inSearchMode(searchBar)
        return inSearchMode ? viewModel.filteredContents.count : viewModel.contents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentListCell.identifier, for: indexPath) as? ContentListCell else {
            fatalError("Unable to dequeue ContentListCell")
        }
        
        let inSearchMode = viewModel.inSearchMode(searchBar)
        let content = inSearchMode ? viewModel.filteredContents[indexPath.row] : viewModel.contents[indexPath.row]
        cell.content = content
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.currentPage <= totalPage && indexPath.row == viewModel.getContentListCount() - 3 {
            viewModel.currentPage += 1
            viewModel.fetchContentList()
        }
    }
}


//MARK: - Search bar delegates

extension ContentListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateSearchList(searchBarText: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        hideSearchBar()
    }
}


//MARK: - Private methods

extension ContentListViewController {

    private func loadData() {
        viewModel.didReceiveContents = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        viewModel.didReceiveError = {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: Strings.error, message: Strings.noDataFound, preferredStyle: .alert)
                let ok = UIAlertAction(title: Strings.ok, style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        }
    }

    private func initialUISetup() {
        setupUI()
        setupNavigationBar()
        setupSearchBar()
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
        searchBtn.addTarget(self, action: #selector(showSearchBar), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
        
        setupRightBarItems()
    }
    
    private func setupRightBarItems() {
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
        collectionView.register(UINib(nibName: ContentListCell.identifier, bundle: nil), forCellWithReuseIdentifier: ContentListCell.identifier)
        collectionView.backgroundColor = UIColor.black
        collectionView.showsVerticalScrollIndicator = false
    }

    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = Strings.search
        searchBar.text = nil
        searchBar.barStyle = .black
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = true
        
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc func showSearchBar(_ sender: UIButton) {
        /// Hide navigation bar back button
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.navigationItem.titleView = searchBar
        searchBar.alpha = 0
        searchBar.text = nil
        self.navigationItem.setLeftBarButtonItems(nil, animated: true)
        self.navigationItem.setRightBarButtonItems(nil, animated: true)
       
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.alpha = 1
        }, completion: { finished in
            self.searchBar.becomeFirstResponder()
        })
    }

    @objc func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Hide search bar
    private func hideSearchBar() {
        /// Show navigation bar back button
        self.navigationItem.setHidesBackButton(false, animated: true)
        
        setupNavigationBar()
        self.navigationController?.view.setNeedsLayout()
        self.navigationController?.view.layoutIfNeeded()
     
        searchBar.resignFirstResponder()
        searchBar.alpha = 0
        viewModel.updateSearchList(searchBarText: searchBar.text)
    }
}

