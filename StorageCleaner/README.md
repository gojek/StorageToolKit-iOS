# StorageCleaner

StorageCleaner is an extensible declarative disk cleanup mechanism for app-generated data.

## Overview

StorageCleaner allows the app to create and schedule a periodic cleanup job to delete any files created by the app during its execution (e.g. cache or temp files). You can extend the default cleanup mechanism to precisely define conditions related to current storage info (e.g hit cleanup if storage is less than 25%) to hit off a cleanup Job.

> StorageCleaner uses WorkManager to schedule the cleanup job periodically

## Usage

StorageCleaner comes with a default worker, which deletes the image cache periodically.

To use the worker add the following code before the end of the application launch sequence, preferably during the app launch sequence, suggested place would be before returning from `application(_:, didFinishLaunchingWithOptions:) -> Bool` 

Create an instance of `StorageCleanerWorker` passing config of protocol type `StorageConfiguration` and an optional protocol type `PerformanceTracker` object, then call `scheduleCleanup()` function on it.

```swift
StorageCleanerWorker(
  	config: StorageCleanerConfiguration.default(),
  	performanceTracker: nil
).scheduleCleanup()
```

You can customise the config object by creating a new instance of `StorageCleanerConfiguration` rather than using the default one, to know more about the configs available refer to `StorageCleanerConfiguration` class.
