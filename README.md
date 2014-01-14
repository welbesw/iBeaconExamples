iBeaconExamples
===============

These two projects are simple illustrations of how to incorporate iBeacon into an app.  You can find a more in depth discussion of the projects on the [iBeacon Primer](http://www.myuiviews.com/2014/01/09/ibeacon-primer.html) on [My UIViews](http://www.myuiviews.com).

##Beacon Broadcaster

This is a simple app to broadcast Bluetooth LE as an iBeacon from an iOS device.  Enter a major and minor value and turn it on.  The UUID that is used is the same as the UUID specified in the example BeaconMonitor app.

##Beacon Monitor

The Beacon Monitor app is an example of a simple integration of iBeacon.  This is the more likely scenario for iBeacon integration where an app is registering to monitor a region and be notified when entering or leaving the region.  If a beacon is discovered, the app ranges the beacon and updates the screen with an estimated range.
