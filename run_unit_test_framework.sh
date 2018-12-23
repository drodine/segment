#!/bin/bash
rm -rf ./SegmentLibTestBuild
cp -r ./SegmentLib ./SegmentLibTestBuild
cat test_manifest > ./SegmentLibTestBuild/manifest
echo "Enter Roku box IP address: "
read roku_ip
telnet $roku_ip 8085
