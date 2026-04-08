Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA40610F9968
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYdQ-0002mH-EU; Wed, 08 Apr 2026 15:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1wAYGg-0004Ei-GE
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:08:50 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yujun@kylinos.cn>) id 1wAMS5-0002ZA-7m
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 02:31:52 -0400
X-UUID: 9834d5fa331411f1aa26b74ffac11d73-20260408
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:7b6c9b8d-21b6-40f6-b3c5-a3ff8499e1b5, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:e7bac3a, CLOUDID:40ac6daea920a4dc817f4b2b1d35040b,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102|898,TC:0,Content:0|14|51,EDM:-
 3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
 V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: 2B06F67595C4F84CB91B9E00163EECF9
X-UUID: 9834d5fa331411f1aa26b74ffac11d73-20260408
Received: from node4 [(10.44.17.112)] by mailgw.kylinos.cn
 (envelope-from <yujun@kylinos.cn>) (Generic MTA)
 with ESMTP id 1654394404; Wed, 08 Apr 2026 14:31:37 +0800
Received: from node4 (localhost [127.0.0.1])
 by node4 (NSMail) with SMTP id 0C7C91200BD8D;
 Wed,  8 Apr 2026 14:31:37 +0800 (CST)
Received: by node4 (NSMail, from userid 10001)
 id 01AB21200BD8C; Wed,  8 Apr 2026 14:31:35 +0800 (CST)
From: =?UTF-8?B?5Za75Yab?= <yujun@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIXSBhdWRpby9waXBld2lyZTogRml4IHN0YWNrIG92ZXJmbG93IGJ5IG1vdmluZyBidWZmZXIgdG8gaGVhcA==?=
To: =?UTF-8?B?bWFyY2FuZHJlLmx1cmVhdQ==?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?b2Rha2k=?= <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?B?VGhvbWFzIEh1dGg=?= <thuth@redhat.com>
Cc: =?UTF-8?B?bWFyay5jYXZlYXlsYW5k?= <mark.caveayland@nutanix.com>,
 =?UTF-8?B?cGhpbG1k?= <philmd@linaro.org>,
 =?UTF-8?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>
Date: Wed, 08 Apr 2026 14:31:35 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <a1npd7r5807-a1so0q5obt4@nsmail8.2--kylin--1>
References: 7c4c01de-475c-4864-9dc4-743bf8d10247@redhat.com
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Wed, 08 Apr 2026 14:31:35 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-cdbn14l3tu2-cdetvo4qea3
X-ns-mid: webmail-69d5f647-ap1kl5ig
X-ope-from: <yujun@kylinos.cn>
X-receipt: 0
Received-SPF: pass client-ip=124.126.103.232; envelope-from=yujun@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, HTML_OBFUSCATE_05_10=0.26, MIME_HTML_ONLY=0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 Apr 2026 15:32:16 -0400
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

--nsmail-cdbn14l3tu2-cdetvo4qea3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+Jm5ic3A7PC9wPgo8cD5Iae+8jFRob21hc++8mjwvcD4KPHA+
VGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLjwvcD4KPHA+SnVz
dCB1c2luZyBBSSB0byBkZXNjcmliZSBpdCwgeW91IGtub3csIG15IEVuZ2xp
c2ggaXMgbm90IHZlcnkgZ29vZC48L3A+CjxwPkkgYW0gY3VycmVudGx5IHBy
dW5pbmcgYW5kIG9wdGltaXppbmcgcWVtdSB3aXRoIHRoZSBhaW0gb2YgcmVk
dWNpbmcgaXRzIG1lbW9yeSB1c2FnZS4gSSBoYXBwZW5lZCB0byBkaXNjb3Zl
ciB0aGUgbGFyZ2UgbWVtb3J5IGFsbG9jYXRpb24gb2YgdGhpcyBzdGFjayBh
bmQgYW0gdHJ5aW5nIHRvIHByb3Bvc2UgYSBuZXcgc29sdXRpb24uPC9wPgo8
cD5pdCByZWFsbHkgaXMgdGhhdCBzaW1wbGUuPC9wPgo8cD4mbmJzcDs8L3A+
CjxwPkp1biBZdTwvcD4KPGRpdiBpZD0ic2lnbmF0dXJlVG9wIj48L2Rpdj4K
PGRpdiBpZD0iY3MyY19yZSIgc3R5bGU9Im1hcmdpbi1sZWZ0OiAwLjVlbTsg
cGFkZGluZy1sZWZ0OiAwLjVlbTsgYm9yZGVyLWxlZnQ6IDFweCBzb2xpZCAj
Y2FjYWNhOyAtd2Via2l0LXVzZXItbW9kaWZ5OiByZWFkLW9ubHk7IC1tb3ot
dXNlci1tb2RpZnk6IHJlYWQtb25seTsgLW1zLXVzZXItbW9kaWZ5OiByZWFk
LW9ubHk7IC1vLXVzZXItbW9kaWZ5OiByZWFkLW9ubHk7Ij48YnI+PGJyPjxi
cj4KPGRpdiBzdHlsZT0iYmFja2dyb3VuZC1jb2xvcjogI2Y4ZjhmODsgcGFk
ZGluZzogOHB4IDEwcHg7IGZvbnQtZmFtaWx5OiBNaWNyb3NvZnQgWWFIZWk7
IGZvbnQtc2l6ZTogMTRweDsgY29sb3I6ICMwMDA7Ij48c3Ryb25nPuS4uyZu
YnNwOyZuYnNwOyZuYnNwO+mimO+8mjwvc3Ryb25nPjxzcGFuIGlkPSJjczJj
X3N1YmplY3QiPlJlOiBbUEFUQ0hdIGF1ZGlvL3BpcGV3aXJlOiBGaXggc3Rh
Y2sgb3ZlcmZsb3cgYnkgbW92aW5nIGJ1ZmZlciB0byBoZWFwPC9zcGFuPiA8
YnI+PHN0cm9uZz7ml6UmbmJzcDsmbmJzcDsmbmJzcDvmnJ/vvJo8L3N0cm9u
Zz48c3BhbiBpZD0iY3MyY19kYXRlIj4yMDI25bm0MDTmnIg45pelMTM6MTU8
L3NwYW4+IDxicj48c3Ryb25nPuWPkeS7tuS6uu+8mjwvc3Ryb25nPjxzcGFu
IGlkPSJjczJjX2Zyb20iPlRob21hcyBIdXRoPC9zcGFuPiA8YnI+PHN0cm9u
Zz7mlLbku7bkurrvvJo8L3N0cm9uZz48c3BhbiBpZD0iY3MyY190byIgc3R5
bGU9IndvcmQtYnJlYWs6IGJyZWFrLWFsbDsiPm1hcmNhbmRyZS5sdXJlYXUs
b2Rha2ksVGhvbWFzIEh1dGg8L3NwYW4+IDxicj48c3Ryb25nPuaKhOmAgeS6
uu+8mjwvc3Ryb25nPjxzcGFuIGlkPSJjczJjX3RvIiBzdHlsZT0id29yZC1i
cmVhazogYnJlYWstYWxsOyI+bWFyay5jYXZlYXlsYW5kLHBoaWxtZCxxZW11
LWRldmVsPC9zcGFuPjwvZGl2Pgo8YnI+CjxkaXYgaWQ9ImNzMmNfY29udGVu
dCI+T24gMDgvMDQvMjAyNiAwMy4yMywgSnVuIFl1IHdyb3RlOiAmZ3Q7IFRo
ZSBQV1ZvaWNlIHN0cnVjdCB3YXMgYWxsb2NhdGluZyBhIGxhcmdlIDRNQiBi
dWZmZXIgb24gdGhlIHN0YWNrIHVzaW5nICZndDsgdWludDhfdCBidWZmZXJb
UklOR0JVRkZFUl9TSVpFXSwgd2hpY2ggY291bGQgY2F1c2Ugc3RhY2sgb3Zl
cmZsb3cuIFdoaWNoIGZ1bmN0aW9uIGlzIHRoaXM/IEkuZS4gd2hlcmUgZG9l
cyB0aGlzIGdldCBjcmVhdGVkIG9uIHRoZSBzdGFjaz8gJmd0OyBUaGlzIGNv
bW1pdDogJmd0OyAxLiBDaGFuZ2VzIHRoZSBidWZmZXIgZnJvbSBzdGFjayBh
bGxvY2F0aW9uIHRvIGhlYXAgYWxsb2NhdGlvbiBieSByZXBsYWNpbmcgJmd0
OyB1aW50OF90IGJ1ZmZlcltSSU5HQlVGRkVSX1NJWkVdIHdpdGggdWludDhf
dCAqYnVmZmVyICZndDsgMi4gQWRkcyBnX21hbGxvYygpIGNhbGxzIGluIHFw
d19pbml0X291dCgpIGFuZCBxcHdfaW5pdF9pbigpIHRvIGFsbG9jYXRlICZn
dDsgdGhlIGJ1ZmZlciBvbiB0aGUgaGVhcCAmZ3Q7IDMuIEFkZHMgZ19mcmVl
KCkgaW4gcXB3X3ZvaWNlX2ZpbmkoKSB0byBwcm9wZXJseSBjbGVhbiB1cCB0
aGUgYnVmZmVyICZndDsgNC4gQWRkcyBlcnJvciBoYW5kbGluZyBmb3IgYWxs
b2NhdGlvbiBmYWlsdXJlcyAmZ3Q7ICZndDsgVGhpcyBmaXggcHJldmVudHMg
c3RhY2sgb3ZlcmZsb3cgd2hpbGUgbWFpbnRhaW5pbmcgdGhlIHNhbWUgZnVu
Y3Rpb25hbGl0eSwgJmd0OyBhcyBlYWNoIGF1ZGlvIHN0cmVhbSAoaW5wdXQv
b3V0cHV0KSBzdGlsbCBnZXRzIGl0cyBvd24gaW5kZXBlbmRlbnQgYnVmZmVy
ICZndDsgZm9yIHRoZSByaW5nYnVmZmVyIG9wZXJhdGlvbnMuIEp1c3QgdG8g
ZG91YmxlLWNoZWNrOiBEaWQgeW91IHVzZSBBSSB0byBjcmVhdGUgdGhpcyBw
YXRjaD8gT3IganVzdCBmb3IgdGhlIHBhdGNoIGRlc2NyaXB0aW9uPyAmZ3Q7
IFNpZ25lZC1vZmYtYnk6IEp1biBZdSAmbHQ7eXVqdW5Aa3lsaW5vcy5jbiZn
dDsgJmd0OyAtLS0gJmd0OyBhdWRpby9wd2F1ZGlvLmMgfCAyMCArKysrKysr
KysrKysrKysrKysrLSAmZ3Q7IDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pICZndDsgJmd0OyBkaWZmIC0tZ2l0IGEv
YXVkaW8vcHdhdWRpby5jIGIvYXVkaW8vcHdhdWRpby5jICZndDsgaW5kZXgg
YTU5YzIyZTYwYi4uZmY3NWVjMmFmMiAxMDA2NDQgJmd0OyAtLS0gYS9hdWRp
by9wd2F1ZGlvLmMgJmd0OyArKysgYi9hdWRpby9wd2F1ZGlvLmMgJmd0OyBA
QCAtNTYsNyArNTYsNyBAQCB0eXBlZGVmIHN0cnVjdCBQV1ZvaWNlIHsgJmd0
OyB1aW50MzJfdCBoaWdod2F0ZXJfbWFyazsgJmd0OyB1aW50MzJfdCBmcmFt
ZV9zaXplLCByZXE7ICZndDsgc3RydWN0IHNwYV9yaW5nYnVmZmVyIHJpbmc7
ICZndDsgLSB1aW50OF90IGJ1ZmZlcltSSU5HQlVGRkVSX1NJWkVdOyAmZ3Q7
ICsgdWludDhfdCAqYnVmZmVyOyAmZ3Q7ICZndDsgcHd2b2x1bWUgdm9sdW1l
OyAmZ3Q7IGJvb2wgbXV0ZWQ7ICZndDsgQEAgLTUzMiw2ICs1MzIsMTIgQEAg
cXB3X2luaXRfb3V0KEhXVm9pY2VPdXQgKmh3LCBzdHJ1Y3QgYXVkc2V0dGlu
Z3MgKmFzKSAmZ3Q7IEF1ZGlvZGV2UGlwZXdpcmVQZXJEaXJlY3Rpb25PcHRp
b25zICpwcGRvID0gcG9wdHMtJmd0O291dDsgJmd0OyBpbnQgcjsgJmd0OyAm
Z3Q7ICsgdi0mZ3Q7YnVmZmVyID0gZ19tYWxsb2MoUklOR0JVRkZFUl9TSVpF
KTsgJmd0OyArIGlmICghdi0mZ3Q7YnVmZmVyKSB7IGdfbWFsbG9jIG5ldmVy
IHJldHVybnMgTlVMTC4gJmd0OyArIGVycm9yX3JlcG9ydCgicGlwZXdpcmU6
IGZhaWxlZCB0byBhbGxvY2F0ZSBidWZmZXIiKTsgJmd0OyArIHJldHVybiAt
MTsgJmd0OyArIH0gJmd0OyArICZndDsgcHdfdGhyZWFkX2xvb3BfbG9jayhj
LSZndDt0aHJlYWRfbG9vcCk7ICZndDsgJmd0OyB2LSZndDtpbmZvLmZvcm1h
dCA9IGF1ZGZtdF90b19wdyhhcy0mZ3Q7Zm10LCBhcy0mZ3Q7YmlnX2VuZGlh
bik7ICZndDsgQEAgLTU1MSw2ICs1NTcsOCBAQCBxcHdfaW5pdF9vdXQoSFdW
b2ljZU91dCAqaHcsIHN0cnVjdCBhdWRzZXR0aW5ncyAqYXMpICZndDsgcHBk
by0mZ3Q7bmFtZSwgU1BBX0RJUkVDVElPTl9PVVRQVVQpOyAmZ3Q7IGlmIChy
ICZsdDsgMCkgeyAmZ3Q7IHB3X3RocmVhZF9sb29wX3VubG9jayhjLSZndDt0
aHJlYWRfbG9vcCk7ICZndDsgKyBnX2ZyZWUodi0mZ3Q7YnVmZmVyKTsgJmd0
OyArIHYtJmd0O2J1ZmZlciA9IE5VTEw7ICZndDsgcmV0dXJuIC0xOyAmZ3Q7
IH0gJmd0OyAmZ3Q7IEBAIC01NzksNiArNTg3LDEyIEBAIHFwd19pbml0X2lu
KEhXVm9pY2VJbiAqaHcsIHN0cnVjdCBhdWRzZXR0aW5ncyAqYXMpICZndDsg
QXVkaW9kZXZQaXBld2lyZVBlckRpcmVjdGlvbk9wdGlvbnMgKnBwZG8gPSBw
b3B0cy0mZ3Q7aW47ICZndDsgaW50IHI7ICZndDsgJmd0OyArIHYtJmd0O2J1
ZmZlciA9IGdfbWFsbG9jKFJJTkdCVUZGRVJfU0laRSk7ICZndDsgKyBpZiAo
IXYtJmd0O2J1ZmZlcikgeyBkaXRvLiAmZ3Q7ICsgZXJyb3JfcmVwb3J0KCJw
aXBld2lyZTogZmFpbGVkIHRvIGFsbG9jYXRlIGJ1ZmZlciIpOyAmZ3Q7ICsg
cmV0dXJuIC0xOyAmZ3Q7ICsgfSAmZ3Q7ICsgJmd0OyBwd190aHJlYWRfbG9v
cF9sb2NrKGMtJmd0O3RocmVhZF9sb29wKTsgJmd0OyAmZ3Q7IHYtJmd0O2lu
Zm8uZm9ybWF0ID0gYXVkZm10X3RvX3B3KGFzLSZndDtmbXQsIGFzLSZndDti
aWdfZW5kaWFuKTsgJmd0OyBAQCAtNTk1LDYgKzYwOSw4IEBAIHFwd19pbml0
X2luKEhXVm9pY2VJbiAqaHcsIHN0cnVjdCBhdWRzZXR0aW5ncyAqYXMpICZn
dDsgcHBkby0mZ3Q7bmFtZSwgU1BBX0RJUkVDVElPTl9JTlBVVCk7ICZndDsg
aWYgKHIgJmx0OyAwKSB7ICZndDsgcHdfdGhyZWFkX2xvb3BfdW5sb2NrKGMt
Jmd0O3RocmVhZF9sb29wKTsgJmd0OyArIGdfZnJlZSh2LSZndDtidWZmZXIp
OyAmZ3Q7ICsgdi0mZ3Q7YnVmZmVyID0gTlVMTDsgJmd0OyByZXR1cm4gLTE7
ICZndDsgfSAmZ3Q7ICZndDsgQEAgLTYxOSw2ICs2MzUsOCBAQCBxcHdfdm9p
Y2VfZmluaShBdWRpb1B3ICpjLCBQV1ZvaWNlICp2KSAmZ3Q7IHB3X3N0cmVh
bV9kZXN0cm95KHYtJmd0O3N0cmVhbSk7ICZndDsgdi0mZ3Q7c3RyZWFtID0g
TlVMTDsgJmd0OyBwd190aHJlYWRfbG9vcF91bmxvY2soYy0mZ3Q7dGhyZWFk
X2xvb3ApOyAmZ3Q7ICsgZ19mcmVlKHYtJmd0O2J1ZmZlcik7ICZndDsgKyB2
LSZndDtidWZmZXIgPSBOVUxMOyAmZ3Q7IH0gVGhvbWFzICZsdDsveXVqdW5A
a3lsaW5vcy5jbiZndDs8L2Rpdj4KPC9kaXY+CjxwPiZuYnNwOzwvcD4KPHA+
Jm5ic3A7PC9wPgo8ZGl2IGlkPSJzaWduYXR1cmVCb20iPgo8ZGl2Pgo8cD4m
bmJzcDs8L3A+Cjxicj4KPHAgc3R5bGU9ImNvbG9yOiAjMDAwOyBmb250LXNp
emU6IDE2cHg7Ij4tLS08L3A+CjxkaXYgaWQ9ImNzMmNfbWFpbF9zaWdhdHVy
ZSIgc3R5bGU9ImNvbG9yOiAjMDAwOyBmb250LXNpemU6IDE2cHg7IGZvbnQt
ZmFtaWx5OiBNaWNyb3NvZnQgWWFIZWk7Ij48L2Rpdj4KPHA+Jm5ic3A7PC9w
Pgo8L2Rpdj4KPC9kaXY+PC9kaXY+

--nsmail-cdbn14l3tu2-cdetvo4qea3--

