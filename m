Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3563ECF3974
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 10:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sraXD-0003Tq-OD; Fri, 20 Sep 2024 06:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.chen@h3c.com>) id 1sraX2-0003Sp-I4
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 06:06:38 -0400
Received: from smtp.h3c.com ([60.191.123.50] helo=h3cspam02-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.chen@h3c.com>) id 1sraWx-0002Is-Kq
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 06:06:30 -0400
Received: from mail.maildlp.com ([172.25.15.154])
 by h3cspam02-ex.h3c.com with ESMTP id 48KA5dxK089235;
 Fri, 20 Sep 2024 18:05:39 +0800 (GMT-8)
 (envelope-from yu.chen@h3c.com)
Received: from DAG6EX09-BJD.srv.huawei-3com.com (unknown [10.153.34.11])
 by mail.maildlp.com (Postfix) with ESMTP id 863FA2004737;
 Fri, 20 Sep 2024 18:11:35 +0800 (CST)
Received: from DAG6EX10-BJD.srv.huawei-3com.com (10.153.34.12) by
 DAG6EX09-BJD.srv.huawei-3com.com (10.153.34.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Fri, 20 Sep 2024 18:05:42 +0800
Received: from DAG6EX10-BJD.srv.huawei-3com.com ([fe80::ade6:b219:16f8:9aa8])
 by DAG6EX10-BJD.srv.huawei-3com.com ([fe80::ade6:b219:16f8:9aa8%6])
 with mapi id 15.02.1258.027; Fri, 20 Sep 2024 18:05:42 +0800
From: Yuchen <yu.chen@h3c.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] migration/multifd: receive channel socket needs to be set to
 non-blocking
Thread-Topic: [PATCH]  migration/multifd: receive channel socket needs to be
 set to non-blocking
Thread-Index: AdsLQcj1g9agKPLCRU2ZlkOXAEmYdw==
Date: Fri, 20 Sep 2024 10:05:42 +0000
Message-ID: <37febc26060949f891aedea01de724fc@h3c.com>
Accept-Language: zh-CN, en-UM, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.196.41]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 48KA5dxK089235
Received-SPF: pass client-ip=60.191.123.50; envelope-from=yu.chen@h3c.com;
 helo=h3cspam02-ex.h3c.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

V2hlbiB0aGUgbWlncmF0aW9uIG5ldHdvcmsgaXMgZGlzY29ubmVjdGVkLCB0aGUgc291cmNlDQpx
ZW11IGNhbiBleGl0IG5vcm1hbGx5IHdpdGggYW4gZXJyb3IsIGJ1dCB0aGUgZGVzdGluYXRpb24N
CnFlbXUgaXMgYWx3YXlzIGJsb2NrZWQgaW4gcmVjdm1zZygpLCBjYXVzZXMgdGhlIGRlc3RpbmF0
aW9uDQpxZW11IG1haW4gdGhyZWFkIHRvIGJlIGJsb2NrZWQuDQoNClRoZSBkZXN0aW5hdGlvbiBx
ZW11IGJsb2NrIHN0YWNrOg0KVGhyZWFkIDEzIChUaHJlYWQgMHg3ZjAxNzhiZmE2NDAgKExXUCAx
ODk1OTA2KSAibXVsdGlmZHJlY3ZfNiIpOg0KIzAgIDB4MDAwMDdmMDQxYjVhZjU2ZiBpbiByZWN2
bXNnICgpDQojMSAgMHgwMDAwNTU1NzNlYmQwYjQyIGluIHFpb19jaGFubmVsX3NvY2tldF9yZWFk
dg0KIzIgIDB4MDAwMDU1NTczZWJjZTgzZiBpbiBxaW9fY2hhbm5lbF9yZWFkdg0KIzMgIHFpb19j
aGFubmVsX3JlYWR2X2FsbF9lb2YNCiM0ICAweDAwMDA1NTU3M2ViY2U5MDkgaW4gcWlvX2NoYW5u
ZWxfcmVhZHZfYWxsDQojNSAgMHgwMDAwNTU1NzNlYWExYjFmIGluIG11bHRpZmRfcmVjdl90aHJl
YWQNCiM2ICAweDAwMDA1NTU3M2VjMmYwYjkgaW4gcWVtdV90aHJlYWRfc3RhcnQNCiM3ICAweDAw
MDA3ZjA0MWI1MmJmN2EgaW4gc3RhcnRfdGhyZWFkDQojOCAgMHgwMDAwN2YwNDFiNWFlNjAwIGlu
IGNsb25lMw0KDQpUaHJlYWQgMSAoVGhyZWFkIDB4N2YwNDEwYzYyMjQwIChMV1AgMTg5NTE1Nikg
Imt2bSIpOg0KIzAgIDB4MDAwMDdmMDQxYjUyOGFlMiBpbiBfX2Z1dGV4X2Fic3RpbWVkX3dhaXRf
Y29tbW9uICgpDQojMSAgMHgwMDAwN2YwNDFiNTMzOGI4IGluIF9fbmV3X3NlbV93YWl0X3Nsb3c2
NC5jb25zdHByb3AuMA0KIzIgIDB4MDAwMDU1NTczZWMyZmQzNCBpbiBxZW11X3NlbV93YWl0IChz
ZW09MHg1NTU3NDJiNWE0ZTApDQojMyAgMHgwMDAwNTU1NzNlYWEyZjA5IGluIG11bHRpZmRfcmVj
dl9zeW5jX21haW4gKCkNCiM0ICAweDAwMDA1NTU3M2U3ZDU5MGQgaW4gcmFtX2xvYWRfcHJlY29w
eSAoZj1mQGVudHJ5PTB4NTU1NzQyMjkxYzIwKQ0KIzUgIDB4MDAwMDU1NTczZTdkNWNiZiBpbiBy
YW1fbG9hZCAob3BhcXVlPTxvcHRpbWl6ZWQgb3V0PiwgdmVyc2lvbl9pZD08b3B0aW1pemVkIG91
dD4sIGY9MHg1NTU3NDIyOTFjMjApDQojNiAgcmFtX2xvYWRfZW50cnkgKGY9MHg1NTU3NDIyOTFj
MjAsIG9wYXF1ZT08b3B0aW1pemVkIG91dD4sIHZlcnNpb25faWQ9PG9wdGltaXplZCBvdXQ+KQ0K
IzcgIDB4MDAwMDU1NTczZWE5MzJlNyBpbiBxZW11X2xvYWR2bV9zZWN0aW9uX3BhcnRfZW5kICht
aXM9MHg1NTU3NDExMzZjMDAsIGY9MHg1NTU3NDIyOTFjMjApDQojOCAgcWVtdV9sb2Fkdm1fc3Rh
dGVfbWFpbiAoZj1mQGVudHJ5PTB4NTU1NzQyMjkxYzIwLCBtaXM9bWlzQGVudHJ5PTB4NTU1NzQx
MTM2YzAwKQ0KIzkgIDB4MDAwMDU1NTczZWE5NDQxOCBpbiBxZW11X2xvYWR2bV9zdGF0ZSAoZj0w
eDU1NTc0MjI5MWMyMCwgbW9kZT1tb2RlQGVudHJ5PVZNU19NSUdSQVRFKQ0KIzEwIDB4MDAwMDU1
NTczZWE4OGJlMSBpbiBwcm9jZXNzX2luY29taW5nX21pZ3JhdGlvbl9jbyAob3BhcXVlPTxvcHRp
bWl6ZWQgb3V0PikNCiMxMSAweDAwMDA1NTU3M2VjNDNkMTMgaW4gY29yb3V0aW5lX3RyYW1wb2xp
bmUgKGkwPTxvcHRpbWl6ZWQgb3V0PiwgaTE9PG9wdGltaXplZCBvdXQ+KQ0KIzEyIDB4MDAwMDdm
MDQxYjRmNWQ5MCBpbiA/PyAoKSBmcm9tIHRhcmdldDovdXNyL2xpYjY0L2xpYmMuc28uNg0KIzEz
IDB4MDAwMDdmZmMxMTg5MDI3MCBpbiA/PyAoKQ0KIzE0IDB4MDAwMDAwMDAwMDAwMDAwMCBpbiA/
PyAoKQ0KDQpTZXR0aW5nIHRoZSByZWNlaXZlIGNoYW5uZWwgdG8gbm9uLWJsb2NraW5nIGNhbiBz
b2x2ZSB0aGUgcHJvYmxlbS4NCg0KU2lnbmVkLW9mZi1ieTogWXVDaGVuIDxZdS5DaGVuQGgzYy5j
b20+DQotLS0NCiBtaWdyYXRpb24vbXVsdGlmZC5jIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9tdWx0aWZkLmMgYi9taWdy
YXRpb24vbXVsdGlmZC5jDQppbmRleCA5YjIwMGY0YWQ5Li43YjJhNzY4ZjA1IDEwMDY0NA0KLS0t
IGEvbWlncmF0aW9uL211bHRpZmQuYw0KKysrIGIvbWlncmF0aW9uL211bHRpZmQuYw0KQEAgLTEz
MTgsNiArMTMxOCw4IEBAIHZvaWQgbXVsdGlmZF9yZWN2X25ld19jaGFubmVsKFFJT0NoYW5uZWwg
KmlvYywgRXJyb3IgKiplcnJwKQ0KICAgICAgICAgaWQgPSBxYXRvbWljX3JlYWQoJm11bHRpZmRf
cmVjdl9zdGF0ZS0+Y291bnQpOw0KICAgICB9DQoNCisgICAgcWlvX2NoYW5uZWxfc2V0X2Jsb2Nr
aW5nKGlvYywgZmFsc2UsIE5VTEwpOw0KKw0KICAgICBwID0gJm11bHRpZmRfcmVjdl9zdGF0ZS0+
cGFyYW1zW2lkXTsNCiAgICAgaWYgKHAtPmMgIT0gTlVMTCkgew0KICAgICAgICAgZXJyb3Jfc2V0
ZygmbG9jYWxfZXJyLCAibXVsdGlmZDogcmVjZWl2ZWQgaWQgJyVkJyBhbHJlYWR5IHNldHVwJyIs
DQotLQ0KMi4zMC4yDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQrmnKzpgq7ku7blj4rlhbbpmYTku7bl
kKvmnInmlrDljY7kuInpm4blm6LnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7lj5HpgIHnu5nk
uIrpnaLlnLDlnYDkuK3liJflh7oNCueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9leWF
tuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaI
lumDqOWIhuWcsOazhOmcsuOAgeWkjeWItuOAgQ0K5oiW5pWj5Y+R77yJ5pys6YKu5Lu25Lit55qE
5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25LqG5pys6YKu5Lu277yM6K+35oKo56uL5Y2z55S16K+d
5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pysDQrpgq7ku7bvvIENClRoaXMgZS1t
YWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24g
ZnJvbSBOZXcgSDNDLCB3aGljaCBpcw0KaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBl
bnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlDQppbmZv
cm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBs
aW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsDQpkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9y
IGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQNCnJlY2lw
aWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJv
ciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyDQpieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVs
eSBhbmQgZGVsZXRlIGl0IQ0K

