//
//  Room.swift
//  Rooms
//
//  Created by Nikolai Emil Damm on 04/12/2021.
//

import Foundation

struct Room: Codable, Identifiable {
    var id = UUID()
    var roomNumber: Int
    var isBooked = false
    var bookedBy = ""
}
