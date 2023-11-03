//
//  PhotoData.swift
//  iOS_Photos
//
//  Created by Roman on 03.11.2023.
//

import UIKit


enum SectionType: Int {
    case myAlbums = 1, peopleAndPlaces, mediaTypes, utilities
}

enum MediaType: String {
    case video = "video"
    case selfie = "person.crop.square.fill"
    case livePhotos = "livephoto"
    case portraits = "cube"
    case imports = "square.and.arrow.down"
    case hidden = "eye.slash"
    case recentlyDeleted = "trash"

    var image: UIImage? {
        return UIImage(systemName: self.rawValue)
    }
}

struct Album {
    let id: UUID // Уникальный идентификатор
    let title: String
    let photos: [UIImage] // Используем массив неопциональных изображений
    let icon: UIImage? // Опциональная иконка
}

struct Section {
    let type: SectionType
    let title: String
    var albums: [Album]
}

func createAlbum(title: String, photoNames: [String], icon: MediaType? = nil) -> Album {
    let images = photoNames.compactMap { UIImage(named: $0) }
    let iconImage = icon?.image
    return Album(id: UUID(), title: title, photos: images, icon: iconImage)
}

let myAlbums = [
    createAlbum(title: "albumRecents", photoNames: ["photo-1"]),
    // Добавьте остальные альбомы
]

let peopleAndPlaces = [
    createAlbum(title: "albumRecents", photoNames: ["photo-1",
                                        "photo-1"])
]
let mediaTypes = [
    createAlbum(title: "albumRecents", photoNames: ["photo-1",
                                                    "photo-1"], icon: .livePhotos)
]
let utilities = [
    createAlbum(title: "albumRecents", photoNames: ["photo-1",
                                                    "photo-1"], icon: .portraits)
]


var sectionsList = [
    Section(type: .myAlbums, title: "sectionMyAlbums", albums: myAlbums),
    Section(type: .peopleAndPlaces, title: "peopleAndPlaces", albums: peopleAndPlaces),
    Section(type: .mediaTypes, title: "mediaTypes", albums: mediaTypes),

    Section(type: .utilities, title: "utilities", albums: utilities)
//    section(type: 1, title: NSLocalizedString("sectionMyAlbums", comment: ""), album: myAlbums),
//    section(type: 2, title: NSLocalizedString("sectionPeopleAndPlaces", comment: ""), album: peopleAndPlaces),
//    section(type: 3, title: NSLocalizedString("sectionMediafilesType", comment: ""), album: mediaTypes),
//    section(type: 4, title: NSLocalizedString("sectionUtilities", comment: ""), album: other)
]
