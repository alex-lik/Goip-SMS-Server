-- Adminer 4.8.1 MySQL 11.3.2-MariaDB-1:11.3.2+maria~ubu2204 dump

SET NAMES utf8;
SET time_zone = '+02:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `auto`;
CREATE TABLE `auto` (
  `auto_reply` tinyint(1) DEFAULT 0,
  `reply_num_except` text NOT NULL,
  `reply_msg` text NOT NULL,
  `auto_send` tinyint(1) DEFAULT 0,
  `auto_send_num` varchar(64) NOT NULL DEFAULT '',
  `auto_send_msg` text NOT NULL,
  `auto_send_timeout` int(11) NOT NULL DEFAULT 0,
  `all_send_num` varchar(64) NOT NULL DEFAULT '',
  `all_send_msg` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `auto` (`auto_reply`, `reply_num_except`, `reply_msg`, `auto_send`, `auto_send_num`, `auto_send_msg`, `auto_send_timeout`, `all_send_num`, `all_send_msg`) VALUES
(0,	'',	'',	0,	'',	'',	15,	'',	'');

DROP TABLE IF EXISTS `auto_ussd`;
CREATE TABLE `auto_ussd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `type` int(11) NOT NULL,
  `auto_sms_num` varchar(32) NOT NULL,
  `auto_sms_msg` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `auto_ussd` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `prov_id` int(11) NOT NULL DEFAULT 0,
  `goip_id` int(11) NOT NULL DEFAULT 0,
  `crontime` int(11) NOT NULL,
  `bal_sms_r` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bal_ussd_r` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bal_limit` float NOT NULL,
  `recharge_ussd` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `last_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `next_time` int(10) unsigned NOT NULL DEFAULT 0,
  `send_sms` varchar(128) NOT NULL,
  `send_email` varchar(32) NOT NULL,
  `recharge_type` int(1) NOT NULL DEFAULT 0,
  `recharge_ussd1` varchar(160) NOT NULL,
  `recharge_ussd1_goip` int(11) NOT NULL,
  `recharge_ok_r` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `recharge_ok_r2` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bal_ussd_zero_match_char` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bal_sms_zero_match_char` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `disable_if_low_bal` tinyint(1) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `auto_disconnect_after_bal` tinyint(1) NOT NULL DEFAULT 0,
  `disable_callout_when_bal` tinyint(1) NOT NULL DEFAULT 0,
  `ussd2` varchar(160) NOT NULL,
  `ussd2_ok_match` varchar(160) NOT NULL,
  `ussd22` varchar(160) NOT NULL,
  `ussd22_ok_match` varchar(160) NOT NULL,
  `send_mail2` char(32) NOT NULL,
  `disable_if_ussd2_undone` tinyint(1) NOT NULL DEFAULT 0,
  `recharge_limit` int(11) NOT NULL DEFAULT 0,
  `send_sms2` varchar(32) NOT NULL,
  `recharge_sms_num` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `recharge_sms_msg` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `recharge_sms_ok_num` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `auto_ussd_step2` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `auto_ussd_step2_start_r` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `sms_report_goip` int(11) NOT NULL,
  `bal_delay` int(11) NOT NULL DEFAULT 0,
  `re_step2_enable` tinyint(1) NOT NULL,
  `re_step2_cmd` varchar(64) NOT NULL,
  `re_step2_ok_r` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `auto_reset_remain_enable` tinyint(1) NOT NULL DEFAULT 0,
  `auto_ussd_step3` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `auto_ussd_step3_start_r` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `auto_ussd_step4` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `auto_ussd_step4_start_r` varchar(160) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `recharge_con_type` int(11) NOT NULL DEFAULT 0,
  `fixed_time` varchar(10) NOT NULL,
  `remain_limit` int(11) NOT NULL DEFAULT 0,
  `remain_set` int(11) NOT NULL DEFAULT 0,
  `fixed_next_time` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prov_id` (`prov_id`,`goip_id`),
  KEY `recharge_ussd1_goip` (`recharge_ussd1_goip`),
  KEY `group_id` (`group_id`),
  KEY `sms_report_goip` (`sms_report_goip`),
  KEY `recharge_con_type` (`recharge_con_type`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


DROP TABLE IF EXISTS `crowd`;
CREATE TABLE `crowd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `info` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `crowd` (`id`, `name`, `info`) VALUES
(1,	'TEST',	'');

DROP TABLE IF EXISTS `goip`;
CREATE TABLE `goip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `provider` int(11) DEFAULT NULL,
  `host` varchar(50) DEFAULT '',
  `port` int(11) DEFAULT 0,
  `password` varchar(64) DEFAULT '',
  `alive` tinyint(1) DEFAULT 0,
  `num` varchar(30) DEFAULT '',
  `signal` int(11) DEFAULT NULL,
  `gsm_status` varchar(30) DEFAULT NULL,
  `voip_status` varchar(30) DEFAULT NULL,
  `voip_state` varchar(30) DEFAULT NULL,
  `bal` float DEFAULT -1,
  `CELLINFO` varchar(160) DEFAULT NULL,
  `CGATT` varchar(32) DEFAULT NULL,
  `BCCH` varchar(160) DEFAULT NULL,
  `bal_time` datetime DEFAULT '0000-00-00 00:00:00',
  `keepalive_time` datetime DEFAULT '0000-00-00 00:00:00',
  `gsm_login_time` datetime DEFAULT '0000-00-00 00:00:00',
  `gsm_login_time_t` int(11) DEFAULT 0,
  `keepalive_time_t` int(11) DEFAULT 0,
  `remain_time` int(11) DEFAULT -1,
  `imei` varchar(15) DEFAULT NULL,
  `imsi` varchar(32) DEFAULT NULL,
  `iccid` varchar(32) DEFAULT NULL,
  `last_call_record_id` int(11) DEFAULT NULL,
  `remain_count` int(11) DEFAULT -1,
  `count_limit` int(11) DEFAULT -1,
  `remain_count_d` int(11) DEFAULT -1,
  `count_limit_d` int(11) DEFAULT -1,
  `group_id` int(11) DEFAULT 0,
  `report_mail` varchar(64) DEFAULT NULL,
  `fwd_mail_enable` tinyint(1) DEFAULT 0,
  `report_http` varchar(64) DEFAULT NULL,
  `fwd_http_enable` tinyint(1) DEFAULT 0,
  `carrier` varchar(32) DEFAULT NULL,
  `auto_num_c` int(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `password` (`password`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `goip_group`;
CREATE TABLE `goip_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`group_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `info` varchar(100) DEFAULT NULL,
  `crowdid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `crowdid` (`crowdid`),
  CONSTRAINT `groups_ibfk_1` FOREIGN KEY (`crowdid`) REFERENCES `crowd` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `groups` (`id`, `name`, `info`, `crowdid`) VALUES
(1,	'TEST',	'',	1);

DROP TABLE IF EXISTS `imei_db`;
CREATE TABLE `imei_db` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imei` varchar(15) NOT NULL,
  `goipid` int(11) NOT NULL,
  `goipname` varchar(64) NOT NULL,
  `used` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `used` (`used`),
  KEY `goipid` (`goipid`),
  KEY `imei` (`imei`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `crontime` int(10) unsigned NOT NULL DEFAULT 0,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `userid` int(11) NOT NULL DEFAULT 0,
  `cronid` int(11) NOT NULL DEFAULT 0,
  `msg` text NOT NULL,
  `type` int(1) NOT NULL DEFAULT 0,
  `receiverid` text DEFAULT NULL,
  `receiverid1` text DEFAULT NULL,
  `receiverid2` text DEFAULT NULL,
  `groupid` text DEFAULT NULL,
  `groupid1` text DEFAULT NULL,
  `groupid2` text DEFAULT NULL,
  `recv` tinyint(1) NOT NULL DEFAULT 0,
  `recv1` tinyint(1) NOT NULL DEFAULT 0,
  `recv2` tinyint(1) NOT NULL DEFAULT 0,
  `over` int(1) NOT NULL DEFAULT 0,
  `stoptime` int(10) unsigned DEFAULT 0,
  `tel` text DEFAULT NULL,
  `prov` varchar(30) DEFAULT NULL,
  `goipid` int(11) DEFAULT 0,
  `uid` varchar(64) DEFAULT NULL,
  `msgid` int(10) unsigned DEFAULT 0,
  `total` int(11) NOT NULL DEFAULT 0,
  `card_id` int(11) NOT NULL,
  `card` varchar(64) NOT NULL,
  `resend` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `crontime` (`crontime`),
  KEY `type` (`type`),
  KEY `over` (`over`),
  KEY `prov` (`prov`),
  KEY `time` (`time`),
  KEY `stoptime` (`stoptime`),
  KEY `card_id` (`card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `prov`;
CREATE TABLE `prov` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prov` varchar(30) DEFAULT NULL,
  `inter` varchar(10) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `local` varchar(10) CHARACTER SET ascii COLLATE ascii_general_ci DEFAULT NULL,
  `recharge_ok_r` varchar(64) NOT NULL,
  `auto_num_ussd` varchar(20) NOT NULL,
  `num_prefix` varchar(20) NOT NULL,
  `num_postfix` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `prov` (`id`, `prov`, `inter`, `local`, `recharge_ok_r`, `auto_num_ussd`, `num_prefix`, `num_postfix`) VALUES
(1,	'test',	'',	'',	'',	'',	'',	''),
(2,	'',	'',	'',	'',	'',	'',	''),
(3,	'',	'',	'',	'',	'',	'',	''),
(4,	'',	'',	'',	'',	'',	'',	''),
(5,	'',	'',	'',	'',	'',	'',	''),
(6,	'',	'',	'',	'',	'',	'',	''),
(7,	'',	'',	'',	'',	'',	'',	''),
(8,	'',	'',	'',	'',	'',	'',	''),
(9,	'',	'',	'',	'',	'',	'',	''),
(10,	'',	'',	'',	'',	'',	'',	'');

DROP TABLE IF EXISTS `receive`;
CREATE TABLE `receive` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `srcnum` varchar(30) NOT NULL DEFAULT '',
  `provid` int(10) unsigned NOT NULL DEFAULT 0,
  `msg` text NOT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `goipid` int(11) NOT NULL DEFAULT 0,
  `goipname` varchar(30) NOT NULL DEFAULT '',
  `srcid` int(11) NOT NULL DEFAULT 0,
  `srcname` varchar(30) NOT NULL DEFAULT '',
  `srclevel` int(1) NOT NULL DEFAULT 0,
  `status` int(1) NOT NULL DEFAULT 0,
  `smscnum` varchar(32) NOT NULL,
  `senttime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `receiver`;
CREATE TABLE `receiver` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL DEFAULT '',
  `name_l` varchar(20) NOT NULL,
  `ename_f` varchar(30) NOT NULL,
  `ename_l` varchar(30) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `info` varchar(100) NOT NULL DEFAULT '',
  `tel` varchar(20) DEFAULT NULL,
  `hometel` varchar(20) NOT NULL,
  `officetel` varchar(20) NOT NULL,
  `provider` varchar(20) NOT NULL DEFAULT '',
  `dead` int(1) NOT NULL,
  `reject` int(1) NOT NULL,
  `name1` varchar(20) NOT NULL DEFAULT '',
  `tel1` varchar(20) DEFAULT NULL,
  `provider1` varchar(20) NOT NULL DEFAULT '',
  `name2` varchar(20) NOT NULL DEFAULT '',
  `tel2` varchar(20) DEFAULT NULL,
  `provider2` varchar(20) NOT NULL DEFAULT '',
  `upload_time` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `recharge_card`;
CREATE TABLE `recharge_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card` varchar(64) NOT NULL,
  `prov_id` int(11) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `use_time` datetime DEFAULT '0000-00-00 00:00:00',
  `goipid` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `prov_id` (`prov_id`),
  KEY `goipid` (`goipid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;


DROP TABLE IF EXISTS `record`;
CREATE TABLE `record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goipid` int(10) unsigned NOT NULL DEFAULT 0,
  `dir` int(1) NOT NULL DEFAULT 0,
  `num` varchar(64) NOT NULL DEFAULT '',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `expiry` int(11) DEFAULT -1,
  `HANGUP_CAUSE` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `expiry` (`expiry`),
  KEY `goipid` (`goipid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;



DROP TABLE IF EXISTS `recvgroup`;
CREATE TABLE `recvgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupsid` int(11) NOT NULL DEFAULT 0,
  `recvid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `groupsid` (`groupsid`),
  KEY `recvid` (`recvid`),
  CONSTRAINT `recvgroup_ibfk_1` FOREIGN KEY (`groupsid`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `recvgroup_ibfk_2` FOREIGN KEY (`recvid`) REFERENCES `receiver` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `refcrowd`;
CREATE TABLE `refcrowd` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL DEFAULT 0,
  `crowdid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `crowdid` (`crowdid`),
  CONSTRAINT `refcrowd_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `refcrowd_ibfk_2` FOREIGN KEY (`crowdid`) REFERENCES `crowd` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `refgroup`;
CREATE TABLE `refgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupsid` int(11) NOT NULL DEFAULT 0,
  `userid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `groupsid` (`groupsid`),
  KEY `userid` (`userid`),
  CONSTRAINT `refgroup_ibfk_1` FOREIGN KEY (`groupsid`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `refgroup_ibfk_2` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `sends`;
CREATE TABLE `sends` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `userid` int(11) NOT NULL DEFAULT 0,
  `messageid` int(11) NOT NULL DEFAULT 0,
  `goipid` int(11) NOT NULL DEFAULT 0,
  `provider` varchar(20) NOT NULL DEFAULT '',
  `telnum` varchar(20) NOT NULL DEFAULT '',
  `recvlev` int(1) NOT NULL DEFAULT 0,
  `recvid` int(11) NOT NULL DEFAULT 0,
  `over` tinyint(1) DEFAULT 0,
  `error_no` int(11) DEFAULT NULL,
  `msg` text NOT NULL,
  `received` tinyint(1) NOT NULL,
  `sms_no` int(11) NOT NULL DEFAULT -1,
  `total` int(11) NOT NULL DEFAULT 0,
  `sending_line` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `messageid` (`messageid`),
  KEY `over` (`over`),
  KEY `goipid` (`goipid`),
  KEY `recvid` (`recvid`),
  KEY `sms_no` (`sms_no`),
  KEY `received` (`received`),
  KEY `sending_line` (`sending_line`),
  CONSTRAINT `sends_ibfk_1` FOREIGN KEY (`messageid`) REFERENCES `message` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


DROP TABLE IF EXISTS `system`;
CREATE TABLE `system` (
  `maxword` int(11) NOT NULL DEFAULT 70,
  `sysname` varchar(20) NOT NULL DEFAULT 'goipsms',
  `lan` int(1) NOT NULL DEFAULT 3,
  `version` int(11) NOT NULL DEFAULT 114,
  `smtp_user` varchar(64) NOT NULL,
  `smtp_pass` varchar(64) NOT NULL,
  `smtp_mail` varchar(64) NOT NULL,
  `smtp_server` varchar(64) NOT NULL,
  `smtp_port` int(11) NOT NULL DEFAULT 25,
  `email_report_gsm_logout_enable` tinyint(1) NOT NULL DEFAULT 0,
  `email_report_gsm_logout_time_limit` int(11) NOT NULL DEFAULT 5,
  `email_report_reg_logout_enable` tinyint(1) NOT NULL DEFAULT 0,
  `email_report_reg_logout_time_limit` int(11) NOT NULL DEFAULT 5,
  `report_mail` varchar(64) NOT NULL,
  `email_report_remain_timeout_enable` tinyint(1) NOT NULL DEFAULT 0,
  `send_page_jump_enable` tinyint(1) NOT NULL DEFAULT 0,
  `endless_send_enable` tinyint(1) NOT NULL DEFAULT 0,
  `re_ask_timer` int(11) NOT NULL DEFAULT 3,
  `total` int(11) NOT NULL DEFAULT 0,
  `this_day` int(11) NOT NULL DEFAULT 0,
  `email_forward_sms_enable` tinyint(1) NOT NULL DEFAULT 0,
  `email_remain_count_enable` tinyint(1) NOT NULL DEFAULT 0,
  `email_remain_count_d_enable` tinyint(1) NOT NULL DEFAULT 0,
  `session_time` int(11) NOT NULL DEFAULT 24,
  `disable_status` tinyint(1) NOT NULL DEFAULT 0,
  `json_send_url` varchar(128) NOT NULL,
  `json_recv_url` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

INSERT INTO `system` (`maxword`, `sysname`, `lan`, `version`, `smtp_user`, `smtp_pass`, `smtp_mail`, `smtp_server`, `smtp_port`, `email_report_gsm_logout_enable`, `email_report_gsm_logout_time_limit`, `email_report_reg_logout_enable`, `email_report_reg_logout_time_limit`, `report_mail`, `email_report_remain_timeout_enable`, `send_page_jump_enable`, `endless_send_enable`, `re_ask_timer`, `total`, `this_day`, `email_forward_sms_enable`, `email_remain_count_enable`, `email_remain_count_d_enable`, `session_time`, `disable_status`, `json_send_url`, `json_recv_url`) VALUES
(70,	'goipsms',	3,	119,	'',	'',	'',	'',	25,	0,	5,	0,	5,	'',	0,	1,	0,	3,	0,	19901,	0,	0,	0,	24,	0,	'',	'');

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `password` varchar(50) NOT NULL DEFAULT '',
  `permissions` int(1) NOT NULL DEFAULT 0,
  `info` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `msg1` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `msg2` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `msg3` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `msg4` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `msg5` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `msg6` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `msg7` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `msg8` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `msg9` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `msg10` varchar(320) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `user` (`id`, `username`, `password`, `permissions`, `info`, `msg1`, `msg2`, `msg3`, `msg4`, `msg5`, `msg6`, `msg7`, `msg8`, `msg9`, `msg10`) VALUES
(1,	'smsadmin',	'e80ec6ff0fc5969bd7fe892224560b5c',	0,	'Super Adminstrator',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'');

DROP TABLE IF EXISTS `USSD`;
CREATE TABLE `USSD` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `TERMID` varchar(64) NOT NULL DEFAULT '',
  `USSD_MSG` varchar(255) NOT NULL DEFAULT '',
  `USSD_RETURN` varchar(255) NOT NULL DEFAULT '',
  `ERROR_MSG` varchar(64) NOT NULL DEFAULT '',
  `INSERTTIME` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `type` int(11) NOT NULL DEFAULT 0,
  `card` varchar(64) NOT NULL,
  `recharge_ok` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;


-- 2024-06-27 11:41:52
