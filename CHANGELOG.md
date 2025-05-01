# Changelog

This change log is to help track when new version of the nuget package are published. If the commit updates the package version the change log should be updated. Optionally update the [Unreleased](#unreleased) section of the change log when you PR to make this easier to do!

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## [Unreleased]

- Replace with coming additions, changes, removals, or fixes

## [0.0.1] - 2025-04-30

### Added

- `InputIconTextureRect` a control node that dynamically changes textures based on the user registered action, the display device, and device index
- `InputIconResolver` a godot object for resolving input icons using a `InputIconMap` (resource)
- Input Helper Adapter / Integration a godot class to add support to `InputIconTextureRect` for updating texture when inputs change at runtime or different devices are used at runtime
