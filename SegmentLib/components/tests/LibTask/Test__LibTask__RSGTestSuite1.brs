Function TestSuite__LibTask__RSGTestSuite1() as Object
    ' Inherite your test suite from BaseTestSuite
    this = BaseTestSuite()
    
    ' Test suite name for log statistics
    this.Name = "TestSuite__LibTask__RSGTestSuite1"
    
    ' Add tests to suite's tests collection
    this.addTest("TestCase__Send_Message", TestCase__Send_Message)
    
    return this
End Function


Function getTestSuitesAA()
    return { "TestSuite__LibTask__RSGTestSuite1": TestSuite__LibTask__RSGTestSuite1 }
End Function


function TestCase__Send_Message() as Object
  globalAA = getGlobalAA()
  initialResponseData = globalAA.top.response
  message =  {  "userId": "TestUserId",
                "integrations": {},
                "properties": {
                    "from_background": false,
                    "url": "url://location",
                    "referring_application": "GMail"
                },
                "anonymousId": invalid,
                "context": {
                    "library": {
                        "version": "0.0.1b0",
                        "name": "analytics-roku"
                    }
                },
                "messageId": "testmessageid",
                "type": "track",
                "event": "Application Start"
              }
  globalAA.top.message = {"batch": [message]}
  
  return m.AssertNotEqual(initialResponseData, globalAA.top.response)
end function
