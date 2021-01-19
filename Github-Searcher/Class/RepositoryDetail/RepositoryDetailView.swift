//
//  RepositoryDetailView.swift
//  Github-Searcher
//
//  Created by Jakub Kalamarz on 14/01/2021.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryDetailView: UIViewController {
    var viewModel: RepositoryDetailViewModel!
    let disposeBag = DisposeBag()

    let authorPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let repoAuthorName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .white
        label.text = "Repo Author Name"
        return label
    }()

    let repoByLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor.white.withAlphaComponent(0.6)
        label.text = "REPO BY"
        return label
    }()

    let starsIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "star-icon-filled"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let starsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.white.withAlphaComponent(0.5)
        label.text = "Number of Stars (123)"
        return label
    }()

    let repoTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.text = "Repo Title"
        return label
    }()

    let viewOnline: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17
        button.layer.backgroundColor = Theme.cellBackround.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        return button
    }()

    let shareRepo: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.backgroundColor = Theme.cellBackround.cgColor
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 5)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableFooterView = UIView()
        table.rowHeight = UITableView.automaticDimension
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTable()
        setupBindings()
    }
}

//MARK: - Setup Bindings
extension RepositoryDetailView: UITableViewDelegate {
    private func setupBindings() {

        viewModel.repository
            .map { $0.author.name }
            .bind(to: repoAuthorName.rx.text)
            .disposed(by: disposeBag)

        viewModel.repository
            .map { $0.author.photo }
            .map { UIImage(data: try! Data(contentsOf: URL(string: $0)!)) }
            .bind(to: authorPhoto.rx.image)
            .disposed(by: disposeBag)

        viewModel.repository
            .map { $0.stars }
            .map { "Number of Stars (\($0))" }
            .bind(to: starsLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.repository
            .map { $0.name }
            .bind(to: repoTitle.rx.text)
            .disposed(by: disposeBag)

        viewOnline.rx.tap
            .bind(to: viewModel.openWeb)
            .disposed(by: disposeBag)

        navigationItem.backBarButtonItem?.rx.tap
            .bind(to: viewModel.back)
            .disposed(by: disposeBag)

        shareRepo.rx.tap
            .subscribe(onNext: {
                self.viewModel.shareButton(self)
            })
            .disposed(by: disposeBag)
    }

    private func setupTable() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        tableView.register(RepositoryCommitsTableViewCell.self, forCellReuseIdentifier: "cell")

        viewModel.commits.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: RepositoryCommitsTableViewCell.self)) { (row, item, cell) in
            cell.viewModel = RepositoryCommitViewModel(from: item, position: row)
        }
        .disposed(by: disposeBag)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 28)
        let headerView = UIView(frame: frame)
        let labelFrame = CGRect(x: 16, y: 0, width: view.bounds.width - 16, height: 28)
        let sectionLabel = UILabel(frame: labelFrame)
        sectionLabel.font = .systemFont(ofSize: 22, weight: .bold)
        sectionLabel.text = "Commits History"
        sectionLabel.textColor = .black
        headerView.backgroundColor = .systemBackground
        headerView.addSubview(sectionLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
}

//MARK: - Setup UI
extension RepositoryDetailView {
    private func setupUI() {
        view.backgroundColor = .systemBackground

        configureNavigation()

        view.addSubview(authorPhoto)
        NSLayoutConstraint.activate([
            authorPhoto.topAnchor.constraint(equalTo: view.topAnchor),
            authorPhoto.widthAnchor.constraint(equalTo: view.widthAnchor),
            authorPhoto.heightAnchor.constraint(equalToConstant: 263),
        ])

        let starsStack = UIStackView(arrangedSubviews: [starsIcon, starsLabel])
        starsStack.translatesAutoresizingMaskIntoConstraints = false
        starsStack.axis = .horizontal
        starsStack.alignment = .leading

        let stackView = UIStackView(arrangedSubviews: [repoByLabel, repoAuthorName, starsStack])
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: authorPhoto.bottomAnchor, constant: -22),
            stackView.leadingAnchor.constraint(equalTo: authorPhoto.leadingAnchor, constant: 20),
            starsIcon.widthAnchor.constraint(equalToConstant: 13),
            starsIcon.heightAnchor.constraint(equalToConstant: 13),
            starsIcon.centerYAnchor.constraint(equalTo: starsLabel.centerYAnchor),
            starsStack.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])

        viewOnline.setTitleColor(.link, for: .normal)
        viewOnline.setTitle("VIEW ONLINE", for: .normal)

        let repoStack = UIStackView(arrangedSubviews: [repoTitle, viewOnline])
        repoStack.translatesAutoresizingMaskIntoConstraints = false
        repoStack.distribution = .equalCentering
        view.addSubview(repoStack)

        NSLayoutConstraint.activate([
            repoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            repoStack.topAnchor.constraint(equalTo: authorPhoto.bottomAnchor, constant: 17),
        ])

        shareRepo.setTitle("SHARE REPO", for: .normal)
        shareRepo.setImage(UIImage(named: "share-icon"), for: .normal)
        shareRepo.setTitleColor(.link, for: .normal)
        shareRepo.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)

        view.addSubview(shareRepo)

        NSLayoutConstraint.activate([
            shareRepo.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            shareRepo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            shareRepo.heightAnchor.constraint(equalToConstant: 50),
            shareRepo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: repoStack.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: shareRepo.topAnchor, constant: -10),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])



    }

    private func configureNavigation() {
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

    }
}
