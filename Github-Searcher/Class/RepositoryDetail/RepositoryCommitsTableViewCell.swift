//
//  RepositoryCommitsTableViewCell.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 17/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryCommitsTableViewCell: UITableViewCell {
    var viewModel: RepositoryCommitViewModel! {
        didSet {
            setupBindings()
        }
    }
    let disposeBag = DisposeBag()

    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.layer.cornerRadius = 16
        label.layer.backgroundColor = Theme.cellBackround.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "COMMIT AUTHOR NAME"
        label.font = .systemFont(ofSize: 11, weight: .semibold)
        label.textColor = .link
        return label
    }()

    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "email@authorname.com"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "This is a short commit message."
        label.textColor = Theme.warmGrey
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        ConfigureUI()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ConfigureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RepositoryCommitsTableViewCell {
    private func setupBindings() {
        viewModel.author
            .bind(to: authorLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.email
            .bind(to: emailLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.message
            .bind(to: messageLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

extension RepositoryCommitsTableViewCell {
    private func ConfigureUI() {
        isUserInteractionEnabled = false

        let stackView = UIStackView(arrangedSubviews: [authorLabel,emailLabel,messageLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 76),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])

        contentView.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.widthAnchor.constraint(equalToConstant: 32),
            numberLabel.heightAnchor.constraint(equalToConstant: 32),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26)
        ])
    }
}
