//
//  HomeViewController.swift
//  TQIBank
//
//  Created by Roberth Diorges on 11/01/22.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    // MARK: - Variables and Constants
    
    var viewModel: HomeViewModel!
    
    // MARK: - Initializers
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDelegate = self
        setupCollectionView()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        getMenuOptions()
    }
    
    // MARK: - Auxiliary Methods
    
    func getMenuOptions() {
        isLoading(true)
        viewModel.getMenuOptions()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MenuCollectionViewCell.self)
    }
    
    func isLoading(_ loading: Bool) {
        indicatorView.isHidden = !loading
        loading ? indicatorView.startAnimating() : indicatorView.stopAnimating()
    }
}


// MARK: - UICollectionViewDelegate and UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model.menuOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(of: MenuCollectionViewCell.self, for: indexPath) { [weak self] cell in
            guard let self = self else { return }
            let model = self.viewModel.model.menuOptions[indexPath.row]
            cell.setup(option: model)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.startExtract()
    }
}

extension HomeViewController: HomeViewModelViewDelegate {
    func homeViewModelSuccess(_ viewModel: HomeViewModel) {
        collectionView.reloadData()
        isLoading(false)
    }
    
    func homeViewModelFailure(_ viewModel: HomeViewModel, error: Error) {
        isLoading(false)
        debugPrint(error)
    }
}
