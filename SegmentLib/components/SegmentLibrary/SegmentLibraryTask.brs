function segmentConfig()
  return  {
            endpoint: "https://api.segment.io/v1/batch",
            userAgentHeader: "analytics-roku/0.0.1",
            timeout: 60000
          }
end function


sub track()
  taskResponse = invalid
  if validateMessage(m.top.message)
    response = postWithTimeout(m.top.message)
    if response <> invalid then taskResponse = ParseJson(response)
  end if
  m.top.response = taskResponse
end sub


function validateMessage(value) as boolean
  return value <> invalid and type(value) = "roAssociativeArray" and value.items().count() > 0
end function


function postWithTimeout(body={})
  http = CreateURLTransferObject()
  if http.AsyncPostFromString(FormatJson(body))
    event = wait(segmentConfig().timeout, http.GetPort())
    if type(event) = "roUrlEvent"
      return event.GetString()
    else if event = invalid
      http.AsyncCancel()
    endif
  endif
  return invalid
End Function


Function CreateURLTransferObject()
  obj = CreateObject("roUrlTransfer")
  obj.SetPort(CreateObject("roMessagePort"))
  obj.SetUrl(segmentConfig().endpoint)
  ba = CreateObject("roByteArray")
  ba.FromAsciiString(m.writeKey + ":")
  obj.AddHeader("Authorization", "Basic " + ba.ToBase64String())
  obj.AddHeader("User-Agent", segmentConfig().userAgentHeader)
  obj.AddHeader("Content-Type", "application/json")
'  obj.EnableEncodings(true)
  if LCase(Left(obj.GetUrl(),8)) = "https://"
    obj.SetCertificatesFile("common:/certs/ca-bundle.crt")
    obj.AddHeader("X-Roku-Reserved-Dev-Id", "")
    obj.InitClientCertificates()
  end if
  return obj
End Function
