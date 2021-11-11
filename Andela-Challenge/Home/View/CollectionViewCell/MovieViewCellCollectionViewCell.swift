//
//  MovieViewCellCollectionViewCell.swift
//  Andela-Challenge
//
//  Created by Renato Mateus on 11/11/21.
//

import UIKit

class MovieViewCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieContentView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    static let identifier: String = "MovieViewCellCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension MovieViewCellCollectionViewCell {
    func setupUI() {
        movieContentView.layer.cornerRadius = 20
        movieImageView.layer.cornerRadius = 40
        
        movieContentView.clipsToBounds = true
        movieContentView.layer.masksToBounds = false
        movieContentView.layer.shadowColor = UIColor.gray.cgColor
        movieContentView.layer.shadowOffset = CGSize(width: -1, height: 1)
        movieContentView.layer.shadowOpacity = 0.7
        movieContentView.layer.shadowRadius = 4.0
    }
    
    func setupData(with movie: Movie) {
        let imagePlaceholder = UIImage(named: "placeholder")
        if let poster = movie.poster_path,
           let url = URL(string: "\(Constants.imageHost)\(poster)") {
            self.movieImageView.kf.setImage(with: url,
                                              placeholder: imagePlaceholder,
                                              options: nil,
                                              progressBlock: nil,
                                              completionHandler: nil)
        }
        self.movieTitleLabel.text = movie.title
    }
}
