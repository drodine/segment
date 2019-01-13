Function TestSuite__Lib__RSGTestSuite1() as Object
    ' Inherite your test suite from BaseTestSuite
    this = BaseTestSuite()
    
    ' Test suite name for log statistics
    this.Name = "TestSuite__Lib__RSGTestSuite1"
    
    ' Add tests to suite's tests collection
    this.addTest("TestCase__Init", TestCase__Init)
    
    return this
End Function


Function getTestSuitesAA()
    return { "TestSuite__Lib__RSGTestSuite1": TestSuite__Lib__RSGTestSuite1 }
End Function


function TestCase__Init() as Object
  globalAA = getGlobalAA()
  
  return m.assertTrue(globalAA.global.Segment_analytics <> invalid)
end function
