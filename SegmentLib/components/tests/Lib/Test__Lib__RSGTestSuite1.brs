Function TestSuite__Lib__RSGTestSuite1() as Object
    ' Inherite your test suite from BaseTestSuite
    this = BaseTestSuite()

    ' Test suite name for log statistics
    this.Name = "TestSuite__Lib__RSGTestSuite1"

    ' Add tests to suite's tests collection
    this.addTest("TestCase__Init", TestCase__Init)
    this.addTest("TestCase__Send_Message", TestCase__Send_Message)
    this.addTest("TestCase__GetMessageBody", TestCase__GetMessageBody)
    return this
End Function


Function getTestSuitesAA()
    return { "TestSuite__Lib__RSGTestSuite1": TestSuite__Lib__RSGTestSuite1 }
End Function


function TestCase__Init() as Object
  globalAA = getGlobalAA()

  return m.assertTrue(globalAA.global.Segment_analytics <> invalid)
end function


function TestCase__GetMessageBody() as Object
  globalAA = getGlobalAA()
  event = "Unit Test: getMessageBody"
  message = getMessageBody({"event": event})

  return m.assertAAHasKey(message, "userId") + m.assertTrue(message.event = event)
end function


function TestCase__Send_Message() as Object
  globalAA = getGlobalAA()
  m.segmentLibraryTask = CreateObject("roSGNode", "SegmentLibraryTask")
  m.initialResponseData = m.segmentLibraryTask.response
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
                "event": "Unit Test: SegmentLibTask"
              }
  m.segmentLibraryTask.message = {"batch": [message]}
  port = CreateObject("roMessagePort")
  m.segmentLibraryTask.observeField("response", port)
  m.segmentLibraryTask.control = "RUN"
  event = wait(90000, port)

  return m.AssertNotEqual(m.initialResponseData, m.segmentLibraryTask.response)
end function
