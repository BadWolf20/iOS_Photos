//
//  SecondTypeCollectionViewCell.swift
//  iOS_Photos
//
//  Created by Roman on 03.11.2023.
//

import UIKit
import SnapKit

/**
 `SecondTypeCollectionViewCell` — это пользовательская ячейка `UICollectionViewCell`, разработанная для отображения иконки, заголовка и метки количества, что часто указывает на количество элементов в категории. Также включает в себя иконку-стрелку, показывающую, что по нажатию на ячейку можно увидеть более подробную информацию.

 Компоненты:
 - `titleLabel`: `UILabel` для отображения основного текста.
 - `quantityLabel`: `UILabel`, отображающий количество фотографий в альбоме.
 - `iconImage`: `UIImageView`, отображении  иконки.
 - `arrowIconImage`: `UIImageView`, указывающий на возможность выбора ячейки.

 Методы:
 - `configure(with:)`: Настраивает ячейку, используя предоставленную информацию об альбоме.

 Примечания:
 - `Reusable` протокол используется для упрощения переиспользования ячейки в `UICollectionView`.
 */
class SecondTypeCollectionViewCell: UICollectionViewCell, Reusable {
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
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.quantityLabelText
        label.font = Font.quantityLabel
        label.textAlignment = .right

        return label
    }()

    /// `iconImage` отображает иконку  альбома.
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit

        return image
    }()

    /// `arrowIconImage` отображает стрелку перехода .
    private lazy var arrowIconImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit

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
        addSubview(iconImage)
        addSubview(quantityLabel)
        addSubview(arrowIconImage)
    }

    private func setupComponents() {
        backgroundColor = Colors.viewBackground

        arrowIconImage.image = UIImage(
            systemName: "chevron.right")?.withTintColor(Colors.arrowIconImage,
                                                        renderingMode: .alwaysOriginal)
        let selectedView = UIView(frame: bounds)
        selectedView.backgroundColor = Colors.selectedBackground
        self.selectedBackgroundView = selectedView
    }

    private func setupConstraints() {
        iconImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(Metric.iconImageLeftIndent)
            make.height.equalTo(Metric.iconImageHeight)
            make.width.equalTo(Metric.iconImageWidth)
        }

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImage.snp.right).offset(Metric.titleLabelLeftIndent)
        }

        arrowIconImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(Metric.arrowIconImageRightIndent)
            make.height.equalTo(Metric.arrowIconImageHeight)
        }

        quantityLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(arrowIconImage.snp.left).offset(Metric.quantityLabelRightIndent)
        }
    }

    // MARK: - Functions
    /// Конфигурирация ячейки, используя данные об альбоме.
    func configure(with info: Album) {
        iconImage.image = info.icon
        titleLabel.text = info.title
        quantityLabel.text = String(info.photos.count)
    }
}

/// Константы, используемые `SecondTypeCollectionViewCell`.
extension SecondTypeCollectionViewCell {
    /// Конфигурация цветов.
    enum Colors {
        static let viewBackground: UIColor = .clear
        static let selectedBackground: UIColor = .gray
        static let titleLabelText: UIColor = .black
        static let quantityLabelText: UIColor = .gray
        static let arrowIconImage: UIColor = .darkGray
    }

    /// Метрики.
    enum Metric {
        static let iconImageHeight: CGFloat = 30
        static let iconImageWidth: CGFloat = 30
        static let iconImageLeftIndent: CGFloat = 10
        static let titleLabelLeftIndent: CGFloat = 15
        static let quantityLabelRightIndent: CGFloat = -10
        static let arrowIconImageHeight: CGFloat = 18
        static let arrowIconImageWidth: CGFloat = 10
        static let arrowIconImageRightIndent: CGFloat = 15
    }

    /// Конфигурация шрифтов.
    enum Font {
        static let titleLabel: UIFont = .systemFont(ofSize: 20, weight: .regular)
        static let quantityLabel: UIFont = .systemFont(ofSize: 20, weight: .regular)
    }
}
