import Vapor

public struct OutgoingMMS: OutgoingMessage {
    let body: String?
    let from: String
    let to: String
    
    /// Up to 10 Media URLs are supported.
    let mediaURL: [URL]
    
    public init(body: String? = nil, from: String, to: String, mediaURL: URL) {
        self.body = body
        self.from = from
        self.to = to
        
        self.mediaURL = [mediaURL]
    }
    
    public init(body: String? = nil, from: String, to: String, mediaURLs: [URL]) {
        self.body = body
        self.from = from
        self.to = to
        
        self.mediaURL = mediaURLs
    }

    private enum CodingKeys : String, CodingKey {
        case body = "Body", from = "From", to = "To", mediaURL = "MediaUrl"
    }
    
    
}
