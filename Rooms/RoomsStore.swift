import Foundation
import SwiftUI

struct RoomsStore {
    
    @AppStorage("rooms", store: UserDefaults(
        suiteName: "group.com.niem94.rooms")) var store: Data = Data()
    
    var rooms: [Room] = []
    
    init() {
        rooms = getRooms()
    }
    
    func getRooms() -> [Room] {
        var rooms: [Room] = [Room(roomNumber: 0), Room(roomNumber: 1), Room(roomNumber: 2), Room(roomNumber: 3), Room(roomNumber: 4),  Room(roomNumber: 5),  Room(roomNumber: 6),  Room(roomNumber:7), Room(roomNumber: 8), Room(roomNumber: 9), Room(roomNumber: 10)]
        if let roomsData = try? JSONDecoder().decode(RoomsData.self, from: store) {
            rooms = roomsData.rooms
        }
        return rooms
    }
    
    func update(roomsData: RoomsData) -> Bool {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(roomsData) {
            store = data
        } else {
            return false
        }
        return true
    }
}
