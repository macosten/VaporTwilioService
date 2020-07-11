import Vapor

public struct OutgoingMMS: OutgoingMessage {
    let body: String?
    let from: String
    let to: String
    
    let mediaURL: URL
    
    public init(body: String? = nil, from: String, to: String, mediaURL: URL) {
        self.body = body
        self.from = from
        self.to = to
        
        self.mediaURL = mediaURL
    }
    
    private enum CodingKeys : String, CodingKey {
        case body = "Body", from = "From", to = "To", mediaURL = "MediaUrl"
    }
    
}
