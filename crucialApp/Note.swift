//
//  Note.swift
//  crucialApp
//
//  Created by Mohan K on 17/03/23.
//

import Foundation

import Foundation
import CoreData

@objc(Note)
public class Note : NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var date: Date!
    @NSManaged public var id: String!
    @NSManaged public var text: String!
    @NSManaged public var title: String!

}

extension Note : Identifiable {

}
