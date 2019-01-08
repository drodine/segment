# Segment Library
A library for reporting analytics information to segment.io

## Scope
Segment Library allows easily send messages to segment.io

## Overwview
Repository content:
* `SegmentLib` - library folder
* `SegmentLibraryPackageIntegrationSampleChannel` - sample RSG application to show the proper library integration way using `ComponentLibrary`
* `SegmentLibrarySampleChannel` - sample RSG application to show the proper library integration way

## Library Integration
Steps to integrate Segment Library:
* Put write API key into application `manifest` file:
```
segment_library_write_key={Write API Key}
```

* Insert the following line into your scene `<children>` section:
```
<ComponentLibrary id="SegmentComponentLibrary" uri="https://github.com/drodine/segment/raw/master/SegmentLib/out/SegmentLib-latest.pkg" />
```

* Observe library loading status. Append scene `init()` function with the following lines:
```
    m.lib = m.top.FindNode("SegmentComponentLibrary")
    m.lib.observeField("loadStatus", "onLoadStatusChanged")
```

* Initialize library on load. Create `onLoadStatusChanged` function:
```
  sub onLoadStatusChanged()
    if m.lib.loadStatus = "ready"
      m.segmentLib = CreateObject("roSGNode", "SegmentComponentLib:SegmentLibrary")
    endif
  end sub
```

## Library usage
Library creates link to itself in Global node during initialization. You can access library using `m.global.Segment_analytics`

### Sending the message
Assign associative array with message content to `message` library field:
```
m.global.Segment_analytics.message = {"event": "Segment Component Library had been successfully loaded"}
```

## Library Tests Execution
To run tests:
* Execute `run_unit_test_framework.bat` for Windows or `run_unit_test_framework.sh` for Linux/MacOS
* Enter Roku box IP address on prompt. Example:
```
Enter Roku box IP address: 192.168.0.100
```
* Zip and sideload library application from `SegmentLibTestBuild` folder. See [Loading and Running Your Application](https://sdkdocs.roku.com/display/sdkdoc/Loading+and+Running+Your+Application) for more information.
* POST the following command to the device via ECP:
http://{Roku_box_IP_address}:8060/launch/dev?RunTests=true
* View the test results in opened telnet console.

