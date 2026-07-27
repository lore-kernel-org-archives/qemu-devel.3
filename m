Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D89C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 09:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woHXF-0006wO-IX; Mon, 27 Jul 2026 05:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangziliang@kylinos.cn>)
 id 1woHXB-0006vX-Ag
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:22:05 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangziliang@kylinos.cn>)
 id 1woHX7-0001Y5-L9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 05:22:05 -0400
X-UUID: 9546c842899c11f1aa26b74ffac11d73-20260727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:21382fb2-490f-456d-bd63-ef48a35baf0f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:6a6b62b51c0fae26a721ae022fddc9c6,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:0,Content:0|14|50,EDM:-3,
 IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
 0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: E7BF2D468FFBFBF43547D5C29CF5D901
X-UUID: 9546c842899c11f1aa26b74ffac11d73-20260727
Received: from node4 [(10.44.17.112)] by mailgw.kylinos.cn
 (envelope-from <wangziliang@kylinos.cn>) (Generic MTA)
 with ESMTP id 618715573; Mon, 27 Jul 2026 17:21:43 +0800
Received: from node4 (localhost [127.0.0.1])
 by node4 (NSMail) with SMTP id 9D1CF1200BD92;
 Mon, 27 Jul 2026 17:21:43 +0800 (CST)
Received: by node4 (NSMail, from userid 10001)
 id 904971200BD8A; Mon, 27 Jul 2026 17:21:42 +0800 (CST)
From: =?UTF-8?B?546L5a2Q5Lqu?= <wangziliang@kylinos.cn>
Subject: =?UTF-8?B?W1BBVENIXSB0YXJnZXQvaTM4NjogaGVscGVyX3dybXNyKCkvaGVscGVyX3JkbXNyKCk6IFJhaXNlICNHUCgwKSB3aGVuIGFjY2Vzc2luZyB1bmltcGxlbWVudGVkIE1TUnM=?=
To: =?UTF-8?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?cGJvbnppbmk=?= <pbonzini@redhat.com>,
 =?UTF-8?B?cmljaGFyZC5oZW5kZXJzb24=?= <richard.henderson@linaro.org>,
 =?UTF-8?B?YXBvbGl2b2RhYTQzMw==?= <apolivodaa433@gmail.com>
Date: Mon, 27 Jul 2026 17:21:42 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <29ssjbog97r1-29sxuql0yttq@nsmail8.2--kylin--1>
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Mon, 27 Jul 2026 17:21:42 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-2c6hhqongdj4-2c6le40jfyip
X-ns-mid: webmail-6a672326-2aip5ce5
X-ope-from: <wangziliang@kylinos.cn>
X-receipt: 0
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=wangziliang@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This message is in MIME format.

--nsmail-2c6hhqongdj4-2c6le40jfyip
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+QWNjb3JkaW5nIHRvIGludGVsIFNETSBhbmQgQU1EIG1hbnVh
bCwgUkRNU1IgYW5kIFdSTVNSIGluc3RydWN0aW9ucyBzaG91bGQ8YnI+cmFp
c2UgI0dQKDApIGV4Y2VwdGlvbiBpZiBhIHJlc2VydmVkIG9yIHVuaW1wbGVt
ZW50ZWQgTVNSIGlzIHNwZWNpZmllZCBpbiBFQ1guPC9wPgo8cD5DdXJyZW50
bHksIGJvdGggaGVscGVyX3JkbXNyIGFuZCBoZWxwZXJfd3Jtc3IgZnVuY3Rp
b25zIHNpbXBseSBpZ25vcmU8YnI+dW5pbXBsZW1lbnRlZCBNU1JzLCBzbyB0
aGUgYmVoYXZpb3Igb2YgdGhlc2UgZnVuY3Rpb25zPGJyPm5lZWRzIHRvIGJl
IG1vZGlmaWVkIGluIHN1Y2ggY2FzZXMuPC9wPgo8cD5DYzogcWVtdS1kZXZl
bEBub25nbnUub3JnPGJyPkNjOiBQYW9sbyBCb256aW5pICZsdDtwYm9uemlu
aUByZWRoYXQuY29tJmd0Ozxicj5DYzogUmljaGFyZCBIZW5kZXJzb24gJmx0
O3JpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcmZ3Q7PGJyPkNjOiBBbmRy
ZXkgUG9saXZvZGEgJmx0O2Fwb2xpdm9kYWE0MzNAZ21haWwuY29tJmd0Ozxi
cj5GaXhlczogM2MxY2Y5ZmEgKCJkdW1teSByZG1zciBhbmQgd3Jtc3Igc3Vw
cG9ydCAtIHhvciByZWcsIHJlZyBvcHRpbWl6YXRpb24iKTxicj5SZXNvbHZl
czogPGEgaHJlZj0iaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9x
ZW11Ly0vd29ya19pdGVtcy8zMjE4Ij5odHRwczovL2dpdGxhYi5jb20vcWVt
dS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzMyMTg8L2E+PGJyPlNpZ25l
ZC1vZmYtYnk6IFdhbmcgWmlsaWFuZyAmbHQ7d2FuZ3ppbGlhbmdAa3lsaW5v
cy5jbiZndDs8YnI+LS0tPGJyPnRhcmdldC9pMzg2L3RjZy9zeXN0ZW0vbWlz
Y19oZWxwZXIuYyB8IDExICsrKysrKy0tLS0tPGJyPjEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pPC9wPgo8cD5kaWZm
IC0tZ2l0IGEvdGFyZ2V0L2kzODYvdGNnL3N5c3RlbS9taXNjX2hlbHBlci5j
IGIvdGFyZ2V0L2kzODYvdGNnL3N5c3RlbS9taXNjX2hlbHBlci5jPGJyPmlu
ZGV4IDI5OThiMWFhZTcuLjlhYzVlMTY3Y2MgMTAwNjQ0PGJyPi0tLSBhL3Rh
cmdldC9pMzg2L3RjZy9zeXN0ZW0vbWlzY19oZWxwZXIuYzxicj4rKysgYi90
YXJnZXQvaTM4Ni90Y2cvc3lzdGVtL21pc2NfaGVscGVyLmM8YnI+QEAgLTMw
OSw2ICszMDksNyBAQCB2b2lkIGhlbHBlcl93cm1zcihDUFVYODZTdGF0ZSAq
ZW52KTxicj5icmVhazs8YnI+fTxicj5kZWZhdWx0Ojxicj4rIC8qIE1hY2hp
bmUgQ2hlY2sgTVNScyAqLzxicj5pZiAoKHVpbnQzMl90KWVudi0mZ3Q7cmVn
c1tSX0VDWF0gJmd0Oz0gTVNSX01DMF9DVEw8YnI+JmFtcDsmYW1wOyAodWlu
dDMyX3QpZW52LSZndDtyZWdzW1JfRUNYXSAmbHQ7IE1TUl9NQzBfQ1RMICs8
YnI+KDQgKiBlbnYtJmd0O21jZ19jYXAgJmFtcDsgMHhmZikpIHs8YnI+QEAg
LTMxOSw4ICszMjAsOCBAQCB2b2lkIGhlbHBlcl93cm1zcihDUFVYODZTdGF0
ZSAqZW52KTxicj59PGJyPmJyZWFrOzxicj59PGJyPi0gLyogWFhYOiBleGNl
cHRpb24/ICovPGJyPi0gYnJlYWs7PGJyPisgLyogVW5pbXBsZW1lbnRlZCBN
U1JzICovPGJyPisgZ290byBlcnJvcjs8YnI+fTxicj5yZXR1cm47PGJyPmVy
cm9yOjxicj5AQCAtNDg3LDYgKzQ4OCw3IEBAIHZvaWQgaGVscGVyX3JkbXNy
KENQVVg4NlN0YXRlICplbnYpPGJyPmJyZWFrOzxicj59PGJyPmRlZmF1bHQ6
PGJyPisgLyogTWFjaGluZSBDaGVjayBNU1JzICovPGJyPmlmICgodWludDMy
X3QpZW52LSZndDtyZWdzW1JfRUNYXSAmZ3Q7PSBNU1JfTUMwX0NUTDxicj4m
YW1wOyZhbXA7ICh1aW50MzJfdCllbnYtJmd0O3JlZ3NbUl9FQ1hdICZsdDsg
TVNSX01DMF9DVEwgKzxicj4oNCAqIGVudi0mZ3Q7bWNnX2NhcCAmYW1wOyAw
eGZmKSkgezxicj5AQCAtNDk0LDkgKzQ5Niw4IEBAIHZvaWQgaGVscGVyX3Jk
bXNyKENQVVg4NlN0YXRlICplbnYpPGJyPnZhbCA9IGVudi0mZ3Q7bWNlX2Jh
bmtzW29mZnNldF07PGJyPmJyZWFrOzxicj59PGJyPi0gLyogWFhYOiBleGNl
cHRpb24/ICovPGJyPi0gdmFsID0gMDs8YnI+LSBicmVhazs8YnI+KyAvKiBV
bmltcGxlbWVudGVkIE1TUnMgKi88YnI+KyByYWlzZV9leGNlcHRpb25fZXJy
X3JhKGVudiwgRVhDUDBEX0dQRiwgMCwgR0VUUEMoKSk7PGJyPn08YnI+ZW52
LSZndDtyZWdzW1JfRUFYXSA9ICh1aW50MzJfdCkodmFsKTs8YnI+ZW52LSZn
dDtyZWdzW1JfRURYXSA9ICh1aW50MzJfdCkodmFsICZndDsmZ3Q7IDMyKTs8
YnI+LS0gPGJyPjIuNDMuMDwvcD48L2Rpdj4=

--nsmail-2c6hhqongdj4-2c6le40jfyip--

