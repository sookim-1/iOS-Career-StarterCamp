@testable import App
import XCTVapor
import Fluent

final class AppTests: XCTestCase {

    // MARK: - Set Up
    var app: Application?

    override func setUpWithError() throws {
        app = Application(.testing)
    }

    // MARK: - GET Test
    
    func test_get_todo() throws {
        guard let app = app else { return }
        defer { app.shutdown() }
        try configure(app)
        
        try app.test(.GET, "memo/todo?per=1") { response in
            XCTAssertEqual(response.status, .ok)
            let memos = try response.content.decode(Page<Memo>.self)
            let memo = memos.items[0]
            XCTAssertEqual(memo.title, "131")
        }
    }
    
    func test_get_doing() throws {
        guard let app = app else { return }
        defer { app.shutdown() }
        try configure(app)
        
        try app.test(.GET, "memo/doing?per=1") { response in
            XCTAssertEqual(response.status, .ok)
            let memos = try response.content.decode(Page<Memo>.self)
            let memo = memos.items[0]
            XCTAssertEqual(memo.title, "제목")
        }
    }
    
    func test_get_done() throws {
        guard let app = app else { return }
        defer { app.shutdown() }
        try configure(app)
        
        try app.test(.GET, "memo/done?per=1") { response in
            XCTAssertEqual(response.status, .ok)
            let memos = try response.content.decode(Page<Memo>.self)
            let memo = memos.items[0]
            XCTAssertEqual(memo.title, "String, example: 제목")
        }
    }
    
    // MARK: - POST Test
    
    func test_post() throws {
        guard let app = app else { return }
        defer { app.shutdown() }
        try configure(app)
        
        let memo = Memo(title: "Test용 Post",
                        content: "Test Content",
                        due_date: Date(),
                        memo_type: .todo)
        
        try app.test(.POST, "memo",
                     beforeRequest: { request in
                        request.headers.contentType = .json
                        try request.content.encode(memo)
                        
                     }, afterResponse: { response in
                        
                        let memo = try response.content.decode(Memo.self)
                        XCTAssertEqual(memo.title, "Test용 Post")
                     })
    }
    
    // MARK: - PATCH Test

    func test_patch() throws {
        guard let app = app else { return }
        defer { app.shutdown() }
        try configure(app)
        
        let memo = PatchMemo(title: "patch memo", content: "nothing")
        
        try app.test(.PATCH, "memo?memo-id=24402057-C4B1-44FF-AE7D-3E22C329C295", beforeRequest: { request in
            request.headers.contentType = .json
            
            try request.content.encode(memo)
            
        }, afterResponse: { response in
            XCTAssertEqual(response.status, .ok)
        })
    }
    
    // MARK: - DELETE Test
    
    func test_delete() throws {
        guard let app = app else { return }
        defer { app.shutdown() }
        try configure(app)
        
        try app.test(.DELETE, "memo?memo-id=24402057-C4B1-44FF-AE7D-3E22C329C295") { response in
            XCTAssertEqual(response.status, .ok)
        }
    }
}

// MARK: - PatchMemo Extension

extension PatchMemo: Content {
    
    enum CodingKeys: CodingKey {
        case title,content, due_date, memo_type
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        try container.encode(due_date, forKey: .due_date)
        try container.encode(memo_type, forKey: .memo_type)
    }
}
