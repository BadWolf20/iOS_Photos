//
//  PhotosModel.swift
//  iOS_Photos
//
//  Created by Roman on 03.11.2023.
//

import UIKit

/// `Section` представляет собой секцию альбомов в приложении.
///  Свойства:
///  - `type`: `SectionType`, перечисление, определяющее категорию секции, например, "Мои Альбомы" или "Медиатипы".
///  - `title`: `String`, текстовое описание секции, отображаемое как заголовок в пользовательском интерфейсе.
///  - `albums`: `[Album]`, массив альбомов, принадлежащих данной секции, каждый из которых содержит собственные фотографии и метаданные.
struct Section {
    let type: SectionType
    let title: String
    var albums: [Album]
}

/// `Album` представляет собой альбом с фотографиями.
/// Свойства:
/// - `id`: `UUID`, уникальный идентификатор альбома, используемый для отслеживания и управления альбомами.
/// - `title`: `String`, название альбома, отображаемое в пользовательском интерфейсе.
/// - `photos`: `[UIImage]`, массив фотографий, содержащихся в альбоме.
/// - `icon`: `UIImage?`, опциональная иконка, ассоциированная с типом медиа в альбоме.
struct Album {
    let id: UUID
    let title: String
    let photos: [UIImage]
    let icon: UIImage?
}

/// `SectionType` определяет категории секций для альбомов.
enum SectionType: Int {
    case myAlbums = 1, peoplePetsAndPlaces, mediaTypes, utilities
}

/// `MediaType` определяет типы медиафайлов, используемых в альбомах.
/// Позволяет ассоциировать иконки с типами медиа.
enum MediaType: String {
    case video = "video"
    case selfie = "person.crop.square.fill"
    case livePhotos = "livephoto"
    case portraits = "cube"
    case imports = "square.and.arrow.down"
    case hidden = "eye.slash"
    case recentlyDeleted = "trash"

    /// Получает изображение системы по имени ресурса.
    var image: UIImage? {
        return UIImage(systemName: self.rawValue)
    }
}
