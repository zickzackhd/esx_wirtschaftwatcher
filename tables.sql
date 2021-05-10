CREATE TABLE wirtschaft_item_sells (
    id INT AUTO_INCREMENT PRIMARY KEY,
    identifier VARCHAR(255) NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    item VARCHAR(255) NOT NULL,
    item_count INT NOT NULL,
    price FLOAT NOT NULL
)

CREATE TABLE IF NOT EXISTS `wirtschaft` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bargeld` int(11) NOT NULL,
  `bank` int(11) NOT NULL,
  `firmengeld` int(11) NOT NULL,
  `blackmoney` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=719 DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `wirtschaft_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steamname` varchar(50) NOT NULL,
  `bank` int(11) NOT NULL,
  `bargeld` int(11) NOT NULL,
  `blackmoney` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121669 DEFAULT CHARSET=latin1;
