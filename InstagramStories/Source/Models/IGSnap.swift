//
//  IGSnap.swift
//
//  Created by Ranjith Kumar on 9/28/17
//  Copyright (c) DrawRect. All rights reserved.
//

import Foundation

public enum MimeType: String {
    case image
    case video
    case unknown
}
public class IGSnap: Codable {
    public let internalIdentifier: String
    public let mimeType: String
    public let lastUpdated: String
    public let url: String
    public let subtitleDescription: String
    public var additionalData: IGAdditionalData?
    // Store the deleted snaps id in NSUserDefaults, so that when app get relaunch deleted snaps will not display.
    init(internalIdentifier: String,
         mimeType: String,
         lastUpdated: String,
         url: String, subtitleDescription: String,
         additionalData: IGAdditionalData?) {
        self.internalIdentifier = internalIdentifier
        self.mimeType = mimeType
        self.lastUpdated = lastUpdated
        self.url = url
        self.subtitleDescription = subtitleDescription
        self.additionalData = additionalData
    }
    
    public var isDeleted: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: internalIdentifier)
        }
        get{
            return UserDefaults.standard.value(forKey: internalIdentifier) != nil
        }
    }
    public var kind: MimeType {
        switch mimeType {
            case MimeType.image.rawValue:
                return MimeType.image
            case MimeType.video.rawValue:
                return MimeType.video
            default:
                return MimeType.unknown
        }
    }
    enum CodingKeys: String, CodingKey {
        case internalIdentifier = "id"
        case mimeType = "mime_type"
        case lastUpdated = "last_updated"
        case url = "url"
        case subtitleDescription = "subtitle_description"
        case additionalData = "additional_data"
    }
}
