# -*- coding: utf-8 -*-
# sqlite tick edition

import sqlite3

sqlpath="D:\\bin\\pyproject\\ctpdata\\ctp_20150709.db"
try:
    con=sqlite3.connect(sqlpath)
except sqlite3.Error as err:
    print "failed"
print "suc"    
cur = con.cursor()
cur.execute("select lastprice,volume,turnover,openinterest,bidprice1,bidvolume1,askprice1,askvolume1,averageprice from  mktinfo where instrumentid='m1509' order by updatetime,updatemillisec;")
tmp = cur.fetchall()
if (tmp is None):
    print "failed to fetch\n"
print "sec"

