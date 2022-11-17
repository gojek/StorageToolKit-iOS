# ``StorageCleaner``

StorageCleaner is an extensible declarative disk cleanup mechanism for app-generated data.

## Overview

StorageCleaner allows the app to create and schedule a periodic cleanup job to delete any
files created by the app during its execution (e.g. cache or temp files). You can extend the
default cleanup mechanism to precisely define conditions related to current storage info (e.g
hit cleanup if storage is less than 25%) to hit off a cleanup Job.

## Topics

### Essesntials

- <doc:GettingStarted>
- ``StorageCleanerConfiguration``
- ``StorageCleanerDefaultConfig``
- ``StorageCleanerWorker``
- ``CleanUpConstraint``
- ``StorageEnvelope``

### Defining clean up constraints

- ``ExactStorageSpaceAvailabilityConstraint``
- ``PercentageStorageSpaceAvailabilityConstraint``

### Declaring cleanup workflow using envelops

- ``StorageEnvelopes``
- ``ConstrainedEnvelopeProxy``
- ``LegacyStaleFilesEnvelope``
- ``DirectoryEnvelope``

### Getting current storage informations

- ``DiskSpaceProvider``

### Logging & Tracking cleanup results

- ``StorageCleanerResultReceiver``
- ``AnalyticsResultReceiver``
- ``DebugConsoleReciever``

### Types

- ``RemovableItems``
- ``RemovableFiles``
- ``EmptyRemovableItems``
- ``LeastRecentlyModifiedComparator``
- ``PerformanceTracker``
