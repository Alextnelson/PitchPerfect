//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Alexander Nelson on 2/22/16.
//  Copyright © 2016 Jetwolfe Labs. All rights reserved.
//

import Foundation

class RecordedAudio {
    var filePathURL: NSURL!
    var title: String!

    init(filePathURL: NSURL, title: String) {
        self.filePathURL = filePathURL
        self.title = title
    }


}