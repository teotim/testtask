-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Окт 08 2017 г., 06:10
-- Версия сервера: 5.5.56
-- Версия PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `admin_nodetest`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`admin_test`@`localhost` PROCEDURE `sp_setprice` (IN `p_p` INT, IN `p_s` INT, IN `p_pr` FLOAT)  BEGIN
IF !p_pr > 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Price should be positive';
ELSE
delete from prices where stid = p_s and prid = p_p;
insert into prices(prid,stid,price) values(p_p,p_s,p_pr);
END IF;
end$$

CREATE DEFINER=`admin_test`@`localhost` PROCEDURE `sp_setprod` (IN `p_n` VARCHAR(60), IN `p_p` INT, IN `p_i` INT)  BEGIN
IF p_n = '' THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Product name should not be blank';
ELSEIF p_i = 0 THEN
	Insert into product(name,ptid) values(p_n,p_p);
ELSE
	Update product set name=p_n,ptid=p_p where id=p_i;
END IF;	
END$$


CREATE DEFINER=`admin_test`@`localhost` PROCEDURE `sp_delpr` (IN `p_i` INT)  BEGIN
	delete from prices where prid=p_i;
    delete from product where id=p_i;
END$$


DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `prices`
--

CREATE TABLE `prices` (
  `stid` int(11) NOT NULL,
  `prid` int(11) NOT NULL,
  `price` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prices`
--

INSERT INTO `prices` (`stid`, `prid`, `price`) VALUES
(1, 1, 3.99),
(2, 1, 3.99),
(16, 1, 3.99),
(1, 2, 0.94),
(2, 2, 0.99),
(16, 2, 0.99),
(1, 3, 8.99),
(2, 3, 8.99),
(16, 3, 8.99),
(1, 4, 9.99),
(2, 4, 9.99),
(16, 4, 9.99),
(1, 5, 5.22),
(2, 5, 5.22),
(16, 5, 5.22);

-- --------------------------------------------------------

--
-- Структура таблицы `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `ptid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `product`
--

INSERT INTO `product` (`id`, `name`, `ptid`) VALUES
(1, 'Harry Potter', 1),
(2, 'Bible', 1),
(3, 'Transformer', 2),
(4, 'Pants', 3),
(5, 'T-shirt', 3);

-- --------------------------------------------------------

--
-- Структура таблицы `prtype`
--

CREATE TABLE `prtype` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `prtype`
--

INSERT INTO `prtype` (`id`, `name`) VALUES
(1, 'Book'),
(2, 'Toy'),
(3, 'Clothes');

-- --------------------------------------------------------

--
-- Структура таблицы `store`
--

CREATE TABLE `store` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `city` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `store`
--

INSERT INTO `store` (`id`, `name`, `city`) VALUES
(1, 'CUM', 'Kyiv'),
(2, 'Mart', 'NY'),
(16, 'T-Shop', 'London');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `prices`
--
ALTER TABLE `prices`
  ADD PRIMARY KEY (`prid`,`stid`);

--
-- Индексы таблицы `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `prtype`
--
ALTER TABLE `prtype`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT для таблицы `prtype`
--
ALTER TABLE `prtype`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `store`
--
ALTER TABLE `store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `prices`
--
ALTER TABLE `prices`
  ADD CONSTRAINT `prices_ibfk_7` FOREIGN KEY (`prid`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `prices_ibfk_1` FOREIGN KEY (`stid`) REFERENCES `store` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`ptid`) REFERENCES `prtype` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
