import Foundation

public protocol TwimlGenerator {
    func generateTwiml() -> String
}

public protocol Verb: TwimlGenerator {  }

public struct Message: Verb {
    let body: String

    public init(body: String) {
        self.body = body
    }

    public func generateTwiml() -> String {
        return """
        <Body>
            \(body.xmlEscaped)
        </Body>
        """
    }
}

public struct MediaMessage: Verb {
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            return nil
        }
        self.url = url
    }
    
    public func generateTwiml() -> String {
        return """
        <Media>
            \(url.absoluteString.xmlEscaped)
        </Media>
        """
    }
    
}

public struct SMSResponse: TwimlGenerator {
    let verbs: [Verb]

    public init(_ verbs: Verb...) {
        self.verbs = verbs
    }
    
    public init(_ verbs: [Verb]) {
        self.verbs = verbs
    }

    public func generateTwiml() -> String {
        return """
        <?xml version="1.0" encoding="UTF-8" ?>
        <Response>
            <Message>
                \(verbs.map { $0.generateTwiml() }.joined(separator: "\n"))
            </Message>
        </Response>
        """
    }
}
