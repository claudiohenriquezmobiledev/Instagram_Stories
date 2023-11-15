//
//  IGAdditionalData.swift
//  InstagramStories
//
//  Created by Claudio Henriquez Colima on 14-11-23.
//  Copyright © 2023 DrawRect. All rights reserved.
//

import Foundation

public class IGAdditionalData: Codable {
    public let titleEvent: String?
    public let typeComponent: String?
    public let actionType: String?
    public let flow: String?
    // Store the deleted snaps id in NSUserDefaults, so that when app get relaunch deleted snaps will not display.

    enum CodingKeys: String, CodingKey {
        case titleEvent = "title_event"
        case typeComponent = "type_component"
        case actionType = "action_type"
        case flow = "flow"
    }
}

