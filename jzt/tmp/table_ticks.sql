PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE `ticks`(
    `tradingday` INT NOT NULL,
    `updatetime` TEXT NOT NULL,
    `lastprice` DOUBLE NOT NULL,
    `volume` INT NOT NULL,
    `amount` DOUBLE NOT NULL,
    `openint` INT NOT NULL,
    `isbuy` INT NOT NULL,
    `instrumentid` TEXT NOT NULL,
    `id` INTEGER PRIMARY KEY AUTOINCREMENT  
);
COMMIT;
