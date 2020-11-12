//
//  Contacts+CoreDataProperties.swift
//  Epikoinonia
//
//  Created by Hethsron Jedaël BOUEYA on 12/11/2020.
//
//

import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }

    @NSManaged public var lastname: String?
    @NSManaged public var firstname: String?
    @NSManaged public var address: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?

}

extension Contacts : Identifiable {

}
