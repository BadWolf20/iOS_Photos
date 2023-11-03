//
//  PhotoData.swift
//  iOS_Photos
//
//  Created by Roman on 03.11.2023.
//

import UIKit

/// `PhotoAlbumManager` управляет коллекцией фотоальбомов.
/// Этот класс использует паттерн синглтон, что позволяет иметь единственный экземпляр менеджера на весь проект.
class PhotoAlbumManager {
    // Синглтон для доступа к менеджеру
    static let shared = PhotoAlbumManager()

    /// Массив секций, содержащий все типы альбомов.
    lazy var sectionsList = [
        Section(type: .myAlbums, title: NSLocalizedString("sectionMyAlbums", comment: ""), albums: myAlbums),
        Section(type: .peoplePetsAndPlaces, title: NSLocalizedString("sectionPeoplePetsAndPlaces", comment: ""), albums: peoplePetsAndPlaces),
        Section(type: .mediaTypes, title: NSLocalizedString("sectionMediafilesType", comment: ""), albums: mediaTypes),
        Section(type: .utilities, title: NSLocalizedString("sectionUtilities", comment: ""), albums: utilities)
    ]

    /// Массив с альбомами пользователя.
    let myAlbums = [
        createAlbum(title: NSLocalizedString("albumRecents", comment: ""), photoNames: ["photo-25"]),
        createAlbum(title: NSLocalizedString("albumFavorites", comment: ""), photoNames: ["photo-26", "photo-27"]),
        createAlbum(title: "Instagram", photoNames: ["photo-1", "photo-2"]),
        createAlbum(title: "Twitter", photoNames: ["photo-3", "photo-4"]),
        createAlbum(title: "Snapchat", photoNames: ["photo-28", "photo-29"])
    ]

    /// Массив альбомов, связанных с людьми и местами.
    let peoplePetsAndPlaces: [Album] = [
        createAlbum(title: NSLocalizedString("albumPeople", comment: ""), photoNames: ["photo-5", "photo-6"]),
        createAlbum(title: NSLocalizedString("albumPlaces", comment: ""), photoNames: ["photo-7"]),
        createAlbum(title: NSLocalizedString("albumViews", comment: ""), photoNames: ["photo-8", "photo-9"]),
        createAlbum(title: NSLocalizedString("albumFriends", comment: ""), photoNames: ["photo-10", "photo-11"])
    ]

    /// Массив альбомов, организованных по типу медиа.
    let mediaTypes: [Album] = [
        createAlbum(title: NSLocalizedString("albumVideo", comment: ""), photoNames: ["photo-12"], icon: .video),
        createAlbum(title: NSLocalizedString("albumSelfie", comment: ""), photoNames: ["photo-13", "photo-14", "photo-15"], icon: .selfie),
        createAlbum(title: NSLocalizedString("albumLivePhotos", comment: ""), photoNames: ["photo-16"], icon: .livePhotos),
        createAlbum(title: NSLocalizedString("albumPortraits", comment: ""), photoNames: ["photo-17", "photo-18"], icon: .portraits)
    ]

    /// Массив альбомов с дополнительными утилитами, такими как скрытые и недавно удалённые фотографии.
    let utilities: [Album] = [
        createAlbum(title: NSLocalizedString("albumImports", comment: ""), photoNames: ["photo-19"], icon: .imports),
        createAlbum(title: NSLocalizedString("albumHidden", comment: ""), photoNames: ["photo-20", "photo-21"], icon: .hidden),
        createAlbum(title: NSLocalizedString("albumRecentlyDeleted", comment: ""), photoNames: ["photo-22", "photo-23"], icon: .recentlyDeleted)
    ]

    /// Создает и возвращает новый альбом с указанным названием, именами файлов фотографий и необязательной иконкой.
    /// - Parameters:
    ///   - title: Название альбома.
    ///   - photoNames: Массив имен файлов фотографий, которые будут загружены в альбом.
    ///   - icon: Необязательный параметр, задающий иконку для альбома.
    /// - Returns: Новый экземпляр `Album`;
    static func createAlbum(title: String, photoNames: [String], icon: MediaType? = nil) -> Album {
        let images = photoNames.compactMap { UIImage(named: $0) }
        let iconImage = icon?.image
        return Album(id: UUID(), title: title, photos: images, icon: iconImage)
    }
}

