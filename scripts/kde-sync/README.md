# kde-sync

>Use kde-sync to quickly and easily setup copying folders from a remote device over kde connect to a local directory

## Kde Sync
This script is useful for easily setting up a system to copy files from your android phone/tablet to your computer over WiFi without the need for cables or manually exploring and copying files over.

The device need's to be paired and reachable for this script to run.

You will need to know what folder's on the target device to copy over so it does require you initially browse your device to find the necessary folders. This script allows you to query where the device is located when provided with 'query' so you can cd into it and browse manually

This script only works with a device's builtin storage for now until I have a device that I can test with external SD cards

## Requirements
* [kde-connect](https://github.com/KDE/kdeconnect-kde)
* Qt5-tools

## Usage

To initiate transfers:
```
./kde-connect.sh <DeviceName> <TargetDeviceDirectory> <LocalDirectory> <OperationType>
```
Where:
* `<DeviceName>` : case sensitive name of device
* `<TargetDeviceDirectory>` : Path to directory on device
* `<LocalDirectory>` : Path to local directory
* `<OperationType>` : either 'move' or 'copy'


To query the device directory:
```
./kde-connect.sh <DeviceName> query
```
Note: Due to android folder permissions you most likely won't be able to autocomplete certain directories in this path so you'll need to manually type out or copy the full path

## Examples

```
./kde-connect.sh GalaxyPhone query
./kde-connect.sh GalaxyPhone DCIM/Pictures ~/Pictures copy
./kde-connect.sh GalaxyTablet Downloads ~/Downloads move

```
These commands can then just be aliased or setup with a cron job to run daily/weekly etc.

#### Warning: there might be certain folders that shouldn't be deleted from this directory so be careful when using the 'move' operation
