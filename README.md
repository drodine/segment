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
There are two way to integrate Segment Library

### 1. Integration using the latest package
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

### 2. Source code integration
Steps to integrate Segment Library:
* Put write API key into application `manifest` file:
```
segment_library_write_key={Write API Key}
```

* Copy `SegmentLib/components/SegmentLibrary` folder into `/components` of your Roku channel source code

* Create library node in your application. Append scene `init()` function with the following line:
```
    m.segmentLib = CreateObject("roSGNode", "SegmentLibrary")
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
m.global.Segment_analytics.track = {"event": "Segment Component Library had been successfully loaded"}
```

## Library Tests Execution
To run tests:

#### MacOS/UNIX/Linux
* Run `make test ROKU_DEV_TARGET={Roku_box_IP_address} ROKU_DEV_PASSWORD={Roku_box_dev_password}`
* Observe test results in terminal window and in `TestResults/SegmentLib.log` file

#### Windows
* Execute `run_unit_test_framework.bat` for Windows
* Enter Roku box IP address on prompt. Example:
```
Enter Roku box IP address: 192.168.0.100
```
* Zip and sideload library application from `SegmentLibTestBuild` folder. See [Loading and Running Your Application](https://sdkdocs.roku.com/display/sdkdoc/Loading+and+Running+Your+Application) for more information.
* POST the following command to the device via ECP:
http://{Roku_box_IP_address}:8060/launch/dev?RunTests=true
* View the test results in opened telnet console.

