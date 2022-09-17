CREATE DATABASE IF NOT EXISTS `projects` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE USER 'fugu'@'%' IDENTIFIED BY 'fugu';
CREATE USER 'fugu'@'localhost' IDENTIFIED BY 'fugu';
GRANT ALL ON `%`.* TO 'fugu'@'%';
GRANT ALL ON `%`.* TO 'fugu'@'localhost';
FLUSH PRIVILEGES;

CREATE TABLE `projects`.`projects` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(128) NOT NULL DEFAULT '',
  `UpdatedName` varchar(128) NOT NULL DEFAULT '',
  `ProjectVersion` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `projects`.`projects` (`ID`, `Name`, `UpdatedName`, `ProjectVersion`) VALUES
(1, 'project1', '', 'OSD_V7'),
(2, 'project2', '', 'OSD_V9');

CREATE DATABASE IF NOT EXISTS `project1` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `project1`;

CREATE TABLE `bins` (
  `ID` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `category` varchar(100) NOT NULL DEFAULT '',
  `type` varchar(40) NOT NULL DEFAULT '',
  `SourceTable` varchar(40) NOT NULL DEFAULT '',
  `SearchCondition` varchar(250) NOT NULL DEFAULT '',
  `SearchQuery` varchar(250) NOT NULL DEFAULT '',
  `parameters` longtext NOT NULL,
  `atime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `binshots` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `BinName` varchar(100) NOT NULL DEFAULT '',
  `NameOnTimeline` varchar(100) NOT NULL DEFAULT '',
  `MediaID` varchar(100) NOT NULL DEFAULT '',
  `BinOrder` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `cuts` (
  `ID` int(11) NOT NULL,
  `CutName` varchar(128) NOT NULL DEFAULT '',
  `TapeName` varchar(500) NOT NULL DEFAULT '',
  `FromClipName` varchar(500) NOT NULL DEFAULT '',
  `EventID` varchar(200) NOT NULL DEFAULT '',
  `UniqueID` varchar(20) NOT NULL DEFAULT '',
  `TLPos` int(11) NOT NULL DEFAULT 0,
  `TLTrackNo` int(11) NOT NULL DEFAULT 0,
  `StartTC` varchar(12) NOT NULL DEFAULT '',
  `VTRollTC` varchar(12) NOT NULL DEFAULT '',
  `MediaID` varchar(20) NOT NULL DEFAULT '',
  `MediaStartFileNumber` int(11) NOT NULL DEFAULT 0,
  `MediaEndFileNumber` int(11) NOT NULL DEFAULT 0,
  `TCin` varchar(13) NOT NULL DEFAULT '',
  `Length` int(11) NOT NULL DEFAULT 0,
  `SpeedChange` float NOT NULL DEFAULT 100,
  `MediaStartFileNumberStereo` int(11) NOT NULL DEFAULT 0,
  `MediaEndFileNumberStereo` int(11) NOT NULL DEFAULT 0,
  `MediaPathStereo` varchar(500) NOT NULL DEFAULT '',
  `LocatorPos` varchar(500) NOT NULL DEFAULT '',
  `LocatorCol` varchar(500) NOT NULL DEFAULT '',
  `LocatorName` varchar(500) NOT NULL DEFAULT '',
  `Deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `edls` (
  `ID` int(11) NOT NULL,
  `EDLName` varchar(300) NOT NULL DEFAULT '',
  `EventNum` smallint(6) NOT NULL DEFAULT 0,
  `TapeName` varchar(300) NOT NULL DEFAULT '',
  `Effect` varchar(100) NOT NULL DEFAULT '',
  `EffectLength` tinyint(4) NOT NULL DEFAULT 0,
  `SrcTCIn` varchar(12) NOT NULL DEFAULT '',
  `SrcTCOut` varchar(12) NOT NULL DEFAULT '',
  `RecTCIn` varchar(12) NOT NULL DEFAULT '',
  `RecTCOut` varchar(12) NOT NULL DEFAULT '',
  `RSlope` varchar(10) NOT NULL DEFAULT '',
  `ROffset` varchar(10) NOT NULL DEFAULT '',
  `RPower` varchar(10) NOT NULL DEFAULT '',
  `GSlope` varchar(10) NOT NULL DEFAULT '',
  `GOffset` varchar(10) NOT NULL DEFAULT '',
  `GPower` varchar(10) NOT NULL DEFAULT '',
  `BSlope` varchar(10) NOT NULL DEFAULT '',
  `BOffset` varchar(10) NOT NULL DEFAULT '',
  `BPower` varchar(10) NOT NULL DEFAULT '',
  `Saturation` varchar(10) NOT NULL DEFAULT '',
  `CDLIncluded` tinyint(1) NOT NULL DEFAULT 0,
  `FromClipName` varchar(500) NOT NULL DEFAULT '',
  `RetimeSpeed` varchar(16) NOT NULL DEFAULT '',
  `LocatorPos` varchar(500) NOT NULL DEFAULT '',
  `LocatorCol` varchar(500) NOT NULL DEFAULT '',
  `LocatorName` varchar(500) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `event` (
  `ID` int(11) NOT NULL,
  `TapeID` varchar(16) NOT NULL DEFAULT '',
  `ShootDay` smallint(6) NOT NULL DEFAULT 0,
  `LabRoll` varchar(100) NOT NULL DEFAULT '',
  `VTRoll` varchar(100) NOT NULL DEFAULT '',
  `Event` varchar(100) NOT NULL DEFAULT '',
  `Job` varchar(100) NOT NULL DEFAULT '',
  `Status` varchar(16) NOT NULL DEFAULT '',
  `DateTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `grades` (
  `Group` varchar(200) NOT NULL DEFAULT '',
  `UniqueID` varchar(100) NOT NULL DEFAULT '',
  `Version` int(11) NOT NULL,
  `Hidden` int(11) NOT NULL DEFAULT 0,
  `TimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `Grade` mediumtext NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `latestgrade` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `LatestGrade` mediumtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `lto` (
  `ID` int(11) NOT NULL,
  `TransferDate` datetime NOT NULL DEFAULT current_timestamp(),
  `ShootDay` smallint(6) NOT NULL DEFAULT 0,
  `VTRoll` varchar(32) NOT NULL DEFAULT '',
  `LabRoll` varchar(32) NOT NULL DEFAULT '',
  `LTO` varchar(32) NOT NULL DEFAULT '',
  `Online` tinyint(1) NOT NULL DEFAULT 0,
  `ArchiveTime` timestamp NOT NULL DEFAULT current_timestamp(),
  `Operator` varchar(32) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `mediainfo` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `MediaID` varchar(100) NOT NULL DEFAULT '',
  `Proxy` varchar(250) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `mediametadata` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `qc` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(20) NOT NULL DEFAULT '',
  `QcNumber` smallint(6) NOT NULL DEFAULT 0,
  `Eye` varchar(10) NOT NULL DEFAULT '',
  `Region` varchar(10) NOT NULL DEFAULT 'ALL',
  `X` float NOT NULL DEFAULT 0,
  `Y` float NOT NULL DEFAULT 0,
  `Time` varchar(10) NOT NULL DEFAULT 'Shot',
  `StartTC` varchar(16) NOT NULL DEFAULT '',
  `EndTC` varchar(16) NOT NULL DEFAULT '',
  `Rate` int(11) NOT NULL DEFAULT 0,
  `Comment` varchar(128) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `settings` (
  `ID` int(11) NOT NULL,
  `category` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `param` varchar(120) NOT NULL DEFAULT '',
  `value` mediumtext NOT NULL DEFAULT '',
  `enums` varchar(2048) NOT NULL DEFAULT '',
  `description` varchar(150) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `shots` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `MediaType` varchar(24) NOT NULL DEFAULT 'Video',
  `LabRoll` varchar(300) NOT NULL DEFAULT '',
  `TCin` varchar(16) NOT NULL DEFAULT '',
  `ClipName` varchar(300) NOT NULL DEFAULT '',
  `ClipNameStereo` varchar(300) NOT NULL DEFAULT '',
  `SrcReelName` varchar(300) NOT NULL DEFAULT '',
  `MediaStartFileNumber` int(11) NOT NULL DEFAULT 0,
  `MediaEndFileNumber` int(11) NOT NULL DEFAULT 0,
  `Length` int(11) NOT NULL DEFAULT 0,
  `AnimationOffset` int(11) NOT NULL DEFAULT 0,
  `StartTC` varchar(12) NOT NULL DEFAULT '',
  `RecTCforSelected` varchar(12) NOT NULL DEFAULT '',
  `VTRoll` varchar(300) NOT NULL DEFAULT '',
  `MediaPath` varchar(500) NOT NULL DEFAULT '',
  `MediaPathStereo` varchar(500) NOT NULL DEFAULT '',
  `MediaStartFileNumberStereo` int(11) NOT NULL DEFAULT 0,
  `MediaEndFileNumberStereo` int(11) NOT NULL DEFAULT 0,
  `MediaStereoSlip` int(11) NOT NULL DEFAULT 0,
  `DominantEye` varchar(10) NOT NULL DEFAULT '',
  `ShootDate` varchar(10) NOT NULL DEFAULT '',
  `TransferDate` varchar(50) NOT NULL DEFAULT '',
  `ShootDay` varchar(50) NOT NULL DEFAULT '',
  `Block` tinyint(4) NOT NULL DEFAULT 0,
  `Episode` varchar(100) NOT NULL DEFAULT '',
  `CamRoll` varchar(100) NOT NULL DEFAULT '',
  `CamRollStereo` varchar(100) NOT NULL DEFAULT '',
  `ColorSpace` varchar(500) NOT NULL DEFAULT '',
  `CameraFormat` varchar(500) NOT NULL DEFAULT '',
  `DetectedCameraFormat` varchar(500) NOT NULL DEFAULT '',
  `Scene` varchar(100) NOT NULL DEFAULT '',
  `Slate` varchar(100) NOT NULL DEFAULT '',
  `Take` varchar(100) NOT NULL DEFAULT '',
  `Camera` varchar(100) NOT NULL DEFAULT '',
  `Selected` tinyint(1) NOT NULL DEFAULT 0,
  `Tags` varchar(500) NOT NULL DEFAULT '',
  `Graded` varchar(50) NOT NULL DEFAULT '0',
  `LUTName` varchar(100) NOT NULL DEFAULT '',
  `SpeedChange` float NOT NULL DEFAULT 100,
  `BrotherhoodID` varchar(200) NOT NULL DEFAULT '',
  `LoadedWithGrade` int(11) NOT NULL DEFAULT 1,
  `Description` varchar(500) NOT NULL DEFAULT '',
  `SceneCharacters` varchar(500) NOT NULL DEFAULT '',
  `ADR` int(11) NOT NULL DEFAULT 0,
  `PickUp` tinyint(1) NOT NULL DEFAULT 0,
  `SoundRoll` varchar(200) NOT NULL DEFAULT '',
  `AudioTCIn` varchar(12) NOT NULL DEFAULT '',
  `AudioTCStart` varchar(12) NOT NULL DEFAULT '',
  `AudioChannelNum` smallint(6) NOT NULL DEFAULT 0,
  `AudioFile` varchar(600) NOT NULL DEFAULT '',
  `AudioSubframeOffset` float NOT NULL DEFAULT 0,
  `AudioSyncPosition` float NOT NULL DEFAULT 0,
  `AudioXML` text NOT NULL,
  `AudioLTC` varchar(50) NOT NULL DEFAULT '',
  `AudioLTCTrackNr` int(11) NOT NULL DEFAULT 0,
  `AudioOriginalLength` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `AudioOriginalStart` bigint(20) NOT NULL DEFAULT 0,
  `AudioClapsDetected` int(11) NOT NULL DEFAULT 0,
  `AudioSync1` float NOT NULL DEFAULT -1,
  `AudioSync2` float NOT NULL DEFAULT -1,
  `AudioSync3` float NOT NULL DEFAULT -1,
  `AudioFrameSyncNumber` int(11) NOT NULL DEFAULT 0,
  `Framerate` float NOT NULL DEFAULT 24,
  `RecFramerate` float NOT NULL DEFAULT 24,
  `AudioFramerate` float NOT NULL DEFAULT 24,
  `Comment` varchar(1024) NOT NULL DEFAULT '',
  `AudioSyncState` varchar(10) NOT NULL DEFAULT '',
  `LockedByFugu` enum('yes','no') NOT NULL DEFAULT 'no',
  `FirstSaveFromFugu` timestamp NOT NULL DEFAULT current_timestamp(),
  `StartKeyNum` varchar(20) NOT NULL DEFAULT '',
  `EndKeyNum` varchar(20) NOT NULL DEFAULT '',
  `SavedMediaEndFileNumber` int(11) NOT NULL DEFAULT 0,
  `SavedLength` int(11) NOT NULL DEFAULT 0,
  `ScreenerOrder` smallint(6) NOT NULL DEFAULT 0,
  `Screener1Order` smallint(6) NOT NULL DEFAULT 0,
  `Screener2Order` smallint(6) NOT NULL DEFAULT 0,
  `Screener3Order` smallint(6) NOT NULL DEFAULT 0,
  `Screener4Order` smallint(6) NOT NULL DEFAULT 0,
  `ALEIn` varchar(12) NOT NULL DEFAULT '',
  `ALEOut` varchar(12) NOT NULL DEFAULT '',
  `Fixed` varchar(20) NOT NULL DEFAULT '',
  `Orientation` varchar(20) NOT NULL DEFAULT '',
  `ExportedGrade` varchar(200) NOT NULL DEFAULT '',
  `Zoom` float NOT NULL DEFAULT 0,
  `Focus` float NOT NULL DEFAULT 0,
  `Iris` float NOT NULL DEFAULT 0,
  `Convergence` float NOT NULL DEFAULT 0,
  `IO` float NOT NULL DEFAULT 0,
  `MarkIn` varchar(16) NOT NULL DEFAULT '',
  `MarkOut` varchar(16) NOT NULL DEFAULT '',
  `EdgeTC` varchar(16) NOT NULL DEFAULT '',
  `subtitleLanguage` varchar(200) NOT NULL DEFAULT '',
  `subtitleTitle` varchar(200) NOT NULL DEFAULT '',
  `subtitleReel` varchar(200) NOT NULL DEFAULT '',
  `OriginalEndFileNumber` int(11) NOT NULL DEFAULT 0,
  `Deleted` int(11) NOT NULL DEFAULT 0,
  `RenderTarget` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `tapes` (
  `ID` int(11) NOT NULL,
  `Camera` varchar(16) NOT NULL DEFAULT '',
  `MediaStartFileNumber` int(11) NOT NULL DEFAULT 0,
  `MediaEndFileNumber` int(11) NOT NULL DEFAULT 0,
  `RecordTC` varchar(12) NOT NULL DEFAULT '',
  `UniqueID` varchar(16) NOT NULL DEFAULT '',
  `VTRoll` varchar(16) NOT NULL DEFAULT '',
  `MediaPath` varchar(500) NOT NULL DEFAULT '',
  `ShootDate` varchar(10) NOT NULL DEFAULT '',
  `TransferDate` varchar(30) NOT NULL DEFAULT '',
  `ShootDay` int(11) NOT NULL DEFAULT 0,
  `Framerate` float NOT NULL DEFAULT 0,
  `TransferredToShots` tinyint(4) NOT NULL DEFAULT 0,
  `CaptureReady` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `thumbnails` (
  `filename` varchar(200) NOT NULL DEFAULT '',
  `UniqueID` varchar(100) NOT NULL DEFAULT '',
  `filesize` int(11) NOT NULL,
  `thumbnail` mediumblob NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `timelines` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `TLName` varchar(100) NOT NULL DEFAULT '',
  `MediaIndex` int(11) NOT NULL DEFAULT 0,
  `Framerate` float NOT NULL DEFAULT 0,
  `Dropframe` tinyint(1) NOT NULL DEFAULT 0,
  `Pos` int(11) NOT NULL DEFAULT 0,
  `Length` int(11) NOT NULL DEFAULT 0,
  `RecInOffset` int(11) NOT NULL DEFAULT 0,
  `RecTCIn` varchar(16) NOT NULL DEFAULT '',
  `SrcFramerate` float NOT NULL DEFAULT 0,
  `SrcDropframe` tinyint(4) NOT NULL DEFAULT 0,
  `SrcInPos` bigint(20) NOT NULL DEFAULT 0,
  `SrcLength` int(11) NOT NULL DEFAULT 0,
  `SrcMediaRef` varchar(16) NOT NULL DEFAULT '',
  `SrcMediaID` varchar(20) NOT NULL DEFAULT '',
  `SrcMediaLayer` varchar(16) NOT NULL DEFAULT '',
  `SrcSpeed` float NOT NULL DEFAULT 0,
  `Tags` varchar(500) NOT NULL DEFAULT '',
  `TrackNo` int(11) NOT NULL DEFAULT 0,
  `Type` varchar(10) NOT NULL DEFAULT '',
  `ConformType` varchar(50) NOT NULL DEFAULT '',
  `ConformFile` varchar(400) NOT NULL DEFAULT '',
  `ConformID` varchar(400) NOT NULL DEFAULT '',
  `ConformStatus` varchar(50) NOT NULL DEFAULT '',
  `Deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

ALTER TABLE `bins`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `binshots`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `BinShotIndex` (`UniqueID`,`BinName`);

ALTER TABLE `cuts`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UniqueID` (`UniqueID`);

ALTER TABLE `edls`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `event`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `grades`
  ADD PRIMARY KEY (`UniqueID`,`Version`);

ALTER TABLE `latestgrade`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UniqueID` (`UniqueID`);

ALTER TABLE `lto`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `mediainfo`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UniqueID` (`UniqueID`,`MediaID`);

ALTER TABLE `mediametadata`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UniqueID` (`UniqueID`,`name`),
  ADD KEY `name` (`name`),
  ADD KEY `value` (`value`(333));

ALTER TABLE `qc`
  ADD PRIMARY KEY (`UniqueID`,`QcNumber`),
  ADD UNIQUE KEY `ID` (`ID`);

ALTER TABLE `settings`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `param` (`param`,`category`);

ALTER TABLE `shots`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UniqueID` (`UniqueID`);

ALTER TABLE `tapes`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `thumbnails`
  ADD PRIMARY KEY (`UniqueID`);

ALTER TABLE `timelines`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `TLEventIndex` (`UniqueID`,`TLName`,`MediaIndex`);

ALTER TABLE `bins`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `binshots`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `cuts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `edls`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `event`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `latestgrade`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `lto`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `mediainfo`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `mediametadata`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

ALTER TABLE `qc`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `settings`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1491;

ALTER TABLE `shots`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `tapes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `timelines`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

CREATE DATABASE IF NOT EXISTS `project2` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `project2`;

CREATE TABLE `bins` (
  `ID` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `category` varchar(100) NOT NULL DEFAULT '',
  `type` varchar(40) NOT NULL DEFAULT '',
  `SourceTable` varchar(40) NOT NULL DEFAULT '',
  `SearchCondition` varchar(250) NOT NULL DEFAULT '',
  `SearchQuery` varchar(250) NOT NULL DEFAULT '',
  `parameters` longtext NOT NULL,
  `atime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `binshots` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `BinName` varchar(100) NOT NULL DEFAULT '',
  `NameOnTimeline` varchar(100) NOT NULL DEFAULT '',
  `MediaID` varchar(100) NOT NULL DEFAULT '',
  `BinOrder` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `cuts` (
  `ID` int(11) NOT NULL,
  `CutName` varchar(128) NOT NULL DEFAULT '',
  `TapeName` varchar(500) NOT NULL DEFAULT '',
  `FromClipName` varchar(500) NOT NULL DEFAULT '',
  `EventID` varchar(200) NOT NULL DEFAULT '',
  `UniqueID` varchar(20) NOT NULL DEFAULT '',
  `TLPos` int(11) NOT NULL DEFAULT 0,
  `TLTrackNo` int(11) NOT NULL DEFAULT 0,
  `StartTC` varchar(12) NOT NULL DEFAULT '',
  `VTRollTC` varchar(12) NOT NULL DEFAULT '',
  `MediaID` varchar(20) NOT NULL DEFAULT '',
  `MediaStartFileNumber` int(11) NOT NULL DEFAULT 0,
  `MediaEndFileNumber` int(11) NOT NULL DEFAULT 0,
  `TCin` varchar(13) NOT NULL DEFAULT '',
  `Length` int(11) NOT NULL DEFAULT 0,
  `SpeedChange` float NOT NULL DEFAULT 100,
  `MediaStartFileNumberStereo` int(11) NOT NULL DEFAULT 0,
  `MediaEndFileNumberStereo` int(11) NOT NULL DEFAULT 0,
  `MediaPathStereo` varchar(500) NOT NULL DEFAULT '',
  `LocatorPos` varchar(500) NOT NULL DEFAULT '',
  `LocatorCol` varchar(500) NOT NULL DEFAULT '',
  `LocatorName` varchar(500) NOT NULL DEFAULT '',
  `Deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `edls` (
  `ID` int(11) NOT NULL,
  `EDLName` varchar(300) NOT NULL DEFAULT '',
  `EventNum` smallint(6) NOT NULL DEFAULT 0,
  `TapeName` varchar(300) NOT NULL DEFAULT '',
  `Effect` varchar(100) NOT NULL DEFAULT '',
  `EffectLength` tinyint(4) NOT NULL DEFAULT 0,
  `SrcTCIn` varchar(12) NOT NULL DEFAULT '',
  `SrcTCOut` varchar(12) NOT NULL DEFAULT '',
  `RecTCIn` varchar(12) NOT NULL DEFAULT '',
  `RecTCOut` varchar(12) NOT NULL DEFAULT '',
  `RSlope` varchar(10) NOT NULL DEFAULT '',
  `ROffset` varchar(10) NOT NULL DEFAULT '',
  `RPower` varchar(10) NOT NULL DEFAULT '',
  `GSlope` varchar(10) NOT NULL DEFAULT '',
  `GOffset` varchar(10) NOT NULL DEFAULT '',
  `GPower` varchar(10) NOT NULL DEFAULT '',
  `BSlope` varchar(10) NOT NULL DEFAULT '',
  `BOffset` varchar(10) NOT NULL DEFAULT '',
  `BPower` varchar(10) NOT NULL DEFAULT '',
  `Saturation` varchar(10) NOT NULL DEFAULT '',
  `CDLIncluded` tinyint(1) NOT NULL DEFAULT 0,
  `FromClipName` varchar(500) NOT NULL DEFAULT '',
  `RetimeSpeed` varchar(16) NOT NULL DEFAULT '',
  `LocatorPos` varchar(500) NOT NULL DEFAULT '',
  `LocatorCol` varchar(500) NOT NULL DEFAULT '',
  `LocatorName` varchar(500) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `event` (
  `ID` int(11) NOT NULL,
  `TapeID` varchar(16) NOT NULL DEFAULT '',
  `ShootDay` smallint(6) NOT NULL DEFAULT 0,
  `LabRoll` varchar(100) NOT NULL DEFAULT '',
  `VTRoll` varchar(100) NOT NULL DEFAULT '',
  `Event` varchar(100) NOT NULL DEFAULT '',
  `Job` varchar(100) NOT NULL DEFAULT '',
  `Status` varchar(16) NOT NULL DEFAULT '',
  `DateTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `grades` (
  `Group` varchar(200) NOT NULL DEFAULT '',
  `UniqueID` varchar(100) NOT NULL DEFAULT '',
  `Version` int(11) NOT NULL,
  `Hidden` int(11) NOT NULL DEFAULT 0,
  `TimeStamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `Grade` mediumtext NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `latestgrade` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `LatestGrade` mediumtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `lto` (
  `ID` int(11) NOT NULL,
  `TransferDate` datetime NOT NULL DEFAULT current_timestamp(),
  `ShootDay` smallint(6) NOT NULL DEFAULT 0,
  `VTRoll` varchar(32) NOT NULL DEFAULT '',
  `LabRoll` varchar(32) NOT NULL DEFAULT '',
  `LTO` varchar(32) NOT NULL DEFAULT '',
  `Online` tinyint(1) NOT NULL DEFAULT 0,
  `ArchiveTime` timestamp NOT NULL DEFAULT current_timestamp(),
  `Operator` varchar(32) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `mediainfo` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `MediaID` varchar(100) NOT NULL DEFAULT '',
  `Proxy` varchar(250) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `mediametadata` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `value` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `qc` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(20) NOT NULL DEFAULT '',
  `QcNumber` smallint(6) NOT NULL DEFAULT 0,
  `Eye` varchar(10) NOT NULL DEFAULT '',
  `Region` varchar(10) NOT NULL DEFAULT 'ALL',
  `X` float NOT NULL DEFAULT 0,
  `Y` float NOT NULL DEFAULT 0,
  `Time` varchar(10) NOT NULL DEFAULT 'Shot',
  `StartTC` varchar(16) NOT NULL DEFAULT '',
  `EndTC` varchar(16) NOT NULL DEFAULT '',
  `Rate` int(11) NOT NULL DEFAULT 0,
  `Comment` varchar(128) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `settings` (
  `ID` int(11) NOT NULL,
  `category` varchar(32) NOT NULL DEFAULT '',
  `type` varchar(32) NOT NULL DEFAULT '',
  `param` varchar(120) NOT NULL DEFAULT '',
  `value` mediumtext NOT NULL DEFAULT '',
  `enums` varchar(2048) NOT NULL DEFAULT '',
  `description` varchar(150) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `shots` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `MediaType` varchar(24) NOT NULL DEFAULT 'Video',
  `LabRoll` varchar(300) NOT NULL DEFAULT '',
  `TCin` varchar(16) NOT NULL DEFAULT '',
  `ClipName` varchar(300) NOT NULL DEFAULT '',
  `ClipNameStereo` varchar(300) NOT NULL DEFAULT '',
  `SrcReelName` varchar(300) NOT NULL DEFAULT '',
  `MediaStartFileNumber` int(11) NOT NULL DEFAULT 0,
  `MediaEndFileNumber` int(11) NOT NULL DEFAULT 0,
  `Length` int(11) NOT NULL DEFAULT 0,
  `AnimationOffset` int(11) NOT NULL DEFAULT 0,
  `StartTC` varchar(12) NOT NULL DEFAULT '',
  `RecTCforSelected` varchar(12) NOT NULL DEFAULT '',
  `VTRoll` varchar(300) NOT NULL DEFAULT '',
  `MediaPath` varchar(500) NOT NULL DEFAULT '',
  `MediaPathStereo` varchar(500) NOT NULL DEFAULT '',
  `MediaStartFileNumberStereo` int(11) NOT NULL DEFAULT 0,
  `MediaEndFileNumberStereo` int(11) NOT NULL DEFAULT 0,
  `MediaStereoSlip` int(11) NOT NULL DEFAULT 0,
  `DominantEye` varchar(10) NOT NULL DEFAULT '',
  `ShootDate` varchar(10) NOT NULL DEFAULT '',
  `TransferDate` varchar(50) NOT NULL DEFAULT '',
  `ShootDay` varchar(50) NOT NULL DEFAULT '',
  `Block` tinyint(4) NOT NULL DEFAULT 0,
  `Episode` varchar(100) NOT NULL DEFAULT '',
  `CamRoll` varchar(100) NOT NULL DEFAULT '',
  `CamRollStereo` varchar(100) NOT NULL DEFAULT '',
  `ColorSpace` varchar(500) NOT NULL DEFAULT '',
  `CameraFormat` varchar(500) NOT NULL DEFAULT '',
  `DetectedCameraFormat` varchar(500) NOT NULL DEFAULT '',
  `Scene` varchar(100) NOT NULL DEFAULT '',
  `Slate` varchar(100) NOT NULL DEFAULT '',
  `Take` varchar(100) NOT NULL DEFAULT '',
  `Camera` varchar(100) NOT NULL DEFAULT '',
  `Selected` tinyint(1) NOT NULL DEFAULT 0,
  `Tags` varchar(500) NOT NULL DEFAULT '',
  `Graded` varchar(50) NOT NULL DEFAULT '0',
  `LUTName` varchar(100) NOT NULL DEFAULT '',
  `SpeedChange` float NOT NULL DEFAULT 100,
  `BrotherhoodID` varchar(200) NOT NULL DEFAULT '',
  `LoadedWithGrade` int(11) NOT NULL DEFAULT 1,
  `Description` varchar(500) NOT NULL DEFAULT '',
  `SceneCharacters` varchar(500) NOT NULL DEFAULT '',
  `ADR` int(11) NOT NULL DEFAULT 0,
  `PickUp` tinyint(1) NOT NULL DEFAULT 0,
  `SoundRoll` varchar(200) NOT NULL DEFAULT '',
  `AudioTCIn` varchar(12) NOT NULL DEFAULT '',
  `AudioTCStart` varchar(12) NOT NULL DEFAULT '',
  `AudioChannelNum` smallint(6) NOT NULL DEFAULT 0,
  `AudioFile` varchar(600) NOT NULL DEFAULT '',
  `AudioSubframeOffset` float NOT NULL DEFAULT 0,
  `AudioSyncPosition` float NOT NULL DEFAULT 0,
  `AudioXML` text NOT NULL,
  `AudioLTC` varchar(50) NOT NULL DEFAULT '',
  `AudioLTCTrackNr` int(11) NOT NULL DEFAULT 0,
  `AudioOriginalLength` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `AudioOriginalStart` bigint(20) NOT NULL DEFAULT 0,
  `AudioClapsDetected` int(11) NOT NULL DEFAULT 0,
  `AudioSync1` float NOT NULL DEFAULT -1,
  `AudioSync2` float NOT NULL DEFAULT -1,
  `AudioSync3` float NOT NULL DEFAULT -1,
  `AudioFrameSyncNumber` int(11) NOT NULL DEFAULT 0,
  `Framerate` float NOT NULL DEFAULT 24,
  `RecFramerate` float NOT NULL DEFAULT 24,
  `AudioFramerate` float NOT NULL DEFAULT 24,
  `Comment` varchar(1024) NOT NULL DEFAULT '',
  `AudioSyncState` varchar(10) NOT NULL DEFAULT '',
  `LockedByFugu` enum('yes','no') NOT NULL DEFAULT 'no',
  `FirstSaveFromFugu` timestamp NOT NULL DEFAULT current_timestamp(),
  `StartKeyNum` varchar(20) NOT NULL DEFAULT '',
  `EndKeyNum` varchar(20) NOT NULL DEFAULT '',
  `SavedMediaEndFileNumber` int(11) NOT NULL DEFAULT 0,
  `SavedLength` int(11) NOT NULL DEFAULT 0,
  `ScreenerOrder` smallint(6) NOT NULL DEFAULT 0,
  `Screener1Order` smallint(6) NOT NULL DEFAULT 0,
  `Screener2Order` smallint(6) NOT NULL DEFAULT 0,
  `Screener3Order` smallint(6) NOT NULL DEFAULT 0,
  `Screener4Order` smallint(6) NOT NULL DEFAULT 0,
  `ALEIn` varchar(12) NOT NULL DEFAULT '',
  `ALEOut` varchar(12) NOT NULL DEFAULT '',
  `Fixed` varchar(20) NOT NULL DEFAULT '',
  `Orientation` varchar(20) NOT NULL DEFAULT '',
  `ExportedGrade` varchar(200) NOT NULL DEFAULT '',
  `Zoom` float NOT NULL DEFAULT 0,
  `Focus` float NOT NULL DEFAULT 0,
  `Iris` float NOT NULL DEFAULT 0,
  `Convergence` float NOT NULL DEFAULT 0,
  `IO` float NOT NULL DEFAULT 0,
  `MarkIn` varchar(16) NOT NULL DEFAULT '',
  `MarkOut` varchar(16) NOT NULL DEFAULT '',
  `EdgeTC` varchar(16) NOT NULL DEFAULT '',
  `subtitleLanguage` varchar(200) NOT NULL DEFAULT '',
  `subtitleTitle` varchar(200) NOT NULL DEFAULT '',
  `subtitleReel` varchar(200) NOT NULL DEFAULT '',
  `OriginalEndFileNumber` int(11) NOT NULL DEFAULT 0,
  `Deleted` int(11) NOT NULL DEFAULT 0,
  `RenderTarget` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `tapes` (
  `ID` int(11) NOT NULL,
  `Camera` varchar(16) NOT NULL DEFAULT '',
  `MediaStartFileNumber` int(11) NOT NULL DEFAULT 0,
  `MediaEndFileNumber` int(11) NOT NULL DEFAULT 0,
  `RecordTC` varchar(12) NOT NULL DEFAULT '',
  `UniqueID` varchar(16) NOT NULL DEFAULT '',
  `VTRoll` varchar(16) NOT NULL DEFAULT '',
  `MediaPath` varchar(500) NOT NULL DEFAULT '',
  `ShootDate` varchar(10) NOT NULL DEFAULT '',
  `TransferDate` varchar(30) NOT NULL DEFAULT '',
  `ShootDay` int(11) NOT NULL DEFAULT 0,
  `Framerate` float NOT NULL DEFAULT 0,
  `TransferredToShots` tinyint(4) NOT NULL DEFAULT 0,
  `CaptureReady` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `thumbnails` (
  `filename` varchar(200) NOT NULL DEFAULT '',
  `UniqueID` varchar(100) NOT NULL DEFAULT '',
  `filesize` int(11) NOT NULL,
  `thumbnail` mediumblob NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `timelines` (
  `ID` int(11) NOT NULL,
  `UniqueID` varchar(24) NOT NULL DEFAULT '',
  `TLName` varchar(100) NOT NULL DEFAULT '',
  `MediaIndex` int(11) NOT NULL DEFAULT 0,
  `Framerate` float NOT NULL DEFAULT 0,
  `Dropframe` tinyint(1) NOT NULL DEFAULT 0,
  `Pos` int(11) NOT NULL DEFAULT 0,
  `Length` int(11) NOT NULL DEFAULT 0,
  `RecInOffset` int(11) NOT NULL DEFAULT 0,
  `RecTCIn` varchar(16) NOT NULL DEFAULT '',
  `SrcFramerate` float NOT NULL DEFAULT 0,
  `SrcDropframe` tinyint(4) NOT NULL DEFAULT 0,
  `SrcInPos` bigint(20) NOT NULL DEFAULT 0,
  `SrcLength` int(11) NOT NULL DEFAULT 0,
  `SrcMediaRef` varchar(16) NOT NULL DEFAULT '',
  `SrcMediaID` varchar(20) NOT NULL DEFAULT '',
  `SrcMediaLayer` varchar(16) NOT NULL DEFAULT '',
  `SrcSpeed` float NOT NULL DEFAULT 0,
  `Tags` varchar(500) NOT NULL DEFAULT '',
  `TrackNo` int(11) NOT NULL DEFAULT 0,
  `Type` varchar(10) NOT NULL DEFAULT '',
  `ConformType` varchar(50) NOT NULL DEFAULT '',
  `ConformFile` varchar(400) NOT NULL DEFAULT '',
  `ConformID` varchar(400) NOT NULL DEFAULT '',
  `ConformStatus` varchar(50) NOT NULL DEFAULT '',
  `Deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

ALTER TABLE `bins`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `name` (`name`);

ALTER TABLE `binshots`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `BinShotIndex` (`UniqueID`,`BinName`);

ALTER TABLE `cuts`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UniqueID` (`UniqueID`);

ALTER TABLE `edls`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `event`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `grades`
  ADD PRIMARY KEY (`UniqueID`,`Version`);

ALTER TABLE `latestgrade`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UniqueID` (`UniqueID`);

ALTER TABLE `lto`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `mediainfo`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UniqueID` (`UniqueID`,`MediaID`);

ALTER TABLE `mediametadata`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UniqueID` (`UniqueID`,`name`),
  ADD KEY `name` (`name`),
  ADD KEY `value` (`value`(333));

ALTER TABLE `qc`
  ADD PRIMARY KEY (`UniqueID`,`QcNumber`),
  ADD UNIQUE KEY `ID` (`ID`);

ALTER TABLE `settings`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `param` (`param`,`category`);

ALTER TABLE `shots`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UniqueID` (`UniqueID`);

ALTER TABLE `tapes`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `thumbnails`
  ADD PRIMARY KEY (`UniqueID`);

ALTER TABLE `timelines`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `TLEventIndex` (`UniqueID`,`TLName`,`MediaIndex`);

ALTER TABLE `bins`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `binshots`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `cuts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `edls`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `event`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `latestgrade`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `lto`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `mediainfo`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `mediametadata`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

ALTER TABLE `qc`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `settings`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1491;

ALTER TABLE `shots`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `tapes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `timelines`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
