//
//  SecondTypeCollectionViewCell.swift
//  iOS_Photos
//
//  Created by Roman on 03.11.2023.
//

import UIKit

class SecondTypeCollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - Properties



    // MARK: - Components
    lazy var nameLable: UILabel = {
        let label = UILabel()

        label.textColor = Colors.nameLableTextColor
        label.font = .systemFont(ofSize: Metric.nameLableFontSize,
                                 weight: .regular)
        label.textAlignment = .left

        return label
    }()

    let quantityLable: UILabel = {
        let label = UILabel()

        label.textColor = Colors.quantityLableTextColor
        label.font = .systemFont(ofSize: Metric.quantityLableFontSize,
                                 weight: .regular)
        label.textAlignment = .right

        return label
    }()

    lazy var iconImage: UIImageView = {
        let image = UIImageView()

        image.contentMode = .scaleAspectFit

        return image
    }()

    lazy var arrowIconImage: UIImageView = {
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


        // MARK: - Lifecycle



        // MARK: - Setup
        private func setupUI() {

            setupHierarchy()
            setupConstraints()
            setupComponents()
            setupText()
        }

        private func setupHierarchy() {
            addSubview(nameLable)
            addSubview(iconImage)
            addSubview(quantityLable)
            addSubview(arrowIconImage)
        }

        private func setupComponents() {
            backgroundColor = Colors.viewBackGround
            arrowIconImage.image = UIImage(
                systemName: "chevron.right")?.withTintColor(Colors.arrowIconImageColor,
                                                            renderingMode: .alwaysOriginal)
            let selectedView = UIView(frame: bounds)
            selectedView.backgroundColor = Colors.selectedBackground
            self.selectedBackgroundView = selectedView



        }

        private func setupText() {

        }

        private func setupConstraints() {
            iconImage.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().inset(Metric.iconImageLeftIndent)
                make.height.equalTo(Metric.iconImageHeight)
                make.width.equalTo(Metric.iconImageWidth)
            }

            nameLable.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(iconImage.snp.right).offset(Metric.nameLableLeftIndent)
            }

            arrowIconImage.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(Metric.arrowIconImageRightIndent)
                make.height.equalTo(Metric.arrowIconImageHeight)
            }

            quantityLable.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(arrowIconImage.snp.left).offset(Metric.quantityLableRightIndent)
            }

        }

        // MARK: - Update



        // MARK: - Actions



        // MARK: - Functions
    func configure(with info: Album) {
        iconImage.image = info.icon
        nameLable.text = info.title
        quantityLable.text = String(info.photos.count)
    }
}

extension SecondTypeCollectionViewCell{
    enum Colors {
        // view
        static let viewBackGround: UIColor = .clear
        static let selectedBackground: UIColor = .gray
        // nameLable
        static let nameLableTextColor: UIColor = .black
        // quantityLable
        static let quantityLableTextColor: UIColor = .gray
        // arrowIconImage
        static let arrowIconImageColor: UIColor = .darkGray

    }

    enum Metric {
        // iconImage
        static let iconImageHeight: CGFloat = 30
        static let iconImageWidth: CGFloat = 30
        static let iconImageLeftIndent: CGFloat = 10
        // nameLable
        static let nameLableFontSize: CGFloat = 20
        static let nameLableLeftIndent: CGFloat = 15
        // quantityLable
        static let quantityLableFontSize: CGFloat = 20
        static let quantityLableRightIndent: CGFloat = -10
        // arrowIconImage
        static let arrowIconImageHeight: CGFloat = 18
        static let arrowIconImageWidth: CGFloat = 10
        static let arrowIconImageRightIndent: CGFloat = 15
    }
}
