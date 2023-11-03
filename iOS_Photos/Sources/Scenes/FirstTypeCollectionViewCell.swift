//
//  FirstTypeCollectionViewCell.swift
//  iOS_Photos
//
//  Created by Roman on 03.11.2023.
//

import UIKit
import SnapKit

class FirstTypeCollectionViewCell: UICollectionViewCell, Reusable {
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
        label.textAlignment = .left

        return label
    }()

    lazy var mainImage: UIImageView = {
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
            addSubview(mainImage)
            addSubview(quantityLable)
        }

        private func setupComponents() {
            backgroundColor = Colors.viewBackGround
            self.clipsToBounds = true

            mainImage.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(snp.width)
            }

            nameLable.snp.makeConstraints { make in
                make.top.equalTo(mainImage.snp.bottom)
                make.left.equalToSuperview().inset(Metric.nameLableLeftIndent)
                make.right.equalToSuperview()
            }

            quantityLable.snp.makeConstraints { make in
                make.top.equalTo(nameLable.snp.bottom)
                make.left.equalToSuperview().inset(Metric.quantityLableLeftIndent)
                make.right.equalToSuperview()
            }



        }

        private func setupText() {

        }

        private func setupConstraints() {

        }

        // MARK: - Update



        // MARK: - Actions



        // MARK: - Functions
    func configure(with info: Album) {
        mainImage.image = info.photos[0]
        nameLable.text = info.title
        quantityLable.text = String(info.photos.count)
    }
}

// MARK: - Constants
extension FirstTypeCollectionViewCell{
    enum Colors {
        // view
        static let viewBackGround: UIColor = .clear
        // nameLable
        static let nameLableTextColor: UIColor = .black
        // quantityLable
        static let quantityLableTextColor: UIColor = .gray
    }

    enum Metric {
        // mainImage
        static let mainImageCornerRadius: CGFloat = 5
        // nameLable
        static let nameLableFontSize: CGFloat = 16
        static let nameLableLeftIndent: CGFloat = 5
        // quantityLable
        static let quantityLableFontSize: CGFloat = 14
        static let quantityLableLeftIndent: CGFloat = 5
    }
}
