sub main(args)
  'if channel is in dev mode and in deep linking parameters was specified RunTests parameter as true
  'then we run test cases, that is specified in folder pkg:/component/tests
  if createObject("roAPPInfo").IsDev() and args.RunTests = "true" and TF_Utils__IsFunction(TestRunner)
    PrintSampleLogo()
    
    'screen, scene and port initialization
    m.screen = CreateObject("roSGScreen")
    m.scene = m.screen.CreateScene("TestScene")
    m.port = CreateObject("roMessagePort")
    'getting acess to global node
    m.global = m.screen.getGlobalNode()

    'Set the roMessagePort to be used for all events from the screen.
    m.screen.SetMessagePort(m.port)

    'Show Scene Graph canvas that displays the contents
    'of a Scene Graph Scene node tree
    m.screen.Show()
    
    Runner = TestRunner()
    Runner.logger.SetVerbosity(2)
    Runner.RUN()

    'main channel loop
'    while true
'      msg = wait(0, m.port)
'      if type(msg) = "roSGScreenEvent" and msg.isScreenClosed() then exit while
'    end while
  end if
end sub


Sub PrintSampleLogo()
 ?" _   _       _ _     _____         _"
 ?"| | | |_ __ (_) |_  |_   _|__  ___| |_"
 ?"| | | | '_ \| | __|   | |/ _ \/ __| __|"
 ?"| |_| | | | | | |_    | |  __/\__ \ |_"
 ?" \___/|_|_|_|_|\__|___|_|\___||___/\__|"
End Sub