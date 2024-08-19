Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423DCC5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 12:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg1c9-0000oK-Hi; Mon, 19 Aug 2024 08:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg1by-0000es-HP; Mon, 19 Aug 2024 08:35:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sg1bt-0001Wx-7p; Mon, 19 Aug 2024 08:35:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WnX6r0Y16z6LDFs;
 Mon, 19 Aug 2024 20:32:36 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (unknown [7.191.162.67])
 by mail.maildlp.com (Postfix) with ESMTPS id 07830140A78;
 Mon, 19 Aug 2024 20:35:39 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 13:35:38 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 19 Aug 2024 13:35:38 +0100
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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
Thread-Index: AQHavev6H7OxF7zZK02qabf2MUOdZrIqaJGSgASDY4A=
Date: Mon, 19 Aug 2024 12:35:38 +0000
Message-ID: <2cb51f91bea3472e8ac04854d7c6bb71@huawei.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-25-salil.mehta@huawei.com>
 <87v800wkb1.fsf@draig.linaro.org>
In-Reply-To: <87v800wkb1.fsf@draig.linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.151.47]
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

SGkgQWxleCwNCg0KPiAgRnJvbTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3Jn
Pg0KPiAgU2VudDogRnJpZGF5LCBBdWd1c3QgMTYsIDIwMjQgNDozNyBQTQ0KPiAgVG86IFNhbGls
IE1laHRhIDxzYWxpbC5tZWh0YUBodWF3ZWkuY29tPg0KPiAgDQo+ICBTYWxpbCBNZWh0YSA8c2Fs
aWwubWVodGFAaHVhd2VpLmNvbT4gd3JpdGVzOg0KPiAgDQo+ICA+IHZDUFUgSG90LXVucGx1ZyB3
aWxsIHJlc3VsdCBpbiBRT00gQ1BVIG9iamVjdCB1bnJlYWxpemF0aW9uIHdoaWNoIHdpbGwNCj4g
ID4gZG8gYXdheSB3aXRoIGFsbCB0aGUgdkNQVSB0aHJlYWQgY3JlYXRpb25zLCBhbGxvY2F0aW9u
cywgcmVnaXN0cmF0aW9ucw0KPiAgPiB0aGF0IGhhcHBlbmVkIGFzIHBhcnQgb2YgdGhlIHJlYWxp
emF0aW9uIHByb2Nlc3MuIFRoaXMgY2hhbmdlDQo+ICA+IGludHJvZHVjZXMgdGhlIEFSTSBDUFUg
dW5yZWFsaXplIGZ1bmN0aW9uIHRha2luZyBjYXJlIG9mIGV4YWN0bHkgdGhhdC4NCj4gID4NCj4g
ID4gTm90ZSwgaW5pdGlhbGl6ZWQgS1ZNIHZDUFVzIGFyZSBub3QgZGVzdHJveWVkIGluIGhvc3Qg
S1ZNIGJ1dCB0aGVpcg0KPiAgPiBRZW11IGNvbnRleHQgaXMgcGFya2VkIGF0IHRoZSBRRU1VIEtW
TSBsYXllci4NCj4gID4NCj4gID4gQ28tZGV2ZWxvcGVkLWJ5OiBLZXFpYW4gWmh1IDx6aHVrZXFp
YW4xQGh1YXdlaS5jb20+DQo+ICA+IFNpZ25lZC1vZmYtYnk6IEtlcWlhbiBaaHUgPHpodWtlcWlh
bjFAaHVhd2VpLmNvbT4NCj4gID4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVodGEgPHNhbGlsLm1l
aHRhQGh1YXdlaS5jb20+DQo+ICA+IFJlcG9ydGVkLWJ5OiBWaXNobnUgUGFqanVyaSA8dmlzaG51
QG9zLmFtcGVyZWNvbXB1dGluZy5jb20+DQo+ICA+IFtWUDogSWRlbnRpZmllZCBDUFUgc3RhbGwg
aXNzdWUgJiBzdWdnZXN0ZWQgcHJvYmFibGUgZml4XQ0KPiAgPiBTaWduZWQtb2ZmLWJ5OiBTYWxp
bCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT4NCj4gID4gLS0tDQo+ICA+ICB0YXJnZXQv
YXJtL2NwdS5jICAgICAgIHwgMTAxDQo+ICArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgPiAgdGFyZ2V0L2FybS9jcHUuaCAgICAgICB8ICAxNCArKysrKysNCj4g
ID4gIHRhcmdldC9hcm0vZ2Ric3R1Yi5jICAgfCAgIDYgKysrDQo+ICA+ICB0YXJnZXQvYXJtL2hl
bHBlci5jICAgIHwgIDI1ICsrKysrKysrKysNCj4gID4gIHRhcmdldC9hcm0vaW50ZXJuYWxzLmgg
fCAgIDMgKysNCj4gID4gIHRhcmdldC9hcm0va3ZtLmMgICAgICAgfCAgIDUgKysNCj4gID4gIDYg
ZmlsZXMgY2hhbmdlZCwgMTU0IGluc2VydGlvbnMoKykNCj4gID4NCj4gID4gZGlmZiAtLWdpdCBh
L3RhcmdldC9hcm0vY3B1LmMgYi90YXJnZXQvYXJtL2NwdS5jIGluZGV4DQo+ICA+IGM5MjE2MmZh
OTcuLmEzZGM2NjkzMDkgMTAwNjQ0DQo+ICA+IC0tLSBhL3RhcmdldC9hcm0vY3B1LmMNCj4gID4g
KysrIGIvdGFyZ2V0L2FybS9jcHUuYw0KPiAgPiBAQCAtMTU3LDYgKzE1NywxNiBAQCB2b2lkDQo+
ICBhcm1fcmVnaXN0ZXJfcHJlX2VsX2NoYW5nZV9ob29rKEFSTUNQVSAqY3B1LCBBUk1FTENoYW5n
ZUhvb2tGbg0KPiAgKmhvb2ssDQo+ICA+ICAgICAgUUxJU1RfSU5TRVJUX0hFQUQoJmNwdS0+cHJl
X2VsX2NoYW5nZV9ob29rcywgZW50cnksIG5vZGUpOyAgfQ0KPiAgPg0KPiAgPiArdm9pZCBhcm1f
dW5yZWdpc3Rlcl9wcmVfZWxfY2hhbmdlX2hvb2tzKEFSTUNQVSAqY3B1KSB7DQo+ICA+ICsgICAg
QVJNRUxDaGFuZ2VIb29rICplbnRyeSwgKm5leHQ7DQo+ICA+ICsNCj4gID4gKyAgICBRTElTVF9G
T1JFQUNIX1NBRkUoZW50cnksICZjcHUtPnByZV9lbF9jaGFuZ2VfaG9va3MsIG5vZGUsDQo+ICBu
ZXh0KSB7DQo+ICA+ICsgICAgICAgIFFMSVNUX1JFTU9WRShlbnRyeSwgbm9kZSk7DQo+ICA+ICsg
ICAgICAgIGdfZnJlZShlbnRyeSk7DQo+ICA+ICsgICAgfQ0KPiAgPiArfQ0KPiAgPiArDQo+ICA+
ICB2b2lkIGFybV9yZWdpc3Rlcl9lbF9jaGFuZ2VfaG9vayhBUk1DUFUgKmNwdSwNCj4gIEFSTUVM
Q2hhbmdlSG9va0ZuICpob29rLA0KPiAgPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdm9pZCAqb3BhcXVlKSAgeyBAQCAtMTY4LDYgKzE3OCwxNg0KPiAgPiBAQCB2b2lkIGFybV9y
ZWdpc3Rlcl9lbF9jaGFuZ2VfaG9vayhBUk1DUFUgKmNwdSwNCj4gIEFSTUVMQ2hhbmdlSG9va0Zu
ICpob29rLA0KPiAgPiAgICAgIFFMSVNUX0lOU0VSVF9IRUFEKCZjcHUtPmVsX2NoYW5nZV9ob29r
cywgZW50cnksIG5vZGUpOyAgfQ0KPiAgPg0KPiAgPiArdm9pZCBhcm1fdW5yZWdpc3Rlcl9lbF9j
aGFuZ2VfaG9va3MoQVJNQ1BVICpjcHUpIHsNCj4gID4gKyAgICBBUk1FTENoYW5nZUhvb2sgKmVu
dHJ5LCAqbmV4dDsNCj4gID4gKw0KPiAgPiArICAgIFFMSVNUX0ZPUkVBQ0hfU0FGRShlbnRyeSwg
JmNwdS0+ZWxfY2hhbmdlX2hvb2tzLCBub2RlLCBuZXh0KSB7DQo+ICA+ICsgICAgICAgIFFMSVNU
X1JFTU9WRShlbnRyeSwgbm9kZSk7DQo+ICA+ICsgICAgICAgIGdfZnJlZShlbnRyeSk7DQo+ICA+
ICsgICAgfQ0KPiAgPiArfQ0KPiAgPiArDQo+ICA+ICBzdGF0aWMgdm9pZCBjcF9yZWdfcmVzZXQo
Z3BvaW50ZXIga2V5LCBncG9pbnRlciB2YWx1ZSwgZ3BvaW50ZXINCj4gID4gb3BhcXVlKSAgew0K
PiAgPiAgICAgIC8qIFJlc2V0IGEgc2luZ2xlIEFSTUNQUmVnSW5mbyByZWdpc3RlciAqLyBAQCAt
MjU1Miw2ICsyNTcyLDg1IEBADQo+ICA+IHN0YXRpYyB2b2lkIGFybV9jcHVfcmVhbGl6ZWZuKERl
dmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4gID4gICAgICBhY2MtPnBhcmVudF9yZWFs
aXplKGRldiwgZXJycCk7DQo+ICA+ICB9DQo+ICA+DQo+ICA+ICtzdGF0aWMgdm9pZCBhcm1fY3B1
X3VucmVhbGl6ZWZuKERldmljZVN0YXRlICpkZXYpIHsNCj4gID4gKyAgICBBUk1DUFVDbGFzcyAq
YWNjID0gQVJNX0NQVV9HRVRfQ0xBU1MoZGV2KTsNCj4gID4gKyAgICBBUk1DUFUgKmNwdSA9IEFS
TV9DUFUoZGV2KTsNCj4gID4gKyAgICBDUFVBUk1TdGF0ZSAqZW52ID0gJmNwdS0+ZW52Ow0KPiAg
PiArICAgIENQVVN0YXRlICpjcyA9IENQVShkZXYpOw0KPiAgPiArICAgIGJvb2wgaGFzX3NlY3Vy
ZTsNCj4gID4gKw0KPiAgPiArICAgIGhhc19zZWN1cmUgPSBjcHUtPmhhc19lbDMgfHwgYXJtX2Zl
YXR1cmUoZW52LA0KPiAgPiArIEFSTV9GRUFUVVJFX01fU0VDVVJJVFkpOw0KPiAgPiArDQo+ICA+
ICsgICAgLyogcm9jayAnbicgdW4tcm9sbCwgd2hhdGV2ZXIgaGFwcGVuZWQgaW4gdGhlIGFybV9j
cHVfcmVhbGl6ZWZuDQo+ICBjbGVhbmx5ICovDQo+ICA+ICsgICAgY3B1X2FkZHJlc3Nfc3BhY2Vf
ZGVzdHJveShjcywgQVJNQVNJZHhfTlMpOw0KPiAgDQo+ICBPbiBjdXJyZW50IG1hc3RlciB0aGlz
IHdpbGwgZmFpbDoNCj4gIA0KPiAgLi4vLi4vdGFyZ2V0L2FybS9jcHUuYzogSW4gZnVuY3Rpb24g
4oCYYXJtX2NwdV91bnJlYWxpemVmbuKAmToNCj4gIC4uLy4uL3RhcmdldC9hcm0vY3B1LmM6MjYy
Njo1OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24NCj4gIOKAmGNwdV9h
ZGRyZXNzX3NwYWNlX2Rlc3Ryb3nigJkgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFy
YXRpb25dDQo+ICAgMjYyNiB8ICAgICBjcHVfYWRkcmVzc19zcGFjZV9kZXN0cm95KGNzLCBBUk1B
U0lkeF9OUyk7DQo+ICAgICAgICB8ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAu
Li8uLi90YXJnZXQvYXJtL2NwdS5jOjI2MjY6NTogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFy
YXRpb24gb2YNCj4gIOKAmGNwdV9hZGRyZXNzX3NwYWNlX2Rlc3Ryb3nigJkgWy1XZXJyb3I9bmVz
dGVkLWV4dGVybnNdDQo+ICBjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9y
cw0KDQoNClRoZSBjdXJyZW50IG1hc3RlciBhbHJlYWR5IGhhcyBhcmNoLWFnbm9zdGljIHBhdGNo
LXNldC4gSSd2ZSBhcHBsaWVkIHRoZQ0KUkZDIFYzIHRvIHRoZSBsYXRlc3QgYW5kIGNvbXBsaWVk
LiBJIGRpZCBub3Qgc2VlIHRoaXMgaXNzdWU/DQoNCkkndmUgY3JlYXRlIGEgbmV3IGJyYW5jaCBm
b3IgeW91ciByZWZlcmVuY2UuDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9zYWxpbC1tZWh0YS9xZW11
L3RyZWUvdmlydC1jcHVocC1hcm12OC9yZmMtdjQtcmM0DQoNClBsZWFzZSBsZXQgbWUga25vdyBp
ZiB0aGlzIHdvcmtzIGZvciB5b3U/DQoNCg0KVGhhbmtzDQpTYWxpbC4NCg0KDQoNCj4gIA0KPiAg
LS0NCj4gIEFsZXggQmVubsOpZQ0KPiAgVmlydHVhbGlzYXRpb24gVGVjaCBMZWFkIEAgTGluYXJv
DQo=

