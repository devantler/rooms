import SwiftUI

struct RoomsData: Codable {

    var rooms: [Room]
    
    init() {
        rooms = []
        refresh()
    }
    
    mutating func refresh() {
        rooms = RoomsStore().getRooms()
    }
    
   
    
    mutating func handleBooking(roomNumber: Int, bookedBy: String, isCancelation: Bool) -> Bool {
        if(isCancelation) {
            return cancelBooking(roomNumber, bookedBy)
        }
        return bookRoom(roomNumber, bookedBy)
    }
    
    fileprivate mutating func cancelBooking(_ roomNumber: Int, _ bookedBy: String) -> Bool {
        guard(rooms[roomNumber].isBooked && rooms[roomNumber].bookedBy == bookedBy) else {
            return false;
        }
        rooms[roomNumber].isBooked = false
        rooms[roomNumber].bookedBy = ""
        return RoomsStore().update(roomsData: self)
    }
    
    fileprivate mutating func bookRoom(_ roomNumber: Int, _ bookedBy: String) -> Bool {
        guard(!rooms[roomNumber].isBooked) else {
            return false;
        }
        rooms[roomNumber].isBooked = true
        rooms[roomNumber].bookedBy = bookedBy
        return RoomsStore().update(roomsData: self)
    }
}
