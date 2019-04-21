#!/bin/bash

deviceName=$1
targetDeviceDir=$2
localDir=$3
operationType=$4

# Get ID of device, needs to be paired and reachable
deviceId=$(kdeconnect-cli -l | grep -E "${deviceName}.*paired.*reachable" | awk '{print $3}')

# Ensure we successfully got the device ID
if [ $deviceId != "" ]; then
  echo "Got id $deviceId for $deviceName"
else
  echo "Could not get device Id, aborting..."
  exit 0
fi

# Get the mount status of device
isMounted=$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/$deviceId/sftp org.kde.kdeconnect.device.sftp.isMounted)

# Check whether device is mounted and attempt to mount if it isn't
if [ $isMounted == "true" ]; then
  echo "Device Mounted!"
else
  echo "Device not mounted, attempting to mount"
  qdbus org.kde.kdeconnect /modules/kdeconnect/devices/f3ffd22f7e03bb92/sftp org.kde.kdeconnect.device.sftp.mount
  sleep 1
  isMounted=$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/f3ffd22f7e03bb92/sftp org.kde.kdeconnect.device.sftp.isMounted)
  if [ $isMounted == "false" ]; then
    echo "Unable to mount device, aborting..."
    exit 0
  else
    echo "Mounted Successfully"
  fi
fi

tempDir=$(qdbus org.kde.kdeconnect /modules/kdeconnect/devices/f3ffd22f7e03bb92/sftp org.kde.kdeconnect.device.sftp.getDirectories | grep "All" | awk '{print $1}')
deviceRootDir="${tempDir%?}"

# Check whether the device is being queried or continue to operations
if [ "$2" == "query" ]; then
  echo "Device root directory is at $deviceRootDir"
else
  case $operationType in
  *"move")
    echo "Moving files from $targetDeviceDir to $localDir/"
    mv -v $deviceRootDir/$targetDeviceDir/* $localDir/
    ;;
  *"copy")
    echo "Copying files from $targetDeviceDir to $localDir/"
    cp -v -R $deviceRootDir/$targetDeviceDir/ $localDir/
    ;;
  *)
    echo "Please specify operation, either 'move' or 'copy', aborting... "
    exit 0
  esac

  echo "Transfer Complete! Files will be found in $localDir"
fi
