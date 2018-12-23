rmdir /s /q .\SegmentLibTestBuild
xcopy /s /i .\SegmentLib SegmentLibTestBuild
copy /Y /B test_manifest .\SegmentLibTestBuild\manifest
set /p roku_ip="Enter Roku box IP address: "
telnet %roku_ip% 8085
