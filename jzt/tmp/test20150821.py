# -*- coding: utf-8 -*-
# sqlite jzt_onemin_oop edition

import sqlite3

sqlpath="D:\\bin\\pyproject\\ctpdata\\db\\jzt_onemin_oop.db"
try:
    con=sqlite3.connect(sqlpath)
except sqlite3.Error as err:
    print "failed"
print "suc"    
cur = con.cursor()

sqls = """
select lastprice,volume,turnover,openinterest,bidprice1,bidvolume1,askprice1,askvolume1,averageprice from  mktinfo where instrumentid='m1509' order by updatetime,updatemillisec;
"""

cur.execute()
tmp = cur.fetchall()
if (tmp is None):
    print "failed to fetch\n"
print "sec"

