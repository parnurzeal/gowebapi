DROP TABLE IF EXISTS SEQUENCE;
CREATE TABLE SEQUENCE (
  id BIGINT UNSIGNED NOT NULL
) ENGINE=MyISAM;
INSERT INTO SEQUENCE VALUES(0);


DROP TABLE IF EXISTS _servers;
CREATE TABLE _servers (
    rowid BIGINT UNSIGNED NOT NULL UNIQUE PRIMARY KEY,
    ctime TIMESTAMP not null DEFAULT '0000-00-00 00:00:00',
    mtime TIMESTAMP not null DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    rack INT NOT NULL DEFAULT '0',
    ipmi VARCHAR(128) NOT NULL DEFAULT '',
    id VARCHAR(128) NOT NULL UNIQUE,
    memo VARCHAR(4096) NOT NULL DEFAULT '',
    ipv4 INT UNSIGNED NOT NULL DEFAULT '0',
    stat ENUM('active', 'inactive', 'expired', 'pending') default 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS servers;
CREATE TABLE servers (
    rowid BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    ctime TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
    mtime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- Machine Type
    mt VARCHAR(255) NOT NULL,

  -- Server Serial Number
    sn VARCHAR(255) NOT NULL,

  -- memo
    memo VARCHAR(4096) CHARACTER SET utf8mb4 NOT NULL DEFAULT '' ,

  -- role of a server
    role VARCHAR(10) NOT NULL DEFAULT '',

  -- hostname
    hostname VARCHAR(255) NOT NULL DEFAULT '',

  -- OS Type (ex. Distribution name)
    os_type VARCHAR(255) NOT NULL DEFAULT '',

  -- OS version
    os_ver VARCHAR(255) NOT NULL DEFAULT '',

  -- CPU Frequency (MHz)
    cpu_freq INT NOT NULL DEFAULT 0,

  -- Number of CPU Cores
    cpu_cores INT NOT NULL DEFAULT 1,

  -- Memory Size (kB)
    mem_size INT NOT NULL DEFAULT 0,

  -- rack name
    rack_name VARCHAR(255) NOT NULL DEFAULT '',

  -- rack position
    rack_pos INT NOT NULL DEFAULT -1,

  -- RAID Name
    raid_name VARCHAR(255) NOT NULL DEFAULT '',

  -- status of a server
    stat ENUM('active', 'inactive', 'expired', 'pending') default 'active',

  -- provisioning status: pooled
    prov_stat_pooled ENUM('not_yet', 'in_progress', 'done') DEFAULT 'not_yet',

  -- provisioning status: OS loaded
    prov_stat_os_loaded ENUM('not_yet', 'in_progress', 'done') DEFAULT 'not_yet',

  -- provisioning status: OS Configured
    prov_stat_os_configured ENUM('not_yet', 'in_progress', 'done') DEFAULT 'not_yet',

  -- provisioning status: Prepared for App
    prov_stat_prepared_for_app ENUM('not_yet', 'in_progress', 'done') DEFAULT 'not_yet',

  -- Inventory Status
    stat_inventory ENUM('not_yet', 'in_progress', 'done') DEFAULT 'not_yet',

  -- BIOS Status
    stat_bios ENUM('not_yet', 'in_progress', 'done') NOT NULL DEFAULT 'not_yet',

  -- HardWare Status
    stat_hw ENUM('unknown', 'up', 'down') DEFAULT'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE servers ADD CONSTRAINT UNIQUE(sn,mt);


DROP TABLE IF EXISTS nics;
CREATE TABLE nics (
    rowid BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    ctime TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
    mtime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- server rowid
    server_rowid BIGINT UNSIGNED NOT NULL UNIQUE,

  -- macaddr (xx-xx-xx-xx-xx-xx)
    macaddr CHAR(17) NOT NULL UNIQUE,

  -- inter face name (eth0, eth1...)
    if_name VARCHAR(255) NOT NULL DEFAULT '',

  -- IPv4 address
    if_ipv4 INT UNSIGNED NOT NULL DEFAULT 0,

  -- Network Segment
    nw_seg VARCHAR(255) NOT NULL DEFAULT '',

  -- Edge Switch Name
    edgesw_name VARCHAR(255) NOT NULL DEFAULT '',

  -- Edge Switch Port
    edgesw_port INT NOT NULL DEFAULT -1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS disks;
CREATE TABLE disks (
    rowid BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    ctime TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
    mtime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  -- server rowid
    server_rowid BIGINT UNSIGNED NOT NULL UNIQUE,

  -- Disk Model
    model VARCHAR(255) NOT NULL,

  -- Disk Serial Number
    sn VARCHAR(255) NOT NULL,

  -- Disk Type (UNK,HDD, SSD)
    type CHAR(3) NOT NULL DEFAULT 'UNK',

  -- Disk Size (MB)
    size INT NOT NULL DEFAULT -1,

    KEY(sn, model)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




