//
//  HomeViewController.swift
//  Andela-Challenge
//
//  Created by Renato Mateus on 11/11/21.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    internal let viewModel = HomeViewModel(with: PopularMoviesService())
    var movies: Movies = []
    var dataMovie: DataMovie?
    var page: Int = 0
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
}


// MARK: - Setup UI
extension HomeViewController {
    func setupUI() {
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(UINib(nibName: MovieViewCellCollectionViewCell.identifier,
                                      bundle: nil),
                                forCellWithReuseIdentifier: MovieViewCellCollectionViewCell.identifier)
        
        let spacing: CGFloat = 5
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - SetupData

extension HomeViewController {
    func setupData() {
        viewModel.delegate = self
        self.collectionView.showLoading()
        let page = self.page + 1
        viewModel.fetchData(page)
    }
}

// MARK: - ViewControllerViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func onSuccessFetchingMovies(movies: DataMovie) {
        self.dataMovie = movies
        if let results = movies.results {
            self.page = movies.page ?? 1
            if self.page == 1 {
                self.movies = results
            } else {
                self.movies.append(contentsOf: results)
            }
        }
        self.showCollectionView()
    }
    
    func onFailureFetchingMovies(error: Error) {
        DispatchQueue.main.async {
            self.collectionView.backgroundView = self.getEmptyView()
        }
    }
}

// MARK: - CollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.movies[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCellCollectionViewCell.identifier,
                                                            for: indexPath) as? MovieViewCellCollectionViewCell  else { return  UICollectionViewCell() }
        cell.setupData(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        self.selectMovie(movie)
    }
}

// MARK: - UICollectionViewLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:( self.view.frame.size.width / 2 - 10 ), height: 300)
    }
}

// MARK: - Scroll Delegate
extension HomeViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            self.collectionView.showLoading()
            let page = self.page + 1
            viewModel.fetchData(page)
        }
    }
}

// MARK: - Helpers

private extension HomeViewController {
    func getEmptyView() -> UIView {
        let labelDescription: UILabel = UILabel()
        labelDescription.font = .systemFont(ofSize: 20, weight: .regular)
        labelDescription.textColor = UIColor.darkGray
        labelDescription.numberOfLines = 0
        labelDescription.textAlignment = .center
        labelDescription.text = "Looks like you have a empty data."
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.sizeToFit()
        
        return labelDescription
    }
    
    func showCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.backgroundView = nil
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Selection Movie

extension HomeViewController {
    func selectMovie(_ movie: Movie) {
        DispatchQueue.main.async {
            let controller = DetailViewController(with: movie)
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .overCurrentContext
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}
