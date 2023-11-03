//
//  MainViewController.swift
//  iOS_Photos
//
//  Created by Roman on 03.11.2023.
//

import UIKit
import SnapKit

/**
 Класс `MainViewController` отвечает за отображение и управление коллекцией фотоальбомов в `UICollectionView`.
 Класс наследуется от `UIViewController` и реализует протоколы `UICollectionViewDataSource` и `UICollectionViewDelegate`.

 Особенности:
 - Поддержка разных типов секций с различными конфигурациями ячеек.
 - Динамическое создание макета коллекции с помощью `UICollectionViewCompositionalLayout`.
 - Возможность регистрации кастомных ячеек и заголовков.

 Компоненты:
 - `collectionView`: `UICollectionView` для отображения альбомов.
 - `sectionHeader`: `NSCollectionLayoutBoundarySupplementaryItem` для заголовков секций.

 Действия:
 - `headerButton()`: Отвечает на нажатие кнопки в навигационной панели.

 Константы:
 - `Colors`: Содержит цвета, используемые в `MainViewController`.
 - `Metric`: Определяет метрики для настройки интерфейса, например высоту заголовка.
*/
class MainViewController: UIViewController {
    // MARK: - Components
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: view.bounds, collectionViewLayout: createCompLayout())
        view.backgroundColor = Colors.ColectionViewBackGround
        view.register(cellType: FirstTypeCollectionViewCell.self)
        view.register(cellType: SecondTypeCollectionViewCell.self)
                view.register(HeaderReusableView.self,
                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                              withReuseIdentifier: HeaderReusableView.reuseId)

        view.delegate = self
        view.dataSource = self

        return view
    }()

    private lazy var sectionHeader: NSCollectionLayoutBoundarySupplementaryItem = {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(Metric.headerHeight))

        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        return header
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
        setupComponents()
        setupText()
    }

    private func setupHierarchy() {
        view.addSubview(collectionView)
    }

    private func setupComponents() {
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(headerButton))
        navigationItem.leftBarButtonItems = [add]
    }

    private func setupText() {
        navigationItem.title = NSLocalizedString("albumsViewTitle", comment: "")
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Metric.collectionViewTopIndent)
            make.bottom.left.right.equalToSuperview()
        }
    }

    // MARK: - Actions
    @objc func headerButton() {
        print("add button taped")
        collectionView.reloadData()
    }


    // MARK: - Functions
    private func createCompLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout{ (sectionindex, layoutEnviroment) -> NSCollectionLayoutSection? in

            switch sectionsList[sectionindex].type {
            case .myAlbums:
                return self.createPhotoSectionType1()
            case .peopleAndPlaces:
                return self.createPhotoSectionType2()
            case .mediaTypes, .utilities:
                return self.createPhotoSectionType3()
            }
        }
        return layout
    }
}

// MARK: - collectionViewLayout
extension MainViewController {
    private func createPhotoSectionType1() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(130 + 10),
                                              heightDimension: .fractionalHeight(130 + 10 + 35))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item, item])
        //group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    private func createPhotoSectionType2() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(130 + 10),
                                              heightDimension: .fractionalHeight(130 + 10 + 35))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        //group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    private func createPhotoSectionType3() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(view.frame.width),
                                              heightDimension: .fractionalHeight(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(1),
                                               heightDimension: .estimated(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        //group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsList.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionsList[section].albums.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch sectionsList[indexPath.section].type {
        case .myAlbums, .peopleAndPlaces:
            let cell = self.collectionView.dequeueReusableCell(for: indexPath, cellType: FirstTypeCollectionViewCell.self)

            cell.configure(with: sectionsList[indexPath.section].albums[indexPath.row])
            return cell
        case .mediaTypes, .utilities:
            let cell = self.collectionView.dequeueReusableCell(for: indexPath, cellType: SecondTypeCollectionViewCell.self)

            cell.configure(with: sectionsList[indexPath.section].albums[indexPath.row])
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath) cell pushed")
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderReusableView.reuseId,
            for: indexPath) as! HeaderReusableView
        header.setTittle(title: sectionsList[indexPath.section].title)
        return header
    }
}


// MARK: - Constants
/// Константы, используемые `MainViewController`.
extension MainViewController {
    /// Конфигурация цветов.
    enum Colors {
        static let ColectionViewBackGround: UIColor = .orange
    }
    
    /// Метрики.
    enum Metric {
        static let headerHeight: CGFloat = 30
        static let collectionViewTopIndent: CGFloat = 0
    }
}
