# Changelog
This file only reflects the changes that are made in this project.
Please refer to the upstream [keepalived changelog](https://github.com/acassen/keepalived/blob/master/ChangeLog) for the list of changes in keepalived.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project follows keepalived versioning.

## [2.0.16] - 2019-05-29
### Added 
  - Add NET_BROADCAST and NET_RAW capabilities on readme. Fixes #14

### Changed
  - Upgrade keepalived version to 2.0.16


## [2.0.15] - 2019-04-05
### Changed
  - Upgrade keepalived version to 2.0.15

## [2.0.13] - 2019-02-27
### Changed
  - Upgrade keepalived version to 2.0.13

## [2.0.12] - 2019-01-30
### Changed
  - Upgrade keepalived version to 2.0.12

## [2.0.11] - 2019-01-21
### Added
  - KEEPALIVED_STATE environment variable

### Changed
  - Upgrade keepalived version to 2.0.11

## [2.0.10] - 2018-11-13
### Changed
  - Upgrade keepalived version to 2.0.10

### Removed 
  - track_interface in keepalived.conf

## [1.4.5] - 2018-06-02
### Changed
  - Upgrade keepalived version to 1.4.5

## [1.4.4] - 2018-05-14
### Added
  - Router ID with environment KEEPALIVED_ROUTER_ID #16

### Changed
  - Upgrade keepalived version to 1.4.4

## [1.4.2] - 2018-03-03
### Changed
  - Upgrade keepalived version to 1.4.2

## [1.4.1] - 2018-01-29
### Changed
  - Upgrade keepalived version to 1.4.1

## [1.4.0] - 2018-01-11
### Changed
  - Upgrade keepalived version to 1.4.0

## [1.3.9] - 2017-10-22
### Changed
  - Upgrade keepalived version to 1.3.9

## [1.3.8] - 2017-10-16
### Changed
  - Upgrade keepalived version to 1.3.8

## [1.3.6-1] - 2017-10-16
### Changed
  - Upgrade baseimage to alpine-light-baseimage:0.1.5

## [1.3.6] - 2017-08-15
### Changed
  - Upgrade keepalived version to 1.3.6

### Removed
  - keepalived_script script user, scripts are now run with root user

## [1.3.5-1] - 2017-07-19
### Added
  - Add keepalived_script script user

### Changed
  - Use linux alpine as baseimage

### Fixed
  - startup.sh and finish.sh ip address removal

## [1.3.5] - 2017-03-21
### Changed
  - Upgrade keepalived version to 1.3.5

## [1.3.4] - 2017-02-19
### Changed
  - Upgrade keepalived version to 1.3.4

## [1.3.3] - 2017-02-15
### Changed
  - Upgrade keepalived version to 1.3.3

## [1.3.2] - 2016-11-29
### Changed
  - Upgrade keepalived version to 1.3.2

## [1.3.1] - 2016-11-22
### Changed
  - Upgrade keepalived version to 1.3.1

## [1.3.0] - 2016-11-21
### Changed
  - Upgrade keepalived version to 1.3.0
  - Upgrade baseimage to light-baseimage:0.2.6

## [1.2.24] - 2016-09-13
### Changed
  - Upgrade keepalived version to 1.2.24

## Versions before following the keepalived versioning

## [0.2.3] - 2016-09-03
### Changed
  - Upgrade baseimage to light-baseimage:0.2.5

## [0.2.2] - 2016-07-26
### Changed
  - Upgrade baseimage to light-baseimage:0.2.4
  - Upgrade keepalived version to 1.2.23

## [0.2.1] - 2016-02-20
### Changed
  - Upgrade baseimage to light-baseimage:0.2.2

## [0.2.0] - 2016-01-27
### Added
  - Makefile with build no cache

### Changed
  - Upgrade baseimage to light-baseimage:0.2.1

## [0.1.9] - 2015-11-20
### Changed
  - Upgrade baseimage to light-baseimage:0.1.5

## [0.1.8] - 2015-11-19
### Changed
  - Upgrade baseimage to light-baseimage:0.1.4

## [0.1.7] - 2015-10-26
### Changed
  - Upgrade baseimage to light-baseimage:0.1.2

## [0.1.6] - 2015-08-21
### Added
  - Better way to add custom config

### Changed
  - Improve documentation

## [0.1.5] - 2015-08-19
### Changed
  - Upgrade baseimage to light-baseimage:0.1.1

## [0.1.4] - 2015-07-23
### Changed
  - Use light-baseimage

## [0.1.3] - 2015-07-09
### Fixed
  - Fix libnl dependency

## [0.1.2] - 2015-07-09
### Changed
  - Upgrade keepalived version to 1.2.19
  - Upgrade default config :
  - Set start state to BACKUP

## [0.1.1] - 2015-06-21
### Added
  - Notify script

## 0.1.0 - 2015-06-16
Initial release

[2.0.16]: https://github.com/osixia/docker-keepalived/compare/v2.0.15...v2.0.16
[2.0.15]: https://github.com/osixia/docker-keepalived/compare/v2.0.13...v2.0.15
[2.0.13]: https://github.com/osixia/docker-keepalived/compare/v2.0.12...v2.0.13
[2.0.12]: https://github.com/osixia/docker-keepalived/compare/v2.0.11...v2.0.12
[2.0.11]: https://github.com/osixia/docker-keepalived/compare/v2.0.10...v2.0.11
[2.0.10]: https://github.com/osixia/docker-keepalived/compare/v1.4.5...v2.0.10
[1.4.5]: https://github.com/osixia/docker-keepalived/compare/v1.4.4...v1.4.5
[1.4.4]: https://github.com/osixia/docker-keepalived/compare/v1.4.2...v1.4.4
[1.4.2]: https://github.com/osixia/docker-keepalived/compare/v1.4.1...v1.4.2
[1.4.1]: https://github.com/osixia/docker-keepalived/compare/v1.4.0...v1.4.1
[1.4.0]: https://github.com/osixia/docker-keepalived/compare/v1.3.9...v1.4.0
[1.3.9]: https://github.com/osixia/docker-keepalived/compare/v1.3.8...v1.3.9
[1.3.8]: https://github.com/osixia/docker-keepalived/compare/v1.3.6-1...v1.3.8
[1.3.6-1]: https://github.com/osixia/docker-keepalived/compare/v1.3.6...v1.3.6-1
[1.3.6]: https://github.com/osixia/docker-keepalived/compare/v1.3.5-1...v1.3.6
[1.3.5-1]: https://github.com/osixia/docker-keepalived/compare/v1.3.5...v1.3.5-1
[1.3.5]: https://github.com/osixia/docker-keepalived/compare/v1.3.4...v1.3.5
[1.3.4]: https://github.com/osixia/docker-keepalived/compare/v1.3.3...v1.3.4
[1.3.3]: https://github.com/osixia/docker-keepalived/compare/v1.3.2...v1.3.3
[1.3.2]: https://github.com/osixia/docker-keepalived/compare/v1.3.1...v1.3.2
[1.3.1]: https://github.com/osixia/docker-keepalived/compare/v1.3.0...v1.3.1
[1.3.0]: https://github.com/osixia/docker-keepalived/compare/v1.2.24...v1.3.0
[1.2.24]: https://github.com/osixia/docker-keepalived/compare/v0.2.3...v1.2.24
[0.2.3]: https://github.com/osixia/docker-keepalived/compare/v0.2.2...v0.2.3
[0.2.2]: https://github.com/osixia/docker-keepalived/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/osixia/docker-keepalived/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/osixia/docker-keepalived/compare/v0.1.9...v0.2.0
[0.1.9]: https://github.com/osixia/docker-keepalived/compare/v0.1.8...v0.1.9
[0.1.8]: https://github.com/osixia/docker-keepalived/compare/v0.1.7...v0.1.8
[0.1.7]: https://github.com/osixia/docker-keepalived/compare/v0.1.6...v0.1.7
[0.1.6]: https://github.com/osixia/docker-keepalived/compare/v0.1.5...v0.1.6
[0.1.5]: https://github.com/osixia/docker-keepalived/compare/v0.1.4...v0.1.5
[0.1.4]: https://github.com/osixia/docker-keepalived/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/osixia/docker-keepalived/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/osixia/docker-keepalived/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/osixia/docker-keepalived/compare/v0.1.0...v0.1.1
