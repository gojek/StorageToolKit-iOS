# GettingStarted

## Deleting image cache periodically

StorageCleaner comes with a default worker, which deletes the image cache periodically.

To use the worker add the following code before the end of the application launch sequence, preferably during the app launch sequence, suggested place would be before returning from `application(_:, didFinishLaunchingWithOptions:) -> Bool` 

Create an instance of `StorageCleanerWorker` passing config of protocol type `StorageConfiguration` and an optional protocol type `PerformanceTracker` object, then call `scheduleCleanup()` function on it.

```swift
StorageCleanerWorker(
      config: StorageCleanerConfiguration.default(),
      performanceTracker: nil
).scheduleCleanup()
```

You can customise the config object by creating an new instance of `StorageCleanerConfiguration` rather than using the default one, to know more about the configs availble refer to `StorageCleanerConfiguration` class.

### Types

- ``StorageCleaner``
- ``StorageCleanerWorker``
- ``StorageCleanerConfig``
- ``StorageCleanerConfiguration``
- ``PerformanceTracker``

### Functions

- ``StorageCleanerWorker/scheduleCleanup()``
