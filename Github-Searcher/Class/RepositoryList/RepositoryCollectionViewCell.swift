//
//  RepositoryCollectionViewCell.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 15/01/2021.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class RepositoryCollectionViewCell: UICollectionViewCell {
    var viewModel: RepositoryCollectionViewCellViewModel! {
        didSet {
            bindings()
        }
    }

    let disposeBag = DisposeBag()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "Repository Name"
        return label
    }()

    var starsIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "star-icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var starsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = Theme.warmGrey
        label.text = "12"
        return label
    }()

    var authorPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true

        return imageView
    }()

    var anchorIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "forward-icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("not implemented")
    }
}

extension RepositoryCollectionViewCell {
    private func configure() {
        layer.cornerRadius = 13
        layer.backgroundColor = Theme.cellBackround.cgColor

        contentView.addSubview(anchorIcon)
        NSLayoutConstraint.activate([
            anchorIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            anchorIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 39),
            anchorIcon.widthAnchor.constraint(equalToConstant: 8),
            anchorIcon.heightAnchor.constraint(equalToConstant: 13),
        ])

        contentView.addSubview(authorPhoto)
        NSLayoutConstraint.activate([
            authorPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorPhoto.widthAnchor.constraint(equalToConstant: 60),
            authorPhoto.heightAnchor.constraint(equalToConstant: 60),
        ])

        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: authorPhoto.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            titleLabel.trailingAnchor.constraint(equalTo: anchorIcon.leadingAnchor, constant: -4)
        ])

        contentView.addSubview(starsIcon)
        NSLayoutConstraint.activate([
            starsIcon.widthAnchor.constraint(equalToConstant: 14),
            starsIcon.heightAnchor.constraint(equalToConstant: 14),
            starsIcon.leadingAnchor.constraint(equalTo: authorPhoto.trailingAnchor, constant: 16),
            starsIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
        ])

        contentView.addSubview(starsLabel)
        NSLayoutConstraint.activate([
            starsLabel.leadingAnchor.constraint(equalTo: starsIcon.trailingAnchor, constant: 4),
            starsLabel.centerYAnchor.constraint(equalTo: starsIcon.centerYAnchor),
        ])
    }

    private func bindings() {
        viewModel.name
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.stars
            .map { String($0) }
            .bind(to: starsLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.photoURL
            .map { UIImage(data: try! Data(contentsOf: URL(string: $0)!)) }
            .bind(to: authorPhoto.rx.image)
            .disposed(by: disposeBag)
    }
}
