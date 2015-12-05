

2014-06-24

CREATE TABLE IF NOT EXISTS ctp (
id INT NOT NULL,
thread BIGINT NOT NULL,
loglevel VARCHAR(5) NOT NULL,

/*
loglevel enum("DEBUG","WARN") NOT NULL,
*/

TradingDay DATE NOT NULL,
InstrumentID VARCHAR(31) NOT NULL,
ExchangeID VARCHAR(9), 
ExchangeInstID VARCHAR(31),
LastPrice DOUBLE NOT NULL,
PreSettlementPrice DOUBLE,
PreClosePrice DOUBLE,
PreOpenInterest INT,
OpenPrice DOUBLE,
HighestPrice DOUBLE,
LowestPrice DOUBLE,
Volume INT,
Turnover DOUBLE,
OpenInterest INT,
ClosePrice DOUBLE,
SettlementPrice DOUBLE,
UpperLimitPrice DOUBLE,
LowerLimitPrice DOUBLE,
PreDelta DOUBLE,
CurrDelta DOUBLE,
UpdateTime TIME,
UpdateMillisec INT,
BidPrice1 DOUBLE,
BidVolume1 INT,
AskPrice1 DOUBLE,
AskVolume1 INT,
AveragePrice DOUBLE,
seq_num INT NOT NULL)
//正式 ENGINE=InnoDB DEFAULT CHARSET=utf8 |
# TradingDay VARCHAR(9) NOT NULL,
# loglevel VARCHAR(7) NOT NULL,


7342659 [140689204025088] DEBUG test <> - 20140623 y1409   6838 6730 6740 345804 6740 6858 6736 184828 1.25759e+10 308848 1.79769e+308 1.79769e+308 6998 6462 14:58:52 \
0 6838 344 6840 159 68041 402374

mysql -hrdsryfjb2vqrni2.mysql.rds.aliyuncs.com -P3306 -ubotel -p

2014-07-01
sudo mysqld --verbose --help
Please run mysql_upgrade to create it
Default options are read from the following files in the given order:
/etc/my.cnf /etc/mysql/my.cnf /usr/etc/my.cnf ~/.my.cnf

//转向sqlite

 
"

INSERT INTO ctp  (id,thread, loglevel, TradingDay, InstrumentID, LastPrice, PreSettlementPrice , PreClosePrice, PreOpenInterest, OpenPrice, HighestPrice, LowestPrice, Volume, Turnover, OpenInterest, ClosePrice, SettlementPrice, UpperLimitPrice, LowerLimitPrice, UpdateTime, UpdateMillisec, BidPrice1, BidVolume1, AskPrice1, AskVolume1, AveragePrice, seq_num) VALUES (18246655,139707331954432,'DEBUG',20140627,'au1408',  263.25, 264.05, 263.8, 212, 262.45, 263.25, 262.45, 16, 4.2072e+06, 220, 1.79769e+308,1.79769e+308, 277.25, 250, 250.8, '02:00:15', 0, 262.75, 2, 263.3, 1, 262950, 255957)

2014-07-14
CREATE UNIQUE INDEX idx0 ON ctp (id,TradingDay,InstrumentID,UpdateTime,UpdateMillisec)  

CREATE TABLE IF NOT EXISTS tmp
(
id INT NOT NULL,
thread BIGINT NOT NULL,
loglevel VARCHAR(5) NOT NULL,
TradingDay DATE NOT NULL,
InstrumentID VARCHAR(31) NOT NULL,
LastPrice DOUBLE NOT NULL,
PreSettlementPrice DOUBLE,
PreClosePrice DOUBLE,
PreOpenInterest INT,
OpenPrice DOUBLE,
HighestPrice DOUBLE,
LowestPrice DOUBLE,
Volume INT, s
Turnover DOUBLE,
OpenInterest INT,
ClosePrice DOUBLE,
SettlementPrice DOUBLE,
UpperLimitPrice DOUBLE,
LowerLimitPrice DOUBLE,
UpdateTime TIME,
UpdateMillisec INT,
BidPrice1 DOUBLE,
BidVolume1 INT,
AskPrice1 DOUBLE,
AskVolume1 INT,
AveragePrice DOUBLE,
seq_num INT NOT NULL
)

create index idx0 on tmp (instrumentid)
create index idx1 on tmp (updatetime,updatemillisec)

insert into tmp (
id ,
thread ,
loglevel ,
TradingDay ,
InstrumentID ,
LastPrice ,
PreSettlementPrice ,
PreClosePrice ,
PreOpenInterest ,
OpenPrice ,
HighestPrice ,
LowestPrice ,
Volume ,
Turnover ,
OpenInterest ,
ClosePrice ,
SettlementPrice ,
UpperLimitPrice ,
LowerLimitPrice ,
UpdateTime ,
UpdateMillisec ,
BidPrice1 ,
BidVolume1 ,
AskPrice1 ,
AskVolume1 ,
AveragePrice,
seq_num )
select
id ,
thread ,
loglevel ,
TradingDay ,
InstrumentID ,
LastPrice ,
PreSettlementPrice ,
PreClosePrice ,
PreOpenInterest ,
OpenPrice ,
HighestPrice ,
LowestPrice ,
Volume ,
Turnover ,
OpenInterest ,
ClosePrice ,
SettlementPrice ,
UpperLimitPrice ,
LowerLimitPrice ,
UpdateTime ,
UpdateMillisec ,
BidPrice1 ,
BidVolume1 ,
AskPrice1 ,
AskVolume1 ,
AveragePrice,
seq_num
from ctp
where tradingday = 20140728
and (updatetime <= "02:30:00" or (updatetime >= "09:00:00" and updatetime <="15:15:00") or updatetime >= "20:59:00")

#################################################################
select left(updatetime,5) as dt, count(*) from tmp where (left(updatetime,5) > "02:30" and left(updatetime,5) < "07:33") group by dt;
select * from tmp where (left(updatetime,5) > "02:30" and left(updatetime,5) < "07:33") group by left(updatetime,5);
select * from tmp where (left(updatetime,5) == "07:09")
select * from tmp where loglevel != "DEBUG"

select count(*) from ctp where tradingday = 20140710 and (updatetime <= "02:30:00" or (updatetime >= "09:00:00" and updatetime <="15:15:00") or updatetime > "20:59:00")
#################################################################
张平 2014/7/18 9:14:02
分析行情，不需要关联其他表
单表查询，用?Sql查询，想不出使用的必要性
#################################################################
## local:mysql
create index idx0 on ctp (tradingday)
create index idx1 on ctp (instrumentid)
create index idx2 on ctp (updatetime,updatemillisec)
#################################################################
// time stat
select left(updatetime,4) as t count(*) from ctp group by t
 
select instrumentid,lastprice,openprice,volume,turnover,openinterest,closeprice,settlementprice,updatetime + INTERVAL updatemillisec*1000 MICROSECOND as dt,bidprice1,bidvolume1,askprice1,askvolume1 from ctp where tradingday=20140721 limit 10  

select instrumentid,count(*) from ctp where tradingday=20140721 group by instrumentid ## cmp al1410 zn1410
// dump 20140728 into tmp
//
select count(*) from tmp where instrumentid='al1410'
select count(*) from tmp where instrumentid='zn1410'

# begin…end之间是存储过程的主体定义
# mysql的分界符是分号（；）

调用存储过程的方法是：
# CALL加上过程名以及一个括号
# 例如调用上面定义的存储过程
CALL productpricing();
# 哪怕是不用传递参数，存储过程名字后面的括号“（）”也是必须的

删除存储过程的方法是：
DROP PROCUDURE productpricing;

创建带参数的存储过程：
CREATE PROCUDURE productpricing(

OUT p1 DECIMAL(8,2),

OUT ph DECIMAL(8,2),

OUT pa DECIMAL(8,2)
)

BEGIN
SELECT Min(prod_price) INTO pl FROM products;
SELECT Max(prod_price) INTO ph FROM products;
SELECT Avg(prod_price) INTO pa FROM products;
END;
# DECIMAL用于指定参数的数据类型
# OUT用于表明此值是用于从存储过程里输出的
# MySQL支持 OUT, IN, INOUT

调用带参数的存储过程：
CALL productpricing(@pricelow,
@pricehigh,
@priceaverage);
# 所有的参数必须以@开头
# 要想获取@priceaverage的值，用以下语句
SELECT @priceaverage;
# 获取三个的值，用以下语句
SELECT @pricehigh, @pricelow, @priceaverage;
另一个带IN和OUT参数的存储过程：
CREATE PROCEDURE ordertotal(
IN onumber INT,
OUT ototal DECIMAL(8,2)
)
BEGIN
SELECT Sum(item_price*quantity)
FROM orderitems
WHERE order_num = onumber
INTO ototal;
END;
CALL ordertotal(20005, @total);
SELECT @total;

添加一个完整的例子:(这是一个自定义分页的存储过程)
DELIMITER $$
DROP PROCEDURE IF EXISTS `dbcall`.`get_page`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_page`(

tableName varchar(100),

fieldsNames varchar(100),

pageIndex int,

pageSize int,

sortName varchar(500),

strWhere varchar(500)
)
BEGIN
DECLARE fieldlist varchar(200);
if fieldsNames=''||fieldsNames=null THEN
set fieldlist='*';
else
set fieldlist=fieldsNames;
end if;

if strWhere=''||strWhere=null then
if sortName=''||sortName=null then
set @strSQL=concat('SELECT ',fieldlist,' FROM ',tableName,' LIMIT ',(pageIndex-1)*pageSize,',',pageSize);
else
set @strSQL=concat('SELECT ',fieldlist,' FROM ',tableName,' ORDER BY ',sortName,' LIMIT ',(pageIndex-1)*pageSize,',',pageSize);
end if;
else
if sortName=''||sortName=null then
set @strSQL=concat('SELECT ',fieldlist,' FROM ',tableName,' WHERE ',strWhere,' LIMIT ',(pageIndex-1)*pageSize,',',pageSize);
else
set @strSQL=concat('SELECT ',fieldlist,' FROM ',tableName,' WHERE ',strWhere,' ORDER BY ',sortName,' LIMIT ',(pageIndex-1)*pageSize,',',pageSize);
end if;
end if;
PREPARE stmt1 FROM @strSQL;
EXECUTE stmt1;
DEALLOCATE PREPARE stmt1;
END$$
DELIMITER ;


http://blog.sina.com.cn/s/blog_71f4cdbe0100yut4.html 

 

FAILTED TO SPARSED:


2014-09-25
## create index idx0 on t20140924 (tradingday)
create index idx1 on t20140924 (instrumentid)
create index idx2 on t20140924 (updatetime,updatemillisec)
## indexation
SELECT LEFT(updatetime,4) t,count(*) FROM t20140924 GROUP BY t ORDER BY t ASC

SET @TIME = "07:1";
SET @TBL = t20140924;
## 1st log
SELECT id,thread,loglevel,updatetime,instrumentid,seq_num,updatemillisec FROM t20140924
WHERE left(updatetime,4)=@TIME ORDER BY instrumentid ASC 
 
## 2nd price,vol,oint
SELECT updatetime,instrumentid,lastprice,volume,openinterest FROM t20140924
WHERE left(updatetime,5)=@TIME ORDER BY instrumentid ASC

## 3rd priceS
SELECT updatetime,instrumentid,lastprice,openprice,highestprice,LowestPrice,upperlimitprice,lowerlimitprice,AveragePrice FROM t20140924
WHERE left(updatetime,4)=@TIME ORDER BY instrumentid ASC

## 4th pq books
SELECT updatetime,updatemillisec,instrumentid,lastprice,volume,openinterest,BidPrice1,BidVolume1,AskPrice1,AskVolume1,AveragePrice FROM t20140924
WHERE left(updatetime,4)=@TIME ORDER BY@TBLntid ASC

SELECT updatetime,updatemillisec,instrumentid,lastprice,volume,BidPrice1,BidVolume1,AskPrice1,AskVolume1 FROM t20140924
WHERE instrumentid = "TA504" ORDER BY seq_num limit 100


## rmk on t20140924:
15:3 exist 15 records. Triple for IF1410,IF1412,IF1503,TF1412,TF1503.
02:3 exist 50 records. All AG,AU.
07:1 exist 5 records. All IF,TF.
07:3 exist 371 records. Seems to be all mkts, some repeations.
08:5 exist 135 records. All mkts.
11:3 exist 135 records.
18:3 exist 279 records.
19:0 exist 87 records.
19:1 exist 217 records.
20:5 exist 76 records.
14:59. Some CZCE have settlementprice and closeprice.

## stlmnt prc time:
IF TF 15:30
DCE 15:00:32
SHFE 15:00:00
CZCE 14:59:30


select * from (select instrumentid,min(updatetime) as t,max(volume) as v,min(settlementprice) as ps from t20140924 where updatetime <= "15:50" and settlementprice < 1.0e308 group by instrumentid ) as t where t.v >0 order by t.t DESC

select * from (select instrumentid,min(updatetime) as t,max(volume) as v,min(closeprice) as ps from t20140924 where updatetime <= "15:50" and closeprice < 1.0e308 group by instrumentid ) as t where t.v >0 order by t.t DESC

select updatetime,instrumentid,settlementprice,closeprice FROM t20140924 where closeprice <= 1.0e308 and settlementprice <= 1.0e308 group by instrumentid order by NULL

## redundant records
SELECT id,thread,loglevel,updatetime,instrumentid,seq_num,updatemillisec FROM t20140924 a where (a.instrumentid,a.updatetime,a.updatemillisec) in (select instrumentid,updatetime,updatemillisec from t20140924 group by instrumentid,updatetime,updatemillisec having count(*)>1)

## only CEFFEX SHFE have non zero updatemillisec.

mysql中如何计算日期之差:
select unix_timestamp(date)-unix_timestamp(end) as '两者相差的秒数' from '表名'；

-------------------------------------------------------------------------------------
CREATETABLE`users`(
`id`int(10) NOT NULL AUTO_INCREMENT,
`name`char(50) NOT NULL,
PRIMARYKEY(`id`)
)
delete from users where id in (select*from (select min(id) from users group by name having count(name)>1));
-------------------------------------------------------------------------------------

#select left(updatetime,5) as t,count(*) from ctp where tradingday =20140818 group by t order by t;
 
-- select * from ctp where tradingday =20140818;
-- SET @TBL = t20140924;
-- select * from t20140924 limit 1;
-- SELECT LEFT(updatetime,4) t,count(*) FROM t20140924 GROUP BY t ORDER BY t ASC;
-- create index idx1 on t20140924 (instrumentid);
-- SELECT id,thread,loglevel,updatetime,instrumentid,seq_num,updatemillisec FROM t20140924
-- SELECT updatetime,instrumentid,lastprice,openprice,highestprice,LowestPrice,upperlimitprice,lowerlimitprice,AveragePrice FROM t20140924
-- SELECT updatetime,updatemillisec,instrumentid,lastprice,volume,openinterest,BidPrice1,BidVolume1,AskPrice1,AskVolume1,AveragePrice FROM t20140924
-- SELECT id,thread,loglevel,updatetime,instrumentid,seq_num,updatemillisec FROM t20140924 a where (a.instrumentid,a.updatetime,a.updatemillisec) in (select instrumentid,updatetime,updatemillisec from t20140924 group by instrumentid,updatetime,updatemillisec having count(*)>1)
-- select id,updatetime,UpdateMillisec from t20140924 where instrumentid="CF411" and updatemillisec = 0
-- select distinct instrumentid from t20140924 where updatemillisec != 0
-- select distinct instrumentid from t20140924
-- select distinct InstrumentID from t20140924 where left(instrumentid,2)="IF"
create temporary table tmp (InstrumentID VARCHAR(31) NOT NULL, );
select count(*) from t20140924 where left(instrumentid,2)="IF" group by instrumentid,

2014-10-27
INSERT INTO `sample` VALUES ('2014-09-22','cu1505',46800,48060,48000,3948,48000,48020,46790,1008,237694000,4482,1.79769e308,1.79769e308,50460,45650,'14:57:27',500,46760,2,46790,3,235807,1768184)
INSERT INTO `sample` VALUES ('2014-09-22','IF1410',2383.4,2439.6,2441.4,133563,2438.2,2438.6,2375.6,777093,559643000000,143895,1.79769e308,1.79769e308,2683.4,2195.8,'14:58:15',600,2383.2,16,2383.4,88,720174,1773488)

2014-10-27
show create table ctp;

// $TOMCAT ctpsample.db
CREATE TABLE sample
(
TradingDay INT NOT NULL,
InstrumentID TEXT NOT NULL,
LastPrice DOUBLE NOT NULL,
PreSettlementPrice DOUBLE,
PreClosePrice DOUBLE,
PreOpenInterest INT,
OpenPrice DOUBLE,
HighestPrice DOUBLE,
LowestPrice DOUBLE,
Volume INT,
Turnover DOUBLE,
OpenInterest INT,
ClosePrice DOUBLE,
SettlementPrice DOUBLE,
UpperLimitPrice DOUBLE,
LowerLimitPrice DOUBLE,
UpdateTime TEXT,
UpdateMillisec INT,
BidPrice1 DOUBLE,
BidVolume1 INT,
AskPrice1 DOUBLE,
AskVolume1 INT,
AveragePrice DOUBLE,
seq_num INT NOT NULL
);

// data_2_0.db
sqlite> select * from v1404_Day  limit 5;
TickTime|High|Low|Open|Close|Vol|OI|Avg
2013-04-26T00:00:00|6925.0|6725.0|6725.0|6925.0|0.0|2.0|6925.0
sqlite> select * from v1404_Min  limit 5;
TickTime|High|Low|Open|Close|Vol|OI|Avg
2013-04-26T09:00:00|6725.0|6725.0|6725.0|6725.0|0.0|0.0|0.0
2013-04-26T09:01:00|6725.0|6725.0|6725.0|6725.0|0.0|0.0|0.0
2013-04-26T09:02:00|6725.0|6725.0|6725.0|6725.0|0.0|0.0|0.0
2013-04-26T09:03:00|6725.0|6725.0|6725.0|6725.0|0.0|0.0|0.0
2013-04-26T09:04:00|6725.0|6725.0|6725.0|6725.0|0.0|0.0|0.0
sqlite> select * from zn8888_Min where vol != 0  limit 5;
TickTime|High|Low|Open|Close|Vol|OI|Avg
2010-04-07T09:00:00|19745.0|19700.0|19745.0|19715.0|8296.0|210540.0|3945.0
2010-04-07T09:01:00|19745.0|19710.0|19715.0|19735.0|4618.0|211476.0|3945.0
2010-04-07T09:02:00|19775.0|19725.0|19730.0|19775.0|8952.0|212858.0|3945.0
2010-04-07T09:03:00|19780.0|19750.0|19775.0|19755.0|6164.0|213620.0|3950.0
2010-04-07T09:04:00|19760.0|19745.0|19760.0|19750.0|4058.0|215094.0|3950.0

select * from tcontracts where minday = "Day" limit 30;
select distinct ticker from tcontracts order by ticker ASC;

sqlite> .schema IF1312_Day
CREATE TABLE IF1312_Day (
"TickTime"  DateTime NOT NULL,
"High"  REAL NOT NULL,
"Low"  REAL NOT NULL,
"Open"  REAL NOT NULL,
"Close"  REAL NOT NULL,
"Vol"  REAL NOT NULL,
"OI"  REAL NOT NULL,
"Avg"  REAL,
PRIMARY KEY ("TickTime" ASC)
);
sqlite> .schema IF1312_Min
CREATE TABLE IF1312_Min (
"TickTime"  DateTime NOT NULL,
"High"  REAL NOT NULL,
"Low"  REAL NOT NULL,
"Open"  REAL NOT NULL,
"Close"  REAL NOT NULL,
"Vol"  REAL NOT NULL,
"OI"  REAL NOT NULL,
"Avg"  REAL,
PRIMARY KEY ("TickTime" ASC)
);
sqlite> .schema tcontracts
CREATE TABLE tcontracts (
"contract" TEXT NOT NULL,
"ticker" TEXT NOT NULL,
 "deliver" TEXT  NOT NULL,
"minday" TEXT NOT NULL,
PRIMARY KEY ("contract" ASC, "minday" ASC)
);


SELECT (contract || "_" || minday FROM tcontracts) as t WHERE ticker == 'IF' and minday == 'Min' order by deliver ASC
 
//////////////////////////////////////////////20150204
sql_create_table = """CREATE TABLE mktinfo (
    id INT NOT NULL
    ,thread INT NOT NULL
    ,TradingDay INT NOT NULL
    ,InstrumentID TEXT NOT NULL
    ,LastPrice DOUBLE NOT NULL
    ,PreSettlementPrice DOUBLE
    ,PreClosePrice DOUBLE
    ,PreOpenInterest INT
    ,OpenPrice DOUBLE
    ,HighestPrice DOUBLE
    ,LowestPrice DOUBLE
    ,Volume INT
    ,Turnover DOUBLE
    ,OpenInterest INT
    ,ClosePrice DOUBLE
    ,SettlementPrice DOUBLE
    ,UpperLimitPrice DOUBLE
    ,LowerLimitPrice DOUBLE
    ,UpdateTime TEXT
    ,UpdateMillisec INT
    ,BidPrice1 DOUBLE
    ,BidVolume1 INT
    ,AskPrice1 DOUBLE
    ,AskVolume1 INT
    ,AveragePrice DOUBLE
    ,seq_num INT NOT NULL
    ,PRIMARY KEY(seq_num, TradingDay, InstrumentID, UpdateTime, UpdateMillisec)
    );"""

create temporary table tmp (
 idx INTERGER PRIMARY KEY ASC,
    id INT NOT NULL
    ,thread INT NOT NULL
    ,TradingDay INT NOT NULL
    ,InstrumentID TEXT NOT NULL
    ,LastPrice DOUBLE NOT NULL
    ,PreSettlementPrice DOUBLE
    ,PreClosePrice DOUBLE
    ,PreOpenInterest INT
    ,OpenPrice DOUBLE
    ,HighestPrice DOUBLE
    ,LowestPrice DOUBLE
    ,Volume INT
    ,Turnover DOUBLE
    ,OpenInterest INT
    ,ClosePrice DOUBLE
    ,SettlementPrice DOUBLE
    ,UpperLimitPrice DOUBLE
    ,LowerLimitPrice DOUBLE
    ,UpdateTime TEXT
    ,UpdateMillisec INT
    ,BidPrice1 DOUBLE
    ,BidVolume1 INT
    ,AskPrice1 DOUBLE
    ,AskVolume1 INT
    ,AveragePrice DOUBLE
    ,seq_num INT NOT NULL )

 

CREATE TABLE if not exists `oneminute` (
  `tradingday` date NOT NULL,
  `updatetime` time NOT NULL,
  `instrumentid` varchar(31) NOT NULL,
  `open` double NOT NULL,
  `high` double NOT NULL,
  `low` double NOT NULL,
  `close` double NOT NULL,
  `volume` int(11) NOT NULL,
  `openint` int(11) NOT NULL,
  PRIMARY KEY (`instrumentid`,`tradingday`,`updatetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

 
// 20150420 
select instrumentid,updatetime ||":"|| updatemillisec,volume from mktinfo where tradingday=20150416 order by instrumentid,seq_num
select instrumentid,updatetime,updatemillisec,volume from mktinfo where tradingday=20150416 order by instrumentid,seq_num
 
CREATE TABLE if not exists contracts (
 instrumentid TEXT NOT NULL,
 min_date INT,
 max_date INT,
 cnt INT,
 manual_flag INT NOT NULL, 
 update_time INT NOT NULL,
 PRIMARY KEY (instrumentid)
) 

insert into contracts
select instrumentid,min(tradingday) as min, max(tradingday) as max, count(*),0,datetime() from mktinfo
where
( LastPrice <= upperlimitprice and
LastPrice >= lowerlimitprice )
and
(
substr(updatetime,1,5) <= "02:30" or
(substr(updatetime,1,5) >= "09:00" and substr(updatetime,1,5) <= "15:15") or
substr(updatetime,1,5) >= "21:00"
)
group by instrumentid
 
 
// 20150422
1) mngmnt
valid
contracts

insert into contracts
select instrumentid,min(tradingday) as min, max(tradingday) as max, count(*),0,datetime() from mktinfo
where
LastPrice <= upperlimitprice and
LastPrice >= lowerlimitprice and
(
substr(updatetime,1,5) <= "02:30" or
(substr(updatetime,1,5) >= "08:55" and substr(updatetime,1,5) <= "15:15") or
substr(updatetime,1,5) >= "20:55"
)
group by instrumentid
 
// 20150423
CREATE TABLE if not exists `oneminute` (
)

// 20150424
// mysql
CREATE TABLE `oneminute` (
  `tradingday` date NOT NULL,
  `updatetime` time NOT NULL,
  `instrumentid` varchar(31) NOT NULL,
  `open` double NOT NULL,
  `high` double NOT NULL,
  `low` double NOT NULL,
  `close` double NOT NULL,
  `volume` int(11) NOT NULL,
  `openint` int(11) NOT NULL,
  PRIMARY KEY (`instrumentid`,`tradingday`,`updatetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

// 20150428
CREATE TABLE IF NOT EXISTS daily (
 tradingday INT NOT NULL,
 instrumentid TEXT NOT NULL,
 open DOUBLE NOT NULL,
 high DOUBLE NOT NULL,
 low DOUBLE NOT NULL,
 close DOUBLE NOT NULL,
 volume INT NOT NULL,
 openint INT NOT NULL,
 PRIMARY KEY (tradingday, instrumentid)
)

// 20150825
CREATE TABLE IF NOT EXISTS daily (
 tradingday INT NOT NULL,
 instrumentid TEXT NOT NULL,
 open DOUBLE ,
 high DOUBLE ,
 low DOUBLE ,
 close DOUBLE NOT NULL,
 settlementprice DOUBLE NOT NULL,
 volume INT NOT NULL,
 openint INT NOT NULL,
 amount DOUBLE NOT NULL,
 presettlementprice double,
 precloseprice double,
 PRIMARY KEY (tradingday, instrumentid)
)
// 20150430
建表
oneminute
exchanges
sectors
contracts
tradingday
mktvital
realizedcorr

 

daily
quasi_daily
main_contracts

 
// 20150508
select count(*) from contracts where "00" = substr(instrumentid,length(instrumentid)-1)
select distinct instrumentid from contracts where "00" = substr(instrumentid,length(instrumentid)-1)
select instrumentid,count(*) as cnt from oneminute where
instrumentid in (select distinct instrumentid from contracts where "00" = substr(instrumentid,length(instrumentid)-1)) 
group by instrumentid
order by cnt DESC

select * from sectors where 'ZJ' = exchange
AU30,AU31,AU32,AU33,AU34,AU35  #227@1min
select instrumentid,count(*) from oneminute where instrumentid in
(select instrumentid from contracts where 'AU' = substr(instrumentid,1,2) and cast(substr(instrumentid,3,2) as integer) > 13)
group by instrumentid

select distinct substr(instrumentid,3,2) as ss from contracts where cast(ss as integer) > 13
select instrumentid from contracts where cast(substr(instrumentid,3,2) as integer) > 13

// continuous
select instrumentid,count(*) as cnt from oneminute
where
updatetime >= 130000 and updatetime <= 190000 and '00' = substr(instrumentid,length(instrumentid)-1,2)
group by instrumentid  order by cnt DESC

select count(*) from (
select instrumentid,count(*) as cnt from oneminute
where
updatetime >= 130000 and updatetime <= 190000 and '00' = substr(instrumentid,length(instrumentid)-1,2)
group by instrumentid  order by cnt DESC
)

select instrumentid, count(*) as cnt from oneminute
where
tradingday = 20150511 and substr(updatetime,1,4) != "1530" and
updatetime >= 130000 and updatetime <= 190000 and '00' = substr(instrumentid,length(instrumentid)-1,2)
group by instrumentid having cnt >= 226 order by cnt DESC

insert into continuous
select instrumentid from oneminute
where
tradingday = 20150511 and substr(updatetime,1,4) != "1530" and
updatetime >= 130000 and updatetime <= 190000 and '00' = substr(instrumentid,length(instrumentid)-1,2)
group by instrumentid  having count(*) >= 220 

 

insert or ignore into continuous
select instrumentid from oneminute
where
tradingday = 20150511 and '00' = substr(instrumentid,length(instrumentid)-1,2)
group by instrumentid

select substr(updatetime,1,4) as dt from oneminute where
instrumentid = "AU30" and dt not in (
select substr(updatetime,1,4) as dd from oneminute where instrumentid = "AU32"
);

// continuous
select instrumentid,count(*) as cnt from oneminute
where
updatetime > 130000 and updatetime < 190000 and substr(updatetime,1,4) != "1530" and
substr(instrumentid,1,2) = "AU" and '13' < substr(instrumentid,length(instrumentid)-1,2)
group by instrumentid  order by cnt DESC

insert into continuous
select instrumentid from oneminute
where
updatetime > 130000 and updatetime < 190000 and substr(updatetime,1,4) != "1530" and
substr(instrumentid,1,2) = "AU" and '13' < substr(instrumentid,length(instrumentid)-1,2)
group by instrumentid 

x = np.array([1,2,4,7,0])
np.diff(x)
sum(x)

// 20150512
// mktvital
CREATE TABLE IF NOT EXISTS mktvital (
)

CREATE TABLE IF NOT EXISTS realizedcorr (
)


select distinct substr(updatetime,1,4) from oneminute where instrumentid in
(select * from continuous) and tradingday = 20150511 and
updatetime >130000 and updatetime < 190000

select close,volume,amount,openint from oneminute where
tradingday = ? and
instrumentid = ? and updatetime > 130000 and updatetime < 190000 and substr(updatetime,1,4) != "1530"
order by updatetime ASC;

// 20150515
// aggregate min
CREATE TEMP TABLE if not exists `minutes` (
  `tradingday` INT NOT NULL,
  `updatetime` text NOT NULL,
  `instrumentid` text NOT NULL,
  `open` double NOT NULL,
  `high` double NOT NULL,
  `low` double NOT NULL,
  `close` double NOT NULL,
  `volume` int NOT NULL,
  `openint` int NOT NULL,
  PRIMARY KEY (`instrumentid`,`tradingday`,`updatetime`)
)

insert into temp.minutes (updatetime,open,high,low,close,volume,openint) 
SELECT updatetime,open,high,low,close,volume,openint from oneminute
where tradingday =  and instrumentid =
// 20150518 continue:
// consistency checking:
select count(*) from oneminute where high < close or high < open or low > close or low >close or low > high ;
// general stat
select tradingday, count(*) from oneminute group by tradingday;
select * from (select distinct cast(substr(updatetime,1,length(updatetime)-2) as integer) as dt from oneminute order by dt );
select distinct cast(substr(updatetime,1,length(updatetime)-2) as integer) as dt from oneminute
where instrumentid NOT in (
select distinct instrumentid from contracts where sector in (select distinct sector from sectors where exchange = "ZJ")
) order by dt ASC
// time interval, CEFFEX excluded, 560 all together:
[100,630]
[1300,1415]
[1430,1530]
[1730,1901]
// 1901: DCE + invalid openint
select * from oneminute where substr(updatetime,1,length(updatetime)-2) = "1901" ;
tradingday  updatetime  instrumentid  open        high        low         close       volume      amount      openint  
----------  ----------  ------------  ----------  ----------  ----------  ----------  ----------  ----------  ----------
20150515    190136      BB05          85.0        85.0        85.0        85.0        64          272         0        
20150515    190136      I05           480.0       480.0       480.0       480.0       862         4077        0        
20150515    190136      J05           835.0       835.0       835.0       835.0       602         4886        0        
20150515    190136      L05           10090.0     10090.0     10090.0     10090.0     2920        15655       0        
20150515    190136      P05           5456.0      5456.0      5456.0      5456.0      84          447         0        
20150515    190136      PP05          9100.0      9100.0      9100.0      9100.0      348         1627        0     

http://log4cplus.sourceforge.net/docs/html/classlog4cplus_1_1thread_1_1AbstractThread.html#a37650cc367951e2c424254f3968f8349
http://log4cplus.sourceforge.net/docs/html/globals.html
http://honey-bee.iteye.com/blog/65805
http://www.tuicool.com/articles/yaMfey
http://everet.org/emacs-tips-for-python-programmer.html
http://aifreedom.com/technology/112
http://www.metatrader5.com/en/terminal/help/analytics/indicators/trend_indicators/dema
http://www.ta-lib.org/hdr_dw.html

www.metastock.com/Customer/Resources/TAAZ/Default.aspx?p=74
http://www.ta-lib.org/function.html
http://mrjbq7.github.io/ta-lib/func_groups/overlap_studies.html
http://www.quantshare.com/index.php?option=manual&dir=/QuantShare%20Language/Indicators/Ht_Trendline%200.html
https://www.linnsoft.com/techind/mesa-adaptive-moving-average-mama
http://www.tradeforextrading.com/index.php/mesa-adaptive-average
http://gbeced.github.io/pyalgotrade/docs/v0.16/html/sample_bbands.html
http://gbeced.github.io/pyalgotrade/docs/v0.16/html/talib.html

http://218.244.141.201:8080/
http://shop116202631.taobao.com/search.htm?spm=a1z10.1-c.0.0.mNpo6v&search=y&orderType=hotsell_desc
file:///D:/Documents/Downloads/CTP/tomas_ctp_manual_6_2_5_20140811_linux64%20-%20%E5%89%AF%E6%9C%AC.html
http://stackoverflow.com/questions/3136919/c-state-design-pattern-with-multiple-state-machines?rq=1
http://quantlib.org/qlws14.shtml
https://code.google.com/p/hudson/
http://stackoverflow.com/questions/1647631/c-state-machine-design
http://stackoverflow.com/questions/133214/is-there-a-typical-state-machine-implementation-pattern?lq=1
http://stackoverflow.com/questions/2705173/designing-a-state-machine-in-c?rq=1
http://qhkh.cofool.com/news/index.shtml
http://qhziguan.lhtz.com/
http://qhsz.qhrb.com.cn/


http://taiyun.github.io/blog/2012/07/k-means/
http://taiyun.github.io/blog/2012/07/brownian-motion/


// 20150521
select count(*) from mktvital where 0.0001 >= (efficiency+volatility+hot)

create temp table tmp (instrumentid text);

insert into tmp
select instrumentid from oneminute
where
tradingday = 20150518 and updatetime > 132000 and
updatetime <= 185000 and "00" = substr(instrumentid,length(instrumentid)-1,2)
group by instrumentid having count(*) >= 194;


select tradingtime from tradingtime 
where
tradingtime > 1320 and tradingtime <= 1850 and tradingtime not in (
select substr(updatetime,1,length(updatetime)-2) from oneminute where
tradingday = 20150518 and instrumentid in 

select distinct instrumentid1 from realizedcorr where date = 20150522 union select distinct instrumentid2 from realizedcorr where date = 20150522 

// check whether successful insertion
select tradingday, count(*) as cnt from oneminute group by tradingday;
select date,count(*) from mktvital group by date;
select * from mktvital where date = 20150824 order by hot desc;
select * from mktvital where date = 20150824 order by volatility desc;
select * from mktvital where date = 20150824 order by efficiency desc;
select date,count(*) from realizedcorr group by date;
## select * from realizedcorr where date = 201507;
select max(corr),min(corr) from realizedcorr where date = 20150824;


print tradesAnalyzer.getAll()
print tradesAnalyzer.getAllReturns()
print tradesAnalyzer.getCommissionsForAllTrades()
print tradesAnalyzer.getCommissionsForEvenTrades()
print tradesAnalyzer.getCommissionsForProfitableTrades()
print tradesAnalyzer.getCommissionsForUnprofitableTrades()
print tradesAnalyzer.getCount()
print tradesAnalyzer.getEvenCount()
print tradesAnalyzer.getLosses()
print tradesAnalyzer.getNegativeReturns()
print tradesAnalyzer.getPositiveReturns()
print tradesAnalyzer.getProfitableCount()
print tradesAnalyzer.getProfits()
print tradesAnalyzer.getUnprofitableCount()


// 20151012
// peak into far month or inactive contracts
select instrumentid,volume,openint from day
where tradingday == 20151009 and
round(substr(instrumentid,length(instrumentid)-1,2), 0) between 1 and 12
order by substr(instrumentid,1,length(instrumentid)-2), volume DESC

select * from summary
where tradingday == 20151009 and
round(substr(instrumentid,length(instrumentid)-1,2), 0) between 1 and 12
order by substr(instrumentid,1,length(instrumentid)-2), jump

create table subsectors (type TEXT NOT NULL, sector TEXT NOT NULL, PRIMARY KEY (sector));
.import input.txt subsectors
// liquidity
// sgnvol占全部成交量的几成?
select instrumentid, round((sum(sgnvol)+0.001)/(sum(volume)+0.001), 2) from oneminute where tradingday == 20151009 group by instrumentid order by instrumentid

// 20151013
SELECT
tradingday,instrumentid,open,high,low,close,volume,openint,amount
 FROM day where tradingday = 20151012 and instrumentid in
 (select instrumentid from contracts c join subsectors s on c.sector=s.sector where s.type="none")
and round(substr(instrumentid,length(instrumentid)-1,2), 0) between 1 and 12 
order by substr(instrumentid,1,length(instrumentid)-2),volume DESC;

select * from summary where tradingday = 20151012 and instrumentid in (select instrumentid from contracts where sector = 'CU'); 

// ZQ和AU30之后都是有问题的 
select * from oneminute where
(openint - (openint/2)*2) != 0
and instrumentid not in (select instrumentid from contracts c join sectors s on c.sector==s.sector where s.exchange == "ZJ")

// 修正openint,涉及: summary day@oenminute,diff ticks @ticks
-- preexempt
-- select distinct s.sector a,s.exchange b  from contracts c join sectors s on c.sector == s.sector where s.exchange != "ZJ" order by b,a;
update oneminute set openint = openint/2 where instrumentid in (select instrumentid from contracts where sector in (select sector from sectors where exchange != "ZJ"));
SELECT
tradingday,instrumentid,open,high,low,close,volume,openint,amount
 FROM day
where instrumentid in (select instrumentid from contracts where sector in (select sector from sectors where exchange != "ZJ")) limit 39;
update day set openint = openint/2 where instrumentid in (select instrumentid from contracts where sector in (select sector from sectors where exchange != "ZJ"));
 
流动性:意义:{交易成本,市场情绪及事件冲击}
核心：不仅仅要展示模拟的业绩，更要说明其逻辑。
而当下太多都是没有逻辑在里面,或者只有”经验性的逻辑“
个人希望，找到大多数行情下大致成立的基本逻辑,目前看流动性是一个备选
另一方面，我暂时不用技术分析，因只是"知其然，而不知其所以然"

假象如下的场景：
行情突然变化，某人在主力合约上无法及时止损，但是如果此时提示次主力合约流动性还好，则它可以马上在次主力合约上下市价单，相对的锁住主力合约的亏损，相当于止损。
如果他在主力合约止损，可能付出较大滑点，但是如果我们帮他实现确定好次主力合约的流动性还可以，则就节约了滑点的手续费，这笔钱钱不小的

// 20151014
// tradingday sector non13
select * from summary where
tradingday == 20151013
and instrumentid in
(select instrumentid from contracts where sector in ('T','TF'))
and round(substr(instrumentid,length(instrumentid)-1,2), 0) between 1 and 12

select name,tbl_name,sql from sqlite_master where type='table';

// 20151015
// jumpPositive
select * from summary where tradingday == 20151015 and
substr(instrumentid,length(instrumentid)-1,2) between "00" and "12" and
(jump < -2 or jump > 2) order by instrumentid;

// 20151016
create table subsectors (type TEXT NOT NULL, sector TEXT NOT NULL,PRIMARY KEY(type,sector));
insert into subsectors select * from subsectors_0;

// subsectors
select * from summary where tradingday == 20151015 and
substr(instrumentid,length(instrumentid)-1,2) between "00" and "12" and
-- (jump < -2 or jump > 2) and
instrumentid in (
select instrumentid from contracts where sector in (
select s.sector from sectors s join subsectors ss on s.sector == ss.sector where ss.type == "soft"))
 order by substr(instrumentid,1,length(instrumentid)-2), jump;

 

CREATE temporary TABLE sectors_0 (
 id INT ,
 sector TEXT NOT NULL,
 name TEXT,
 min_date INT,
 max_date INT,
 exchange TEXT NOT NULL,
 manual_flag INT NOT NULL, 
 update_time INT NOT NULL, mintick INT, multiplier INT, cnt_min INT,
 PRIMARY KEY (sector,exchange)
);
insert into sectors_0 select * from sectors;
select * from sectors_0;
drop table sectors;
CREATE TABLE sectors (
 id INT ,
 sector TEXT NOT NULL,
 name TEXT,
 min_date INT,
 max_date INT,
 exchange TEXT NOT NULL,
 manual_flag INT NOT NULL, 
 update_time INT NOT NULL, mintick INT, multiplier INT, cnt_min INT,
 PRIMARY KEY (sector,exchange)
);
insert into sectors (
sector,exchange,manual_flag,update_time,mintick, multiplier, cnt_min)
select
sector,exchange,manual_flag,update_time,multiplier, mintick, cnt_min
from sectors_0;

// subsectors
select
s.sector, s.exchange, s.mintick, s.multiplier, s.cnt_min
from sectors s join subsectors ss on s.sector == ss.sector
where ss.type == "precious";

// filter: #bars volume
// table@day can be omitted
select
d.instrumentid, round((count(*)+0.0000001)/(s.cnt_min+0.0000001), 3) as rt, d.volume
from oneminute o, contracts c, sectors s, day d
where
o.instrumentid == c.instrumentid and c.sector == s.sector and o.instrumentid == d.instrumentid and o.tradingday == d.tradingday
and substr(d.instrumentid,length(d.instrumentid)-1, 2) between "0" and "12"
and o.tradingday == 20151016
-- and s.sector == "CU"
and d.volume >= s.cnt_min*5
-- and rt >= 0.5
group by o.instrumentid
having rt >= 0.5
order by rt DESC;

// 3 tables join
select instrumentid from contracts c join sectors s on c.sector == s.sector join subsectors su on s.sector == su.sector where su.type='soft'

// complex
select * from summary where
tradingday == 20151016
and (jump <-2 or jump >2)
and eff > 0
and instrumentid in
(select
distinct d.instrumentid
from oneminute o, contracts c, sectors s, day d,subsectors su
where
o.instrumentid == c.instrumentid and c.sector == s.sector and o.instrumentid == d.instrumentid and o.tradingday == d.tradingday
and substr(d.instrumentid,length(d.instrumentid)-1, 2) between "0" and "12"
and o.tradingday == 20151016
and d.volume >= s.cnt_min*5
and s.sector == su.sector and su.type='soft'
group by o.instrumentid
having round((count(*)+0.0000001)/(s.cnt_min+0.0000001), 3) >= 0.5 )
order by substr(instrumentid,1,length(instrumentid)-2), jump;




