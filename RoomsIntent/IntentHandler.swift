import Intents
import SwiftUI

class IntentHandler: INExtension, BookRoomIntentHandling {
    
    @AppStorage("rooms", store: UserDefaults(
        suiteName: "group.com.niem94.rooms")) var store: Data = Data()
    
    var roomsData: RoomsData = RoomsData()
    
    public func confirm(intent: BookRoomIntent,
        completion: @escaping (BookRoomIntentResponse) -> Void) {
        
        completion(BookRoomIntentResponse(code: .ready, userActivity: nil))
    }
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is BookRoomIntent else {
            fatalError("Unknown intent type: \(intent)")
        }
        return self
    }
    
    func handle(intent: BookRoomIntent, completion: @escaping (BookRoomIntentResponse) -> Void){
        guard let roomNumber = intent.roomNumber, let bookedBy = intent.bookedBy, let isCancelationOfBooking = intent.isCancelationOfBooking else {
            completion(BookRoomIntentResponse(code: .failure, userActivity: nil))
            return
        }
        
        let result = makeBooking(roomNumber: roomNumber.intValue, bookedBy: bookedBy, isCancelationOfBooking: isCancelationOfBooking.boolValue)
        
        if result {
            if isCancelationOfBooking.boolValue == true {
                completion(BookRoomIntentResponse.successCancelledBooking(roomNumber: roomNumber, bookedBy: bookedBy))
            } else {
                completion(BookRoomIntentResponse.success(roomNumber: roomNumber, bookedBy: bookedBy))
            }
        } else {
            if isCancelationOfBooking.boolValue == true {
                completion(BookRoomIntentResponse.failureCancelledBooking(roomNumber: roomNumber, bookedBy: bookedBy))
            } else {
                completion(BookRoomIntentResponse.failure(roomNumber: roomNumber, bookedBy: bookedBy))
            }
            
        }
    }
    
    func makeBooking(roomNumber: Int, bookedBy: String, isCancelationOfBooking: Bool) -> Bool {
        return roomsData.handleBooking(roomNumber: roomNumber, bookedBy: bookedBy, isCancelation: isCancelationOfBooking)
    }
    
    func resolveRoomNumber(for intent: BookRoomIntent, with completion: @escaping (BookRoomRoomNumberResolutionResult) -> Void) {
        if let roomNumber = intent.roomNumber {
            guard roomNumber.intValue >= 0 else {
                completion(BookRoomRoomNumberResolutionResult.unsupported(forReason: .negativeNumbersNotSupported))
                return
            }
            guard roomNumber.intValue <= 10 else {
                completion(BookRoomRoomNumberResolutionResult.unsupported(forReason: .greaterThanMaximumValue))
                return
            }
            completion(BookRoomRoomNumberResolutionResult.success(with: roomNumber.intValue))
        } else {
            completion(BookRoomRoomNumberResolutionResult.needsValue())
        }
    }
    
    func resolveBookedBy(for intent: BookRoomIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let bookedBy = intent.bookedBy {
            completion(INStringResolutionResult.success(with: bookedBy))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    func resolveIsCancelationOfBooking(for intent: BookRoomIntent, with completion: @escaping (INBooleanResolutionResult) -> Void) {
        if let isCancelationOfBooking = intent.isCancelationOfBooking {
            completion(INBooleanResolutionResult.success(with: isCancelationOfBooking.boolValue))
        } else {
            completion(INBooleanResolutionResult.needsValue())
        }
    }
}
