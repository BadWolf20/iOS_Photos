//
//  HeaderReusableView.swift
//  iOS_Photos
//
//  Created by Roman on 03.11.2023.
//

import UIKit

class HeaderReusableView: UICollectionReusableView, Reusable {
    // MARK: - Properties
    static let reuseId = "HeaderReusableView"


    // MARK: - Components
    lazy var titleLable: UILabel = {
        let label = UILabel()

        label.textColor = Colors.titleLableTextColor
        label.font = .systemFont(ofSize: Metric.titleLableFontSize, weight: .heavy)
        label.textAlignment = .left

        return label
    }()

    let button: UIButton = {
        let button = UIButton(type: .custom)
        // Настройте внешний вид кнопки
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        // Добавьте действие для кнопки
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        return button
    }()



    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
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
        addSubview(titleLable)
        addSubview(button)
    }

    private func setupComponents() {
        backgroundColor = Colors.backGround

    }

    private func setupText() {

    }

    private func setupConstraints() {
        titleLable.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(Metric.titleLableLeftIndent)
        }

        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

    }

    // MARK: - Update
    func setTittle(title: String) {
        titleLable.text = title
    }


    // MARK: - Actions
    @objc private func buttonTapped() {
        print(titleLable.text ?? "error")
    }


    // MARK: - Functions
}

// MARK: - Constants

extension HeaderReusableView {
    enum Colors {
        // view
        static let backGround: UIColor = .clear
        // titleLable
        static let titleLableTextColor: UIColor = .white
        // line
        static let lineColor: UIColor = .gray
    }

    enum Metric {
        // titleLable
        static let titleLableFontSize: CGFloat = 19
        static let titleLableLeftIndent: CGFloat = 0
        // line
        static let lineStartEndY: CGFloat = 0
        static let lineStartX: CGFloat = 5
    }
}
