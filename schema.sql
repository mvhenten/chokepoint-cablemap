CREATE TABLE `cablemap_cable` (
  `id` INT unsigned NOT NULL auto_increment,
  `cable_id` INT unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `capacity` INT NOT NULL,
  `distance` INT NOT NULL,
  `over_land` tinyint(1) unsigned NOT NULL default '0',
  `not_live` tinyint(1) unsigned NOT NULL default '0',
  `in_service` datetime NOT NULL,
  `precise` tinyint(1) unsigned NOT NULL default '0',
  `notes`   TEXT DEFAULT NULL,
  `geometry`    GEOMETRY NOT NULL,
  SPATIAL INDEX(geometry),
  PRIMARY KEY  (`id`),
  KEY `sk_in_service` (`in_service`),
  KEY `sk_cable_id` (`cable_id`)
) ENGINE=Aria DEFAULT CHARSET=utf8;

CREATE TABLE `cablemap_cable_url` (
  `id` INT unsigned NOT NULL auto_increment,
  `cablemap_cable_id` INT unsigned NOT NULL,
  `url` VARCHAR(1024) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_cablemap_cable_id` (`cablemap_cable_id`),
  CONSTRAINT `fk_cablemap_cable_id` FOREIGN KEY (`cablemap_cable_id`) REFERENCES `cablemap_cable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=Aria DEFAULT CHARSET=utf8;

