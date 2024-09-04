Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D996CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 13:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slqSD-0005uW-UR; Wed, 04 Sep 2024 09:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1slqRz-0005cY-HE; Wed, 04 Sep 2024 09:53:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1slqRw-0003a6-R3; Wed, 04 Sep 2024 09:53:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WzP4Q4JYWz6HJP4;
 Wed,  4 Sep 2024 21:49:42 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (unknown [7.191.163.9])
 by mail.maildlp.com (Postfix) with ESMTPS id D28F01400CD;
 Wed,  4 Sep 2024 21:53:21 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 14:53:21 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Wed, 4 Sep 2024 14:53:21 +0100
To: Gustavo Romero <gustavo.romero@linaro.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, "shahuang@redhat.com"
 <shahuang@redhat.com>, "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm
 <linuxarm@huawei.com>
Subject: RE: [PATCH RFC V3 24/29] target/arm: Add support of *unrealize*
 ARMCPU during vCPU Hot-unplug
Thread-Topic: [PATCH RFC V3 24/29] target/arm: Add support of *unrealize*
 ARMCPU during vCPU Hot-unplug
Thread-Index: AQHavev6H7OxF7zZK02qabf2MUOdZrIqaJGSgASDY4CADpfbgIAKoSvQ
Date: Wed, 4 Sep 2024 13:53:21 +0000
Message-ID: <a1e33cc186ec4d6a899975fc6462acd3@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-25-salil.mehta@huawei.com>
 <87v800wkb1.fsf@draig.linaro.org>
 <2cb51f91bea3472e8ac04854d7c6bb71@huawei.com>
 <be14d023-f65f-96e4-45ef-8fe002e69bc4@linaro.org>
In-Reply-To: <be14d023-f65f-96e4-45ef-8fe002e69bc4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.171.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgR3VzdGF2bywNCg0KU29ycnkgZm9yIHRoZSBkZWxheSBpbiByZXBseS4uLmdvdCBwdWxsZWQg
aW50byBzb21ldGhpbmcgZWxzZS4NCg0KPiAgRnJvbTogR3VzdGF2byBSb21lcm8gPGd1c3Rhdm8u
cm9tZXJvQGxpbmFyby5vcmc+DQo+ICBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyOCwgMjAyNCA5
OjI0IFBNDQo+ICBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBBbGV4
IEJlbm7DqWUNCj4gIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAgDQo+ICBIaSBTYWxpbCwN
Cj4gIA0KPiAgT24gOC8xOS8yNCA5OjM1IEFNLCBTYWxpbCBNZWh0YSB2aWEgd3JvdGU6DQo+ICA+
IEhpIEFsZXgsDQo+ICA+DQo+ICA+PiAgIEZyb206IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVA
bGluYXJvLm9yZz4NCj4gID4+ICAgU2VudDogRnJpZGF5LCBBdWd1c3QgMTYsIDIwMjQgNDozNyBQ
TQ0KPiAgPj4gICBUbzogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICA+
Pg0KPiAgPj4gICBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4gd3JpdGVzOg0K
PiAgPj4NCj4gID4+ICAgPiB2Q1BVIEhvdC11bnBsdWcgd2lsbCByZXN1bHQgaW4gUU9NIENQVSBv
YmplY3QgdW5yZWFsaXphdGlvbiB3aGljaCB3aWxsDQo+ICA+PiAgID4gZG8gYXdheSB3aXRoIGFs
bCB0aGUgdkNQVSB0aHJlYWQgY3JlYXRpb25zLCBhbGxvY2F0aW9ucywgcmVnaXN0cmF0aW9ucw0K
PiAgPj4gICA+IHRoYXQgaGFwcGVuZWQgYXMgcGFydCBvZiB0aGUgcmVhbGl6YXRpb24gcHJvY2Vz
cy4gVGhpcyBjaGFuZ2UNCj4gID4+ICAgPiBpbnRyb2R1Y2VzIHRoZSBBUk0gQ1BVIHVucmVhbGl6
ZSBmdW5jdGlvbiB0YWtpbmcgY2FyZSBvZiBleGFjdGx5IHRoYXQuDQo+ICA+PiAgID4NCj4gID4+
ICAgPiBOb3RlLCBpbml0aWFsaXplZCBLVk0gdkNQVXMgYXJlIG5vdCBkZXN0cm95ZWQgaW4gaG9z
dCBLVk0gYnV0IHRoZWlyDQo+ICA+PiAgID4gUWVtdSBjb250ZXh0IGlzIHBhcmtlZCBhdCB0aGUg
UUVNVSBLVk0gbGF5ZXIuDQo+ICA+PiAgID4NCj4gID4+ICAgPiBDby1kZXZlbG9wZWQtYnk6IEtl
cWlhbiBaaHUgPHpodWtlcWlhbjFAaHVhd2VpLmNvbT4NCj4gID4+ICAgPiBTaWduZWQtb2ZmLWJ5
OiBLZXFpYW4gWmh1IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+ICA+PiAgID4gU2lnbmVkLW9m
Zi1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+ICA+PiAgID4gUmVw
b3J0ZWQtYnk6IFZpc2hudSBQYWpqdXJpIDx2aXNobnVAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4N
Cj4gID4+ICAgPiBbVlA6IElkZW50aWZpZWQgQ1BVIHN0YWxsIGlzc3VlICYgc3VnZ2VzdGVkIHBy
b2JhYmxlIGZpeF0NCj4gID4+ICAgPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwu
bWVodGFAaHVhd2VpLmNvbT4NCj4gID4+ICAgPiAtLS0NCj4gID4+ICAgPiAgdGFyZ2V0L2FybS9j
cHUuYyAgICAgICB8IDEwMQ0KPiAgPj4gICArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgPj4gICA+ICB0YXJnZXQvYXJtL2NwdS5oICAgICAgIHwgIDE0ICsrKysr
Kw0KPiAgPj4gICA+ICB0YXJnZXQvYXJtL2dkYnN0dWIuYyAgIHwgICA2ICsrKw0KPiAgPj4gICA+
ICB0YXJnZXQvYXJtL2hlbHBlci5jICAgIHwgIDI1ICsrKysrKysrKysNCj4gID4+ICAgPiAgdGFy
Z2V0L2FybS9pbnRlcm5hbHMuaCB8ICAgMyArKw0KPiAgPj4gICA+ICB0YXJnZXQvYXJtL2t2bS5j
ICAgICAgIHwgICA1ICsrDQo+ICA+PiAgID4gIDYgZmlsZXMgY2hhbmdlZCwgMTU0IGluc2VydGlv
bnMoKykNCj4gID4+ICAgPg0KPiAgPj4gICA+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2NwdS5j
IGIvdGFyZ2V0L2FybS9jcHUuYyBpbmRleA0KPiAgPj4gICA+IGM5MjE2MmZhOTcuLmEzZGM2Njkz
MDkgMTAwNjQ0DQo+ICA+PiAgID4gLS0tIGEvdGFyZ2V0L2FybS9jcHUuYw0KPiAgPj4gICA+ICsr
KyBiL3RhcmdldC9hcm0vY3B1LmMNCj4gID4+ICAgPiBAQCAtMTU3LDYgKzE1NywxNiBAQCB2b2lk
DQo+ICA+PiAgIGFybV9yZWdpc3Rlcl9wcmVfZWxfY2hhbmdlX2hvb2soQVJNQ1BVICpjcHUsIEFS
TUVMQ2hhbmdlSG9va0ZuDQo+ICA+PiAgICpob29rLA0KPiAgPj4gICA+ICAgICAgUUxJU1RfSU5T
RVJUX0hFQUQoJmNwdS0+cHJlX2VsX2NoYW5nZV9ob29rcywgZW50cnksIG5vZGUpOyAgfQ0KPiAg
Pj4gICA+DQo+ICA+PiAgID4gK3ZvaWQgYXJtX3VucmVnaXN0ZXJfcHJlX2VsX2NoYW5nZV9ob29r
cyhBUk1DUFUgKmNwdSkgew0KPiAgPj4gICA+ICsgICAgQVJNRUxDaGFuZ2VIb29rICplbnRyeSwg
Km5leHQ7DQo+ICA+PiAgID4gKw0KPiAgPj4gICA+ICsgICAgUUxJU1RfRk9SRUFDSF9TQUZFKGVu
dHJ5LCAmY3B1LT5wcmVfZWxfY2hhbmdlX2hvb2tzLCBub2RlLA0KPiAgPj4gICBuZXh0KSB7DQo+
ICA+PiAgID4gKyAgICAgICAgUUxJU1RfUkVNT1ZFKGVudHJ5LCBub2RlKTsNCj4gID4+ICAgPiAr
ICAgICAgICBnX2ZyZWUoZW50cnkpOw0KPiAgPj4gICA+ICsgICAgfQ0KPiAgPj4gICA+ICt9DQo+
ICA+PiAgID4gKw0KPiAgPj4gICA+ICB2b2lkIGFybV9yZWdpc3Rlcl9lbF9jaGFuZ2VfaG9vayhB
Uk1DUFUgKmNwdSwNCj4gID4+ICAgQVJNRUxDaGFuZ2VIb29rRm4gKmhvb2ssDQo+ICA+PiAgID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKm9wYXF1ZSkgIHsgQEAgLTE2
OCw2ICsxNzgsMTYNCj4gID4+ICAgPiBAQCB2b2lkIGFybV9yZWdpc3Rlcl9lbF9jaGFuZ2VfaG9v
ayhBUk1DUFUgKmNwdSwNCj4gID4+ICAgQVJNRUxDaGFuZ2VIb29rRm4gKmhvb2ssDQo+ICA+PiAg
ID4gICAgICBRTElTVF9JTlNFUlRfSEVBRCgmY3B1LT5lbF9jaGFuZ2VfaG9va3MsIGVudHJ5LCBu
b2RlKTsgIH0NCj4gID4+ICAgPg0KPiAgPj4gICA+ICt2b2lkIGFybV91bnJlZ2lzdGVyX2VsX2No
YW5nZV9ob29rcyhBUk1DUFUgKmNwdSkgew0KPiAgPj4gICA+ICsgICAgQVJNRUxDaGFuZ2VIb29r
ICplbnRyeSwgKm5leHQ7DQo+ICA+PiAgID4gKw0KPiAgPj4gICA+ICsgICAgUUxJU1RfRk9SRUFD
SF9TQUZFKGVudHJ5LCAmY3B1LT5lbF9jaGFuZ2VfaG9va3MsIG5vZGUsDQo+ICBuZXh0KSB7DQo+
ICA+PiAgID4gKyAgICAgICAgUUxJU1RfUkVNT1ZFKGVudHJ5LCBub2RlKTsNCj4gID4+ICAgPiAr
ICAgICAgICBnX2ZyZWUoZW50cnkpOw0KPiAgPj4gICA+ICsgICAgfQ0KPiAgPj4gICA+ICt9DQo+
ICA+PiAgID4gKw0KPiAgPj4gICA+ICBzdGF0aWMgdm9pZCBjcF9yZWdfcmVzZXQoZ3BvaW50ZXIg
a2V5LCBncG9pbnRlciB2YWx1ZSwgZ3BvaW50ZXINCj4gID4+ICAgPiBvcGFxdWUpICB7DQo+ICA+
PiAgID4gICAgICAvKiBSZXNldCBhIHNpbmdsZSBBUk1DUFJlZ0luZm8gcmVnaXN0ZXIgKi8gQEAg
LTI1NTIsNiArMjU3Miw4NQ0KPiAgQEANCj4gID4+ICAgPiBzdGF0aWMgdm9pZCBhcm1fY3B1X3Jl
YWxpemVmbihEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ICA+PiAgID4gICAgICBh
Y2MtPnBhcmVudF9yZWFsaXplKGRldiwgZXJycCk7DQo+ICA+PiAgID4gIH0NCj4gID4+ICAgPg0K
PiAgPj4gICA+ICtzdGF0aWMgdm9pZCBhcm1fY3B1X3VucmVhbGl6ZWZuKERldmljZVN0YXRlICpk
ZXYpIHsNCj4gID4+ICAgPiArICAgIEFSTUNQVUNsYXNzICphY2MgPSBBUk1fQ1BVX0dFVF9DTEFT
UyhkZXYpOw0KPiAgPj4gICA+ICsgICAgQVJNQ1BVICpjcHUgPSBBUk1fQ1BVKGRldik7DQo+ICA+
PiAgID4gKyAgICBDUFVBUk1TdGF0ZSAqZW52ID0gJmNwdS0+ZW52Ow0KPiAgPj4gICA+ICsgICAg
Q1BVU3RhdGUgKmNzID0gQ1BVKGRldik7DQo+ICA+PiAgID4gKyAgICBib29sIGhhc19zZWN1cmU7
DQo+ICA+PiAgID4gKw0KPiAgPj4gICA+ICsgICAgaGFzX3NlY3VyZSA9IGNwdS0+aGFzX2VsMyB8
fCBhcm1fZmVhdHVyZShlbnYsDQo+ICA+PiAgID4gKyBBUk1fRkVBVFVSRV9NX1NFQ1VSSVRZKTsN
Cj4gID4+ICAgPiArDQo+ICA+PiAgID4gKyAgICAvKiByb2NrICduJyB1bi1yb2xsLCB3aGF0ZXZl
ciBoYXBwZW5lZCBpbiB0aGUgYXJtX2NwdV9yZWFsaXplZm4NCj4gID4+ICAgY2xlYW5seSAqLw0K
PiAgPj4gICA+ICsgICAgY3B1X2FkZHJlc3Nfc3BhY2VfZGVzdHJveShjcywgQVJNQVNJZHhfTlMp
Ow0KPiAgPj4NCj4gID4+ICAgT24gY3VycmVudCBtYXN0ZXIgdGhpcyB3aWxsIGZhaWw6DQo+ICA+
Pg0KPiAgPj4gICAuLi8uLi90YXJnZXQvYXJtL2NwdS5jOiBJbiBmdW5jdGlvbiDigJhhcm1fY3B1
X3VucmVhbGl6ZWZu4oCZOg0KPiAgPj4gICAuLi8uLi90YXJnZXQvYXJtL2NwdS5jOjI2MjY6NTog
ZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uDQo+ICA+PiAgIOKAmGNwdV9h
ZGRyZXNzX3NwYWNlX2Rlc3Ryb3nigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFy
YXRpb25dDQo+ICA+PiAgICAyNjI2IHwgICAgIGNwdV9hZGRyZXNzX3NwYWNlX2Rlc3Ryb3koY3Ms
IEFSTUFTSWR4X05TKTsNCj4gID4+ICAgICAgICAgfCAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KPiAgPj4gICAuLi8uLi90YXJnZXQvYXJtL2NwdS5jOjI2MjY6NTogZXJyb3I6IG5lc3Rl
ZCBleHRlcm4gZGVjbGFyYXRpb24gb2YNCj4gID4+ICAg4oCYY3B1X2FkZHJlc3Nfc3BhY2VfZGVz
dHJveeKAmSBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10NCj4gID4+ICAgY2MxOiBhbGwgd2Fybmlu
Z3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCj4gID4NCj4gID4NCj4gID4gVGhlIGN1cnJlbnQg
bWFzdGVyIGFscmVhZHkgaGFzIGFyY2gtYWdub3N0aWMgcGF0Y2gtc2V0LiBJJ3ZlIGFwcGxpZWQN
Cj4gID4gdGhlIFJGQyBWMyB0byB0aGUgbGF0ZXN0IGFuZCBjb21wbGllZC4gSSBkaWQgbm90IHNl
ZSB0aGlzIGlzc3VlPw0KPiAgPg0KPiAgPiBJJ3ZlIGNyZWF0ZSBhIG5ldyBicmFuY2ggZm9yIHlv
dXIgcmVmZXJlbmNlLg0KPiAgPg0KPiAgPiBodHRwczovL2dpdGh1Yi5jb20vc2FsaWwtbWVodGEv
cWVtdS90cmVlL3ZpcnQtY3B1aHAtYXJtdjgvcmZjLXY0LXJjNA0KPiAgPg0KPiAgPiBQbGVhc2Ug
bGV0IG1lIGtub3cgaWYgdGhpcyB3b3JrcyBmb3IgeW91Pw0KPiAgDQo+ICBJdCBzdGlsbCBoYXBw
ZW5zIG9uIHRoZSBuZXcgYnJhbmNoLiBZb3UgbmVlZCB0byBjb25maWd1cmUgTGludXggdXNlciBt
b2RlDQo+ICB0byByZXByb2R1Y2UgaXQsIGUuZy46DQo+ICANCj4gICQgLi4vY29uZmlndXJlIC0t
dGFyZ2V0LWxpc3Q9YWFyY2g2NC1saW51eC11c2VyLGFhcmNoNjQtc29mdG1tdSBbLi4uXQ0KPiAg
DQo+ICBJZiB5b3UganVzdCBjb25maWd1cmUgdGhlICdhYXJjaDY0LXNvZnRtbXUnIHRhcmdldCBp
dCBkb2Vzbid0IGhhcHBlbi4NCg0KDQpBYWgsIEkgc2VlLiBJJ2xsIGNoZWNrIGl0IHRvZGF5LiBB
cyB2Q1BVIEhvdHBsdWcgZG9lcyBub3QgbWFrZXMgc2Vuc2UgaW4NClFlbXUgdXNlci1tb2RlIGVt
dWxhdGlvbi4gSSB0aGluayB3ZSBtaWdodCBuZWVkIHRvIGNvbmRpdGlvbmFsbHkNCmNvbXBpbGUg
Y2VydGFpbiBjb2RlIHVzaW5nICFDT05GSUdfVVNFUl9PTkxZIHN3aXRjaC4NCg0KVGhhbmtzIGZv
ciB0aGUgY2xhcmlmaWNhdGlvbi4NCg0KQ2hlZXJzDQoNCj4gIA0KPiAgDQo+ICBDaGVlcnMsDQo+
ICBHdXN0YXZvDQo=

