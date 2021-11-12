//
//  DetailViewController.swift
//  Andela-Challenge
//
//  Created by Renato Mateus on 11/11/21.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailContentView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieSnopseLabel: UILabel!
    
    // MARK: - Private Properties
    private let viewModel = DetailViewModel(with: DetailMovieService())
    private let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    private let movie: Movie
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    // MARK: - Inits
    init(with movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailViewController {
    func setupUI() {
        self.spinner.hidesWhenStopped = true
        self.detailContentView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        showLoading()
        self.closeButton.addTarget(self,
                                   action: #selector(didCloseButtonTapped),
                                   for: .touchUpInside)
    }
    
    func showLoading() {
        self.spinner.startAnimating()
    }
    
    func hideLoading() {
        self.spinner.stopAnimating()
    }
    
    func setupData() {
        showLoading()
        viewModel.delegate = self
        if let id = movie.id {
            viewModel.fetchData(id)
        }
    }
}

// MARK: - ViewControllerViewModelDelegate

extension DetailViewController: DetailViewModelDelegate {
    func onSuccessFetchingDetail(movie: DetailMovie) {
        DispatchQueue.main.async {
            self.movieTitleLabel.text = movie.original_title
            self.movieSnopseLabel.text = movie.overview
            let imagePlaceholder = UIImage(named: "placeholder")
            let image = movie.poster_path ?? ""
            let url = URL(string: "\(Constants.imageHost)\(image)")
            self.movieImageView.kf.setImage(with: url,
                                                    placeholder: imagePlaceholder,
                                                    options: nil,
                                                    progressBlock: nil,
                                                    completionHandler: nil)
            
            self.hideLoading()
        }
    }
    
    func onFailureFetchingDetail(error: Error) {
        self.hideLoading()
        #warning("TODO: Create a alert to show some great message to the user")
        print(error.localizedDescription)
    }
}

// MARK: - Actions
extension DetailViewController {
    @objc
    func didCloseButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

