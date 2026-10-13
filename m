Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DABBCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGXwf-0004Hv-16; Tue, 13 Oct 2026 04:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yongD@h3c.com>)
 id 1xGXwc-0004Ha-7O
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:33:10 -0400
Received: from smtp.h3c.com ([60.191.123.56] helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yongD@h3c.com>)
 id 1xGXwY-0006W6-Gp
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:33:09 -0400
Received: from mail.maildlp.com ([172.25.15.155])
 by h3cspam01-ex.h3c.com with ESMTP id 69D8Wpts035609;
 Tue, 13 Oct 2026 16:32:51 +0800 (+08)
 (envelope-from wang.yongD@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
 by mail.maildlp.com (Postfix) with ESMTP id 6B93D2284EA3;
 Tue, 13 Oct 2026 16:35:42 +0800 (CST)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Tue, 13 Oct 2026 16:32:50 +0800
Received: from DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5])
 by DAG6EX09-BJD.srv.huawei-3com.com ([fe80::bdc5:ad7:2347:12a5%4]) with mapi
 id 15.02.1258.027; Tue, 13 Oct 2026 16:32:43 +0800
From: Wangyong <wang.yongD@h3c.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Subject: [Bug] VPD Page 0xb0 Block Limits incorrectly emulated in
 scsi-generic causing guest mkfs.xfs failure
Thread-Topic: Subject: [Bug] VPD Page 0xb0 Block Limits incorrectly emulated
 in scsi-generic causing guest mkfs.xfs failure
Thread-Index: Ad1a5nnrbr41WouEQ7m6B2lhgGU97Q==
Date: Tue, 13 Oct 2026 08:32:43 +0000
Message-ID: <dbba8bb9a29241c5aaae75b7c4479528@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.27.25]
x-sender-location: DAG2
Content-Type: multipart/alternative;
 boundary="_000_dbba8bb9a29241c5aaae75b7c4479528h3ccom_"
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 69D8Wpts035609
Received-SPF: pass client-ip=60.191.123.56; envelope-from=wang.yongD@h3c.com;
 helo=h3cspam01-ex.h3c.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 MIME_CHARSET_FARAWAY=2.45, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_dbba8bb9a29241c5aaae75b7c4479528h3ccom_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGksDQoNCkknbSByZXBvcnRpbmcgYSBidWcgd2hlcmUgVlBEIFBhZ2UgMHhiMCAoQmxvY2sgTGlt
aXRzKSBpcyBpbmNvcnJlY3RseSBlbXVsYXRlZCBpbiBRRU1VJ3Mgc2NzaS1nZW5lcmljIGRyaXZl
ciwgY2F1c2luZyBndWVzdCBWTXMgdG8gZmFpbCBvcGVyYXRpb25zIGxpa2UgbWtmcy54ZnMuDQoN
ClN1bW1hcnk6DQpXaGVuIHVzaW5nIFFFTVUgc3RhbGUtMTEuMCB3aXRoIHNjc2ktYmxvY2sgcGFz
c3Rocm91Z2gsIHRoZSBPcHRpbWFsIFRyYW5zZmVyIExlbmd0aCAoYW5kIHJlbGF0ZWQgZmllbGRz
KSBpbiBWUEQgUGFnZSAweGIwIGFyZSBpbmNvcnJlY3RseSBjYXBwZWQgdG8gYSBtdWNoIHNtYWxs
ZXIgdmFsdWUgdGhhbiB3aGF0IHRoZSBob3N0IGRldmljZSByZXBvcnRzLiBUaGlzIGlzIGNhdXNl
ZCBieSBjb21taXQgM2NiMjkwNTggd2hpY2ggbW9kaWZpZWQgYmxrX2dldF9tYXhfdHJhbnNmZXIo
KSB0byBubyBsb25nZXIgY2hlY2sgYnMtPmJsLm1heF9od190cmFuc2ZlciwgYW5kIHRoZSBzY3Np
LWdlbmVyaWMgY29kZSBhdCBsaW5lIDE5NC0xOTggdXNlcyB0aGlzIGZ1bmN0aW9uIHRvIGNvbXB1
dGUgVlBEIGZpZWxkcyhPcHRpbWFsIFRyYW5zZmVyIExlbmd0aCkuDQoNCkVudmlyb25tZW50Og0K
SG9zdDogTGludXggd2l0aCBtdWx0aXBhdGggKyBMVU4NCkd1ZXN0OiBMaW51eCBWTSB3aXRoIFFF
TVUgMTEuMCBzY3NpLWJsb2NrIHBhc3N0aHJvdWdoDQpIb3N0IGtlcm5lbDogNi42LjANCg0KUmVw
cm9kdWN0aW9uIFN0ZXBzOg0KU2V0IHVwIGEgbXVsdGlwYXRoIGVudmlyb25tZW50IHdpdGggYSBM
VU4gKHBoeXNpY2FsIGRpc2sgd2l0aCBzdHJpcGUgZ2VvbWV0cnkpDQpQYXNzIHRoZSBMVU4gdGhy
b3VnaCB0byBhIFFFTVUgVk0gdXNpbmcgc2NzaS1ibG9jazoNCi1kZXZpY2UgdmlydGlvLXNjc2kt
cGNpLGlkPXNjc2kwLGJ1cz1wY2kuMCxhZGRyPTB4YSBcDQotZHJpdmUgZmlsZT0vZGV2L2Rpc2sv
YnktaWQvZG0tbmFtZS0zNjAwMGQzMTAwNTdkZjgwMDAwMDAwMDAwMDAwMDA5NjksZm9ybWF0PXJh
dyxpZj1ub25lLGlkPWRyaXZlLXNjc2kwLTAtMC0wLGNhY2hlPW5vbmUsYWlvPW5hdGl2ZSBcDQot
ZGV2aWNlIHNjc2ktYmxvY2ssYnVzPXNjc2kwLjAsY2hhbm5lbD0wLHNjc2ktaWQ9MCxsdW49MCxk
cml2ZT1kcml2ZS1zY3NpMC0wLTAtMCxpZD1zY3NpMC0wLTAtMFwNCg0KSW5zaWRlIHRoZSBWTSwg
cnVuIG1rZnMueGZzIC9kZXYvc2RhDQoNCkV4cGVjdGVkIEJlaGF2aW9yOg0KbWtmcy54ZnMgc2hv
dWxkIHN1Y2NlZWQNClZQRCBQYWdlIDB4YjAgc2hvdWxkIHJlcG9ydCBPcHRpbWFsIHRyYW5zZmVy
IGxlbmd0aCBtYXRjaGluZyB0aGUgaG9zdCdzIFJBSUQgc3RyaXBlIHNpemUNCg0KQWN0dWFsIEJl
aGF2aW9yOg0KMS4gbWtmcy54ZnMgZmFpbHMgaW5zaWRlIFZNDQpTQiBzdHJpcGUgdW5pdCBzYW5p
dHkgY2hlY2sgZmFpbGVkDQpNZXRhZGF0YSBjb3JydXB0aW9uIGRldGVjdGVkIGF0IDB4Li4uDQp4
Znhfc2IgYmxvY2sgMHgwLzB4MTAwMA0KbGlieGZzX2J3cml0ZTogd3JpdGUgdmVyaWZpZXIgZmFp
bGVkDQpTQiBzdHJpcGUgdW5pdCBzYW5pdHkgY2hlY2sgZmFpbGVkDQpBRyAweDAgdW5saW5rZWQg
YnVja2V0IHNhbml0eSBjaGVjayBmYWlsZWQNCm1rZnMueGZzOiB3cml0aW5nIEFHIGhlYWRlcnMg
ZmFpbGVkLCBlcnI9MTE3DQoNCk5vdGU6IE5vIGVycm9yIGluIGRtZXNnIGJlY2F1c2UgWEZTIGZh
aWxlZCBkdXJpbmcgaW4tbWVtb3J5IHN1cGVyYmxvY2sgY29uc3RydWN0aW9uLCBuZXZlciBpc3N1
aW5nIGFjdHVhbCBJL08uDQoNCm1rZnMueGZzIC1mIC1kIHN1PTAuc3c9MCAvZGV2L3NkYQ0KMi4g
VlBEIGNvbXBhcmlzb24gYmV0d2VlbiBob3N0IGFuZCBndWVzdA0KSG9zdCAoc2dfdnBkIC1wIDB4
YjAgL2Rldi9kaXNrL2J5LWlkL2RtLW5hbWUtMzYwMDBkMzEwMDU3ZGY4MDAwMDAwMDAwMDAwMDAw
OTY5KQ0KQmxvY2sgbGltaXRzIFZQRCBwYWdlIChTQkMpDQogIFdyaXRlIHNhbWUgbm9uLXplcm8g
KFdTTlopOiAwDQogIE1heGltdW0gY29tcGFyZSBhbmQgd3JpdGUgbGVuZ3RoOiAweDENCiAgT3B0
aW1hbCB0cmFuc2ZlciBsZW5ndGggZ3JhbnVsYXJpdHk6IDB4MTAwMA0KICBNYXhpbXVtIHRyYW5z
ZmVyIGxlbmd0aDogMCBibG9ja3MgW25vdCByZXBvcnRlZF0NCiAgT3B0aW1hbCB0cmFuc2ZlciBs
ZW5ndGg6IDB4MTAwMA0KICBNYXhpbXVtIHByZWZldGNoIGxlbmd0aDogMCBibG9ja3MgW25vdCBy
ZXBvcnRlZF0NCiAgTWF4aW11bSB1bm1hcCBMQkEgY291bnQ6IDB4MjAwMDAwDQogIE1heGltdW0g
dW5tYXAgYmxvY2sgZGVzY3JpcHRvciBjb3VudDogMHgxDQogIE9wdGltYWwgdW5tYXAgZ3JhbnVs
YXJpdHk6IDB4MTAwMA0KICBVbm1hcCBncmFudWxhcml0eSBhbGlnbm1lbnQgdmFsaWQ6IHRydWUN
CiAgVW5tYXAgZ3JhbnVsYXJpdHkgYWxpZ25tZW50OiAweDANCiAgTWF4aW11bSB3cml0ZSBzYW1l
IGxlbmd0aDogMCBibG9ja3MgW25vdCByZXBvcnRlZF0NCiAgTWF4aW11bSBhdG9taWMgdHJhbnNm
ZXIgbGVuZ3RoOiAwIGJsb2NrcyBbbm90IHJlcG9ydGVkXQ0KICBBdG9taWMgYWxpZ25tZW50OiAw
IGJsb2NrcyBbdW5hbGlnbmVkIGF0b21pYyB3cml0ZXMgcGVybWl0dGVkXQ0KICBBdG9taWMgdHJh
bnNmZXIgbGVuZ3RoIGdyYW51bGFyaXR5OiAwIGJsb2NrcyBbbm8gZ3JhbnVsYXJpdHkgcmVxdWly
ZW1lbnRdDQogIE1heGltdW0gYXRvbWljIHRyYW5zZmVyIGxlbmd0aCB3aXRoIGF0b21pYyBib3Vu
ZGFyeTogMCBibG9ja3MgW25vdCByZXBvcnRlZF0NCiAgTWF4aW11bSBhdG9taWMgYm91bmRhcnkg
c2l6ZTogMCBibG9ja3MgW2NhbiBvbmx5IHdyaXRlIGF0b21pYyAxIGJsb2NrXQ0KW3Jvb3RAY3Zr
bm9kZTE1MSB+XSMgbGwgL2Rldi9kaXNrL2J5LWlkL2RtLW5hbWUtMzYwMDBkMzEwMDU3ZGY4MDAw
MDAwMDAwMDAwMDAwOTY5DQpscnd4cnd4cnd4IDEgcm9vdCByb290IDEwIE9jdCAxMyAxNTo1NSAv
ZGV2L2Rpc2svYnktaWQvZG0tbmFtZS0zNjAwMGQzMTAwNTdkZjgwMDAwMDAwMDAwMDAwMDA5Njkg
LT4gLi4vLi4vZG0tMQ0KW3Jvb3RAY3Zrbm9kZTE1MSB+XSMgY2F0IC9zeXMvYmxvY2svZG0tMS9x
dWV1ZS9tYXhfc2VnbWVudHMNCjY0DQpHdWVzdCAoc2dfdnBkIC1wIDB4YjAgL2Rldi9zZGEpOg0K
QmxvY2sgbGltaXRzIFZQRCBwYWdlIChTQkMpOg0KICBXcml0ZSBzYW1lIG5vbi16ZXJvIChXU05a
KTogMA0KICBNYXhpbXVtIGNvbXBhcmUgYW5kIHdyaXRlIGxlbmd0aDogMSBibG9ja3MNCiAgT3B0
aW1hbCB0cmFuc2ZlciBsZW5ndGggZ3JhbnVsYXJpdHk6IDQwOTYgYmxvY2tzDQogIE1heGltdW0g
dHJhbnNmZXIgbGVuZ3RoOiA1MTIgYmxvY2tzDQogIE9wdGltYWwgdHJhbnNmZXIgbGVuZ3RoOiA1
MTIgYmxvY2tzICAgICCh+yBJTkNPUlJFQ1QNCiAgTWF4aW11bSBwcmVmZXRjaCB0cmFuc2ZlciBs
ZW5ndGg6IDAgYmxvY2tzIFtpZ25vcmVkXQ0KICBNYXhpbXVtIHVubWFwIExCQSBjb3VudDogMjA5
NzE1Mg0KICBNYXhpbXVtIHVubWFwIGJsb2NrIGRlc2NyaXB0b3IgY291bnQ6IDENCiAgT3B0aW1h
bCB1bm1hcCBncmFudWxhcml0eTogNDA5NiBibG9ja3MNCiAgVW5tYXAgZ3JhbnVsYXJpdHkgYWxp
Z25tZW50IHZhbGlkOiB0cnVlDQogIFVubWFwIGdyYW51bGFyaXR5IGFsaWdubWVudDogMA0KICBN
YXhpbXVtIHdyaXRlIHNhbWUgbGVuZ3RoOiAwIGJsb2NrcyBbbm90IHJlcG9ydGVkXQ0KICBNYXhp
bXVtIGF0b21pYyB0cmFuc2ZlciBsZW5ndGg6IDAgYmxvY2tzIFtub3QgcmVwb3J0ZWRdDQogIEF0
b21pYyBhbGlnbm1lbnQ6IDAgW3VuYWxpZ25lZCBhdG9taWMgd3JpdGVzIHBlcm1pdHRlZF0NCiAg
QXRvbWljIHRyYW5zZmVyIGxlbmd0aCBncmFudWxhcml0eTogMCBbbm8gZ3JhbnVsYXJpdHkgcmVx
dWlyZW1lbnQNCiAgTWF4aW11bSBhdG9taWMgdHJhbnNmZXIgbGVuZ3RoIHdpdGggYXRvbWljIGJv
dW5kYXJ5OiAwIGJsb2NrcyBbbm90IHJlcG9ydGVkXQ0KICBNYXhpbXVtIGF0b21pYyBib3VuZGFy
eSBzaXplOiAwIGJsb2NrcyBbY2FuIG9ubHkgd3JpdGUgYXRvbWljIDEgYmxvY2tdDQoNClJlc3Rv
cmUgIm9wdCB4ZmVyIGxlbiIgdG8gYmVmb3JlIG1vZGlmaWNhdGlvbiwgbWtmcy54ZnMgY2FuIHBh
c3MgdGhlIHRlc3QNCg0KQEAgLTE2OSwxNSArMTY5LDE1IEBAIHN0YXRpYyB2b2lkIHNjc2lfaGFu
ZGxlX2lucXVpcnlfcmVwbHkoU0NTSUdlbmVyaWNSZXEgKnIsIFNDU0lEZXZpY2UgKnMpDQogICAg
ICAgICBpZiAocGFnZSA9PSAweGIwKSB7DQorICAgICAgICAgICAgdWludDMyX3QgbWF4X3RyYW5z
ZmVyX29wdCA9IGJsa19nZXRfbWF4X3RyYW5zZmVyKHMtPmNvbmYuYmxrKSAvIHMtPmJsb2Nrc2l6
ZTsNCg0KICAgICAgICAgICAgIGFzc2VydChtYXhfdHJhbnNmZXIpOw0KICAgICAgICAgICAgIG1h
eF90cmFuc2ZlciA9IE1JTl9OT05fWkVSTyhtYXhfdHJhbnNmZXIsIG1heF9pb3YgKiBxZW11X3Jl
YWxfaG9zdF9wYWdlX3NpemUpDQogICAgICAgICAgICAgICAgIC8gcy0+YmxvY2tzaXplOw0KICAg
ICAgICAgICAgIHN0bF9iZV9wKCZyLT5idWZbOF0sIG1heF90cmFuc2Zlcik7DQogICAgICAgICAg
ICAgLyogQWxzbyB0YWtlIGNhcmUgb2YgdGhlIG9wdCB4ZmVyIGxlbi4gKi8NCiAgICAgICAgICAg
ICBzdGxfYmVfcCgmci0+YnVmWzEyXSwNCi0gICAgICAgICAgICAgICAgICAgIE1JTl9OT05fWkVS
TyhtYXhfdHJhbnNmZXIsIGxkbF9iZV9wKCZyLT5idWZbMTJdKSkpOw0KKyAgICAgICAgICAgICAg
ICAgICAgTUlOX05PTl9aRVJPKG1heF90cmFuc2Zlcl9vcHQsIGxkbF9iZV9wKCZyLT5idWZbMTJd
KSkpOw0KICAgICAgICAgfSBlbHNlIGlmIChzLT5uZWVkc192cGRfYmxfZW11bGF0aW9uICYmIHBh
Z2UgPT0gMHgwMCAmJiByLT5idWZsZW4gPj0gNCkgew0KICAgICAgICAgICAgIC8qDQogICAgICAg
ICAgICAgICogTm93IHdlJ3JlIGNhcGFibGUgb2Ygc3VwcGx5aW5nIHRoZSBWUEQgQmxvY2sgTGlt
aXRzDQoNCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBhZGRpdGlvbmFsIGlu
Zm9ybWF0aW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQp3YW5neW9uZw0KDQoNCg0K

--_000_dbba8bb9a29241c5aaae75b7c4479528h3ccom_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:=B5=C8=CF=DF;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:=CE=A2=C8=ED=D1=C5=BA=DA;
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@=CE=A2=C8=ED=D1=C5=BA=DA";}
@font-face
	{font-family:"\@=B5=C8=CF=DF";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Lucida Console";
	panose-1:2 11 6 9 4 5 4 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:=B5=C8=CF=DF;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:=B5=C8=CF=DF;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:=B5=C8=CF=DF;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I'm reporting a bug where VPD P=
age 0xb0 (Block Limits) is incorrectly emulated in QEMU's scsi-generic driv=
er, causing guest VMs to fail operations like mkfs.xfs.<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Summary:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">When using QEMU stale-11.0 with=
 scsi-block passthrough, the Optimal Transfer Length (and related fields) i=
n VPD Page 0xb0 are incorrectly capped to a much smaller value than what th=
e host device reports. This is caused
 by commit 3cb29058 which modified blk_get_max_transfer() to no longer chec=
k bs-&gt;bl.max_hw_transfer, and the scsi-generic code at line 194-198 uses=
 this function to compute VPD fields(Optimal Transfer Length).<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Environment:<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Host: Linux with multipath &#43=
; LUN<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Guest: Linux VM with QEMU 11.0 =
scsi-block passthrough<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Host kernel: 6.6.0<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Reproduction Steps:<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Set up a multipath environment =
with a LUN (physical disk with stripe geometry)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Pass the LUN through to a QEMU =
VM using scsi-block:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-device virtio-scsi-pci,id=3Dsc=
si0,bus=3Dpci.0,addr=3D0xa \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-drive file=3D/dev/disk/by-id/d=
m-name-36000d310057df8000000000000000969,format=3Draw,if=3Dnone,id=3Ddrive-=
scsi0-0-0-0,cache=3Dnone,aio=3Dnative \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">-device scsi-block,bus=3Dscsi0.=
0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-=
0\<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Inside the VM, run mkfs.xfs /de=
v/sda<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Expected Behavior:<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">mkfs.xfs should succeed<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">VPD Page 0xb0 should report Opt=
imal transfer length matching the host's RAID stripe size<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Actual Behavior:<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">1. mkfs.xfs fails inside VM<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">SB stripe unit sanity check fai=
led<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Metadata corruption detected at=
 0x...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">xfx_sb block 0x0/0x1000<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">libxfs_bwrite: write verifier f=
ailed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">SB stripe unit sanity check fai=
led<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">AG 0x0 unlinked bucket sanity c=
heck failed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">mkfs.xfs: writing AG headers fa=
iled, err=3D117<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Note: No error in dmesg because=
 XFS failed during in-memory superblock construction, never issuing actual =
I/O.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">mkfs.xfs -f -d su=3D0.sw=3D0 /d=
ev/sda <o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">2. VPD comparison between host =
and guest<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Host (sg_vpd -p 0xb0 /dev/disk/=
by-id/dm-name-36000d310057df8000000000000000969)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Block limits VPD page (SBC)<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Write same non-zero (WSN=
Z): 0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum compare and writ=
e length: 0x1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Optimal transfer length =
granularity: 0x1000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum transfer length:=
 0 blocks [not reported]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">&nbsp; Optimal transfer leng=
th: 0x1000<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum prefetch length:=
 0 blocks [not reported]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum unmap LBA count:=
 0x200000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum unmap block desc=
riptor count: 0x1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Optimal unmap granularit=
y: 0x1000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Unmap granularity alignm=
ent valid: true<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Unmap granularity alignm=
ent: 0x0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum write same lengt=
h: 0 blocks [not reported]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum atomic transfer =
length: 0 blocks [not reported]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Atomic alignment: 0 bloc=
ks [unaligned atomic writes permitted]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Atomic transfer length g=
ranularity: 0 blocks [no granularity requirement]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum atomic transfer =
length with atomic boundary: 0 blocks [not reported]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum atomic boundary =
size: 0 blocks [can only write atomic 1 block]<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:10.5pt"><span lang=3D"EN-US">[r=
oot@cvknode151 ~]# ll /dev/disk/by-id/dm-name-36000d310057df800000000000000=
0969<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:10.5pt"><span lang=3D"EN-US">lr=
wxrwxrwx 1 root root 10 Oct 13 15:55 /dev/disk/by-id/dm-name-36000d310057df=
8000000000000000969 -&gt; ../../dm-1<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:10.5pt"><span lang=3D"EN-US">[r=
oot@cvknode151 ~]# cat /sys/block/dm-1/queue/max_segments<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal" style=3D"text-indent:10.5pt"><span lang=3D"EN-US">64=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Guest (sg_vpd -p 0xb0 /dev/sda)=
:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Block limits VPD page (SBC):<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Write same non-zero (WSN=
Z): 0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum compare and writ=
e length: 1 blocks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Optimal transfer length =
granularity: 4096 blocks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum transfer length:=
 512 blocks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">&nbsp; Optimal transfer leng=
th: 512 blocks&nbsp;&nbsp;&nbsp;&nbsp; =A1=FB INCORRECT<o:p></o:p></span></=
b></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum prefetch transfe=
r length: 0 blocks [ignored]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum unmap LBA count:=
 2097152<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum unmap block desc=
riptor count: 1<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Optimal unmap granularit=
y: 4096 blocks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Unmap granularity alignm=
ent valid: true<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Unmap granularity alignm=
ent: 0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum write same lengt=
h: 0 blocks [not reported]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum atomic transfer =
length: 0 blocks [not reported]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Atomic alignment: 0 [una=
ligned atomic writes permitted]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Atomic transfer length g=
ranularity: 0 [no granularity requirement<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum atomic transfer =
length with atomic boundary: 0 blocks [not reported]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp; Maximum atomic boundary =
size: 0 blocks [can only write atomic 1 block]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;=CE=
=A2=C8=ED=D1=C5=BA=DA&quot;,sans-serif;color:#24292E;background:white">Rest=
ore &quot;opt xfer len&quot; to before modification, mkfs.xfs can pass the =
test<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;;color:#00BFBF">@@ -169,15 &#43;169,15 @@</span><span lan=
g=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lucida Console&quot;=
">
 static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)<o:=
p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pa=
ge =3D=3D 0xb0) {<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;;color:#00BF00">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_transfer_opt =3D blk_get_max_tr=
ansfer(s-&gt;conf.blk) / s-&gt;blocksize;<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;;color:#00BF00"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; assert(max_transfer);<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; max_transfer =3D MIN_NON_ZERO(max_transfer, max_iov * qem=
u_real_host_page_size)<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; / s-&gt;blocksize;<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; stl_be_p(&amp;r-&gt;buf[8], max_transfer);<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /* Also take care of the opt xfer len. */<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; stl_be_p(&amp;r-&gt;buf[12],<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;;color:#BF0000">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MIN_NON_ZERO(max_transfer, ldl_be_p(&amp;r-&gt;buf[12])));<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;;color:#00BF00">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MIN_NON_ZERO(max_transfer_opt, ldl_be_p(&amp;r-&gt;buf[12])));<o:p></o:=
p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else=
 if (s-&gt;needs_vpd_bl_emulation &amp;&amp; page =3D=3D 0x00 &amp;&amp; r-=
&gt;buflen &gt;=3D 4) {<o:p></o:p></span></p>
<p class=3D"MsoNormal" align=3D"left" style=3D"text-align:left;text-autospa=
ce:none"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-family:&quot;Lu=
cida Console&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; /*<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:9.0pt;font-f=
amily:&quot;Lucida Console&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Now we're capable of supplying the =
VPD Block Limits</span><span lang=3D"EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Please let me know if you need =
any additional information.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Best regards,<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">wangyong<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_dbba8bb9a29241c5aaae75b7c4479528h3ccom_--

