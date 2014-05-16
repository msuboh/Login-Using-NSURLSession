delimiter $$

CREATE TABLE "login" (
  "IdUser" int(11) NOT NULL AUTO_INCREMENT,
  "username" varchar(45) CHARACTER SET latin1 NOT NULL,
  "pass" varchar(45) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY ("IdUser")
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8$$

CREATE TABLE "photos" (
  "IdPhoto" int(11) NOT NULL AUTO_INCREMENT,
  "title" varchar(100) CHARACTER SET latin1 NOT NULL,
  "IdUser" int(11) NOT NULL,
  PRIMARY KEY ("IdPhoto")
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8$$


CREATE TABLE `login` (
  `IdUser` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `firstname` char(25) DEFAULT NULL,
  `lastname` char(25) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `address` blob,
  `sex` char(10) DEFAULT NULL,
  `phonenumber` char(15) DEFAULT NULL,
  `email` char(125) DEFAULT NULL,
  `authorizationLevel` int(2) DEFAULT NULL,
  `activeRecord` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`IdUser`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8


CREATE TABLE `photos` (
  `IdPhoto` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `IdUser` int(11) NOT NULL,
  PRIMARY KEY (`IdPhoto`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8