Fake Huawei OTA (Server side)
======

Fake Huawei OTA server side script running on PHP, can provide cloud update service for Huawei Android phone users.

How to use it?
-----

1. Create a link for file ```/HwOUC/Check.php``` to ```/sp_ard_common/v2/Check.action```.
2. Register ```.action``` as PHP script on web engine.
3. Modify firmware information in ```/HwOUC/Check.php```.
4. Create a DNS resolve ```query.hicloud.com``` to your server address.
5. Modify phone DNS to your DNS server and check update.

More usage information please look at: [Huawei FunsClub](http://club.huawei.com/thread-8914406-1-1.html) .