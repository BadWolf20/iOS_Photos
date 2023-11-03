//
//  FirstTypeCollectionViewCell.swift
//  iOS_Photos
//
//  Created by Roman on 03.11.2023.
//

import UIKit
import SnapKit

/**
 `FirstTypeCollectionViewCell` - это пользовательская ячейка для `UICollectionView`, предназначенная для отображения альбома с изображением, заголовком и количеством элементов.

 Основные компоненты:
 - `titleLabel`: `UILabel`, отображающий название альбома.
 - `quantityLabel`: `UILabel`, отображающий количество фотографий в альбоме.
 - `mainImage`: ` UIImageView`, показывающий первое изображение альбома.

 Методы:
 - `configure(with:)`: Конфигурирует ячейку, используя предоставленные данные об альбоме.

 Примечания:
 - `Reusable` протокол используется для упрощения переиспользования ячейки в `UICollectionView`.
*/
class FirstTypeCollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - Components
    /// `titleLabel` отображает название альбома.
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.titleLabelText
        label.font = Font.titleLabel
        label.textAlignment = .left

        return label
    }()

    /// `quantityLabel` отображает количество фотографий в альбоме.
    private lazy var quantityLable: UILabel = {
        let label = UILabel()
        label.textColor = Colors.quantityLabelText
        label.font = Font.quantityLabel
        label.textAlignment = .left

        return label
    }()

    /// `mainImage` отображает последнее изображение из альбома.
    private lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = Metric.mainImageCornerRadius
        image.contentMode = .scaleAspectFill

        return image
    }()


    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
        setupComponents()
    }

    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(mainImage)
        addSubview(quantityLable)
    }

    private func setupComponents() {
        backgroundColor = Colors.viewBackground
        self.clipsToBounds = true
    }

    private func setupConstraints() {
        mainImage.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(snp.width)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImage.snp.bottom)
            make.left.equalToSuperview().inset(Metric.nameLabelLeftIndent)
            make.right.equalToSuperview()
        }

        quantityLable.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalToSuperview().inset(Metric.quantityLabelLeftIndent)
            make.right.equalToSuperview()
        }
    }

    // MARK: - Functions
    /// Конфигурирация ячейки, используя данные об альбоме.
    func configure(with info: Album) {
        mainImage.image = info.photos[0]
        titleLabel.text = info.title
        quantityLable.text = String(info.photos.count)
    }
}

// MARK: - Constants
/// Константы, используемые `FirstTypeCollectionViewCell`.
extension FirstTypeCollectionViewCell {
    /// Конфигурация цветов.
    enum Colors {
        static let viewBackground: UIColor = .clear
        static let titleLabelText: UIColor = .black
        static let quantityLabelText: UIColor = .gray
    }

    /// Метрики.
    enum Metric {
        static let mainImageCornerRadius: CGFloat = 5
        static let nameLabelLeftIndent: CGFloat = 5
        static let quantityLabelLeftIndent: CGFloat = 5
    }
    
    /// Конфигурация шрифтов.
    enum Font {
        static let titleLabel: UIFont = .systemFont(ofSize: 16, weight: .regular)
        static let quantityLabel: UIFont = .systemFont(ofSize: 14, weight: .regular)
    }
}
