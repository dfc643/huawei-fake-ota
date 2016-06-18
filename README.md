Fake Huawei OTA Server
======

A fake server program of Huawei android phone OTA service. Using fake OTA server is more eaiser to create and push a new version OS to Huawei androd phone.

Fake Huawei OTA server allowed user push a custom or official to any Huawei Android phone. With use of ```huawei-firmware-scanner``` can push unpublished official firmware to Huawei Android phone.

How to use it?
-----

1. Rename and copy Huawei device firmware to Fake OTA program *root directory* with name ```update.zip```.  
2. Double click on ```Start-OTA.bat``` to start Fake OTA program.  
3. Following the Fake OTA program's guide to build a firmware information.  
4. Confirm and start NGINX and DNS server by Fake OTA program.  
5. Modify Huawei Android phone DNS server to Fake OTA server's IP address.  
6. Checking update on Huawei Android phone and update.

More usage information please look at: [Huawei Funs Club Post](http://club.huawei.com/forum.php?mod=viewthread&tid=8759311)<small>Chinese</small>.

License
-----

### NGINX ###

```
/* 
 * Copyright (C) 2002-2016 Igor Sysoev
 * Copyright (C) 2011-2016 Nginx, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */
```

###DNSAgent###

```
The MIT License (MIT)

Copyright (c) 2015 Stackie Jia

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

Copyright
-----

- *[NGINX](https://github.com/nginx/nginx):* [NGINX License](http://nginx.org/LICENSE)  
- *[DNSAgent](https://github.com/stackia/DNSAgent):* MIT License  
- *iconv&sed:* GNU License  