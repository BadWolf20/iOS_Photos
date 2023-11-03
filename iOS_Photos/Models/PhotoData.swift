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
    let id: UUID
    let title: String
    let photos: [UIImage]
    let icon: UIImage?
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
    createAlbum(title: NSLocalizedString("albumRecents", comment: ""), photoNames: ["photo-25"]),
    createAlbum(title: NSLocalizedString("albumFavorites", comment: ""), photoNames: ["photo-26", "photo-27"]),
    createAlbum(title: "Instagram", photoNames: ["photo-1", "photo-2"]),
    createAlbum(title: "Twitter", photoNames: ["photo-3", "photo-4"]),
    createAlbum(title: "Snapchat", photoNames: ["photo-28", "photo-29"])
]

let peopleAndPlaces: [Album] = [
    createAlbum(title: NSLocalizedString("albumPeople", comment: ""), photoNames: ["photo-5", "photo-6"]),
    createAlbum(title: NSLocalizedString("albumPlaces", comment: ""), photoNames: ["photo-7"]),
    createAlbum(title: NSLocalizedString("albumViews", comment: ""), photoNames: ["photo-8", "photo-9"]),
    createAlbum(title: NSLocalizedString("albumFriends", comment: ""), photoNames: ["photo-10", "photo-11"])
]

let mediaTypes: [Album] = [
    createAlbum(title: NSLocalizedString("albumVideo", comment: ""), photoNames: ["photo-12"], icon: .video),
    createAlbum(title: NSLocalizedString("albumSelfie", comment: ""), photoNames: ["photo-13", "photo-14", "photo-15"], icon: .selfie),
    createAlbum(title: NSLocalizedString("albumLivePhotos", comment: ""), photoNames: ["photo-16"], icon: .livePhotos),
    createAlbum(title: NSLocalizedString("albumPortraits", comment: ""), photoNames: ["photo-17", "photo-18"], icon: .portraits)
]

let utilities: [Album] = [
    createAlbum(title: NSLocalizedString("albumImports", comment: ""), photoNames: ["photo-19"], icon: .imports),
    createAlbum(title: NSLocalizedString("albumHidden", comment: ""), photoNames: ["photo-20", "photo-21"], icon: .hidden),
    createAlbum(title: NSLocalizedString("albumRecentlyDeleted", comment: ""), photoNames: ["photo-22", "photo-23"], icon: .recentlyDeleted)
]


var sectionsList = [
    Section(type: .myAlbums, title: "sectionMyAlbums", albums: myAlbums),
    Section(type: .peopleAndPlaces, title: "peopleAndPlaces", albums: peopleAndPlaces),
    Section(type: .mediaTypes, title: "mediaTypes", albums: mediaTypes),
    Section(type: .utilities, title: "utilities", albums: utilities)
]
