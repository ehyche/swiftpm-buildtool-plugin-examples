//
//  SomeLibraryFile.swift
//  
//
//  Created by Eric Hyche on 5/4/22.
//

import Foundation
import UIKit

// Namespace
public enum SomeLibraryFile {

    public static func someString() -> String {
        return L10n.orientation + " " + L10n.orientationCompletedButtonTitle
    }

    public static func someImage() -> UIImage {
        return Media.clouds.image
    }
}
