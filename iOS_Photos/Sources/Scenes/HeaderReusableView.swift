//
//  HeaderReusableView.swift
//  iOS_Photos
//
//  Created by Roman on 03.11.2023.
//

import UIKit

/**
 `HeaderReusableView` - это переиспользуемое заголовочное представление для `UICollectionView`, которое может отображать заголовок и кнопку.

 Основные компоненты:
 - `titleLabel`: UILabel, отображающий текст заголовка.
 - `button`: UIButton, который может быть настроен для выполнения действия при нажатии.

 Основные методы:
 - `setTittle(title:)`: Настраивает текст заголовка на `titleLabel`.
 - `buttonTapped`: Селектор, который вызывается при нажатии на кнопку.

 Примечания:
 - `reuseId` предоставляется для регистрации и переиспользования представления в `UICollectionView`.
 */
class HeaderReusableView: UICollectionReusableView, Reusable {
    // MARK: - Properties
    /// Идентификатор для переиспользования представления.
    static let reuseId = "HeaderReusableView"


    // MARK: - Components
    /// Лейбл для отображения заголовка секции.
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.textColor = Colors.titleLabelText
        label.font = Font.titleLabel
        label.textAlignment = .left

        return label
    }()

    /// Кнопка, которая может быть использована для выполнения действия, связанного с секцией.
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.black, for: .normal)

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

    // MARK: - Setup
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
        setupComponents()
        setupText()
    }

    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(button)
    }

    private func setupComponents() {
        backgroundColor = Colors.viewBackground
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    private func setupText() {
        button.setTitle("Button", for: .normal)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(Metric.titleLabelLeftIndent)
        }

        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(Metric.buttonrightIndent)
            make.height.equalTo(Metric.buttonHeight)
        }
    }

    // MARK: - Update
    /// Установка заголовока для `titleLable`.
    /// - Parameter title: Текст заголовка.
    func setTittle(title: String) {
        titleLabel.text = title
    }


    // MARK: - Actions
    /// Действие, выполняемое при нажатии на кнопку.
    @objc private func buttonTapped() {
        print(titleLabel.text ?? "Error")
    }

    // MARK: - Functions
    /// Рисование разделительной линии.
    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        aPath.move(to: CGPoint(x: Metric.separateLineStartX,
                               y: Metric.separateLineStartEndY))
        aPath.addLine(to: CGPoint(x: frame.width,
                                  y: Metric.separateLineStartEndY ))
        aPath.close()

        Colors.separateLineBackground.set()
        aPath.stroke()
        aPath.fill()
    }
}

// MARK: - Constants
/// Константы, используемые `HeaderReusableView`.
extension HeaderReusableView {
    /// Конфигурация цветов.
    enum Colors {
        static let viewBackground: UIColor = .clear
        static let titleLabelText: UIColor = .white
        static let separateLineBackground: UIColor = .gray
    }

    /// Метрики.
    enum Metric {
        static let titleLabelLeftIndent: CGFloat = 0
        static let buttonrightIndent: CGFloat = 20
        static let buttonHeight: CGFloat = 40
        static let separateLineStartEndY: CGFloat = 0
        static let separateLineStartX: CGFloat = 5
    }

    /// Конфигурация шрифтов.
    enum Font {
        static let titleLabel: UIFont = .systemFont(ofSize: 19, weight: .semibold)
    }
}
