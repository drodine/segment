echo off

echo 1 - Create build for package
echo 2 - Unit test build
echo 3 - Build sample channel using package integration
echo 4 - Build sample channel using source code integration
echo 5 - Unit test results
set /p selection="Select action:"

set SEGMENT_LIB_DIR=SegmentLib
set PKG_SAMPLE_CHANNEL_DIR=SegmentLibraryPackageIntegrationSampleChannel
set SAMPLE_CHANNEL_DIR=SegmentLibrarySampleChannel

set BUILD_1_NAME=SegmentLibPkgBuild
set BUILD_2_NAME=SegmentLibTestBuild
set BUILD_3_NAME=SegmentLibSampleChannelBuild


if %selection% == 1 (

rmdir /s /q .\%BUILD_1_NAME%
mkdir .\%BUILD_1_NAME%
mkdir .\%BUILD_1_NAME%\components
mkdir .\%BUILD_1_NAME%\source
xcopy /s /i .\%SEGMENT_LIB_DIR%\components\SegmentLibrary %BUILD_1_NAME%\components\SegmentLibrary
copy /Y /B .\%SEGMENT_LIB_DIR%\source\main.brs .\%BUILD_1_NAME%\source\main.brs
copy /Y /B .\%SEGMENT_LIB_DIR%\manifest .\%BUILD_1_NAME%\manifest
powershell.exe -nologo -noprofile -command "Compress-Archive -Path .\%BUILD_1_NAME%\* -DestinationPath .\%BUILD_1_NAME%\%BUILD_1_NAME%.zip"

) else if %selection% == 2 (

rmdir /s /q .\%BUILD_2_NAME%
mkdir .\%BUILD_2_NAME%
xcopy /s /i .\%SEGMENT_LIB_DIR%\components %BUILD_2_NAME%\components
xcopy /s /i .\%SEGMENT_LIB_DIR%\source %BUILD_2_NAME%\source
copy /Y /B test_manifest .\%BUILD_2_NAME%\manifest
powershell.exe -nologo -noprofile -command "Compress-Archive -Path .\%BUILD_2_NAME%\* -DestinationPath .\%BUILD_2_NAME%\%BUILD_2_NAME%.zip"

) else if %selection% == 3 (

rmdir /s /q .\%BUILD_3_NAME%
mkdir .\%BUILD_3_NAME%
mkdir .\%BUILD_3_NAME%\components
mkdir .\%BUILD_3_NAME%\source
xcopy /s /i .\%PKG_SAMPLE_CHANNEL_DIR%\images %BUILD_3_NAME%\images
xcopy /s /i .\%SEGMENT_LIB_DIR%\components\SegmentLibrary %BUILD_3_NAME%\components\SegmentLibrary
copy /Y /B .\%PKG_SAMPLE_CHANNEL_DIR%\source\main.brs .\%BUILD_3_NAME%\source\main.brs
copy /Y /B .\sample_channel_manifest .\%BUILD_3_NAME%\manifest
powershell.exe -nologo -noprofile -command "Compress-Archive -Path .\%BUILD_3_NAME%\* -DestinationPath .\%BUILD_3_NAME%\%BUILD_3_NAME%.zip"

) else if %selection% == 4 (

rmdir /s /q .\%BUILD_3_NAME%
mkdir .\%BUILD_3_NAME%
mkdir .\%BUILD_3_NAME%\components
mkdir .\%BUILD_3_NAME%\source
xcopy /s /i .\%SAMPLE_CHANNEL_DIR%\images %BUILD_3_NAME%\images
xcopy /s /i .\%SEGMENT_LIB_DIR%\components\SegmentLibrary %BUILD_3_NAME%\components\SegmentLibrary
copy /Y /B .\%SAMPLE_CHANNEL_DIR%\source\main.brs .\%BUILD_3_NAME%\source\main.brs
copy /Y /B .\sample_channel_manifest .\%BUILD_3_NAME%\manifest
powershell.exe -nologo -noprofile -command "Compress-Archive -Path .\%BUILD_3_NAME%\* -DestinationPath .\%BUILD_3_NAME%\%BUILD_3_NAME%.zip"

) else if %selection% == 5 (

set /p roku_ip="Enter Roku box IP address: "
telnet %roku_ip% 8085

)
