Sub Init()
  if CreateObject("roDeviceInfo").IsRIDADisabled()
    m.userId = CreateObject("roDeviceInfo").GetRandomUUID()
  else
    m.userId = CreateObject("roDeviceInfo").GetChannelClientId()
  end if
  m.defaultMessage =  { "userId": m.userId,
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
                        "messageId": generateMessageId(),
                        "type": "track",
                        "event": "Application Start"
                      }
  m.batch = [m.defaultMessage]
  ?"SegmentLibrary Init"
  m.global.addField("Segment_analytics","node",false)
  m.global.Segment_analytics = m.top
End Sub


function generateMessageId()
  sessionTime = createObject("roDateTime")
  return sessionTime.asSeconds().tostr() + sessionTime.getMilliseconds().tostr()
end Function


sub onMessageChange()
  if m.top.message <> invalid
    message = m.defaultMessage
    message.messageId = generateMessageId()
    message.append(m.top.message)
    m.batch.push(message)
    runTask({"batch": m.batch}, "onMessageResponse")
    m.batch = []
  end if
end sub


sub onMessageResponse(event)
  ?event.getData()
end sub


Function runTask(message, observerName)
  if m.segmentLibraryTask = invalid
    m.segmentLibraryTask = CreateObject("roSGNode", "SegmentLibraryTask")
    m.segmentLibraryTask.observeField("response", observerName)
  end if
  m.segmentLibraryTask.id = "SegmentLibraryTask"
  m.segmentLibraryTask.message = message
  m.segmentLibraryTask.control = "RUN"
  return m.segmentLibraryTask
end Function
