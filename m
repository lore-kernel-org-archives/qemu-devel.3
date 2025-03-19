Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F431C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 09:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuphX-0008J3-3m; Wed, 19 Mar 2025 05:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tuphC-0008Bv-Jd; Wed, 19 Mar 2025 05:26:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tuph8-00042X-E3; Wed, 19 Mar 2025 05:26:42 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZHjtv3lJCz6K9K0;
 Wed, 19 Mar 2025 17:23:35 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 304601408E8;
 Wed, 19 Mar 2025 17:26:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Mar 2025 10:26:29 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 19 Mar 2025 10:26:29 +0100
To: Donald Dutile <ddutile@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Thread-Topic: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie
 bus
Thread-Index: AQHbkps6in4QB/PMZUednFRw1zRmILN5b66AgADGVyA=
Date: Wed, 19 Mar 2025 09:26:29 +0000
Message-ID: <3d1312b411f04121a3be90879a915982@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
In-Reply-To: <b3a4ce7f-41a9-4da9-a8ca-54848b9e9cf1@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
From:  Shameerali Kolothum Thodi via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgRG9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERvbmFsZCBE
dXRpbGUgPGRkdXRpbGVAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMTgsIDIw
MjUgMTA6MTIgUE0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJh
bGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogZXJpYy5hdWdlckByZWRoYXQuY29tOyBwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc7IGpnZ0BudmlkaWEuY29tOw0KPiBuaWNvbGluY0BudmlkaWEuY29t
OyBiZXJyYW5nZUByZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207DQo+IG1vY2hzQG52aWRp
YS5jb207IHNtb3N0YWZhQGdvb2dsZS5jb207IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWku
Y29tPjsgV2FuZ3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47DQo+IGppYW5na3Vu
a3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRo
YW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3ViamVj
dDogUmU6IFtSRkMgUEFUQ0ggdjIgMDUvMjBdIGh3L2FybS9zbW11djMtYWNjZWw6IEFzc29jaWF0
ZSBhIHB4Yi0NCj4gcGNpZSBidXMNCj4gDQo+IFNoYW1lZXIsDQo+IA0KPiBIaSENCj4gDQo+IE9u
IDMvMTEvMjUgMTA6MTAgQU0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gVXNlcsKgbXVz
dCBhc3NvY2lhdGUgYSBweGItcGNpZSByb290IGJ1cyB0byBzbW11djMtYWNjZWwNCj4gPiBhbmQg
dGhhdCBpc8Kgc2V0IGFzIHRoZSBwcmltYXJ5LWJ1cyBmb3IgdGhlIHNtbXUgZGV2Lg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1
bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL3NtbXV2My1hY2NlbC5j
IHwgMTkgKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vc21tdXYzLWFjY2VsLmMgYi9o
dy9hcm0vc21tdXYzLWFjY2VsLmMNCj4gPiBpbmRleCBjMzI3NjYxNjM2Li4xNDcxYjY1Mzc0IDEw
MDY0NA0KPiA+IC0tLSBhL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+ICsrKyBiL2h3L2FybS9z
bW11djMtYWNjZWwuYw0KPiA+IEBAIC05LDYgKzksMjEgQEANCj4gPiAgICNpbmNsdWRlICJxZW11
L29zZGVwLmgiDQo+ID4NCj4gPiAgICNpbmNsdWRlICJody9hcm0vc21tdXYzLWFjY2VsLmgiDQo+
ID4gKyNpbmNsdWRlICJody9wY2kvcGNpX2JyaWRnZS5oIg0KPiA+ICsNCj4gPiArc3RhdGljIGlu
dCBzbW11djNfYWNjZWxfcHhiX3BjaWVfYnVzKE9iamVjdCAqb2JqLCB2b2lkICpvcGFxdWUpDQo+
ID4gK3sNCj4gPiArICAgIERldmljZVN0YXRlICpkID0gb3BhcXVlOw0KPiA+ICsNCj4gPiArICAg
IGlmIChvYmplY3RfZHluYW1pY19jYXN0KG9iaiwgInB4Yi1wY2llLWJ1cyIpKSB7DQo+ID4gKyAg
ICAgICAgUENJQnVzICpidXMgPSBQQ0lfSE9TVF9CUklER0Uob2JqLT5wYXJlbnQpLT5idXM7DQo+
ID4gKyAgICAgICAgaWYgKGQtPnBhcmVudF9idXMgJiYgIXN0cmNtcChidXMtPnFidXMubmFtZSwg
ZC0+cGFyZW50X2J1cy0NCj4gPm5hbWUpKSB7DQo+ID4gKyAgICAgICAgICAgIG9iamVjdF9wcm9w
ZXJ0eV9zZXRfbGluayhPQkpFQ1QoZCksICJwcmltYXJ5LWJ1cyIsIE9CSkVDVChidXMpLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4g
PiArICAgICAgICB9DQo+ID4gKyAgICB9DQo+ID4gKyAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+
DQo+ID4gICBzdGF0aWMgdm9pZCBzbW11X2FjY2VsX3JlYWxpemUoRGV2aWNlU3RhdGUgKmQsIEVy
cm9yICoqZXJycCkNCj4gPiAgIHsNCj4gPiBAQCAtMTcsNiArMzIsOSBAQCBzdGF0aWMgdm9pZCBz
bW11X2FjY2VsX3JlYWxpemUoRGV2aWNlU3RhdGUgKmQsIEVycm9yDQo+ICoqZXJycCkNCj4gPiAg
ICAgICBTeXNCdXNEZXZpY2UgKmRldiA9IFNZU19CVVNfREVWSUNFKGQpOw0KPiA+ICAgICAgIEVy
cm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPiA+DQo+ID4gKyAgICBvYmplY3RfY2hpbGRfZm9yZWFj
aF9yZWN1cnNpdmUob2JqZWN0X2dldF9yb290KCksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc21tdXYzX2FjY2VsX3B4Yl9wY2llX2J1cywgZCk7DQo+ID4gKw0KPiA+
ICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1QoZGV2KSwgImFjY2VsIiwgdHJ1
ZSwgJmVycm9yX2Fib3J0KTsNCj4gPiAgICAgICBjLT5wYXJlbnRfcmVhbGl6ZShkLCAmbG9jYWxf
ZXJyKTsNCj4gPiAgICAgICBpZiAobG9jYWxfZXJyKSB7DQo+ID4gQEAgLTMzLDYgKzUxLDcgQEAg
c3RhdGljIHZvaWQgc21tdXYzX2FjY2VsX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MNCj4gKmtsYXNz
LCB2b2lkICpkYXRhKQ0KPiA+ICAgICAgIGRldmljZV9jbGFzc19zZXRfcGFyZW50X3JlYWxpemUo
ZGMsIHNtbXVfYWNjZWxfcmVhbGl6ZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICZjLT5wYXJlbnRfcmVhbGl6ZSk7DQo+ID4gICAgICAgZGMtPmhvdHBsdWdnYWJs
ZSA9IGZhbHNlOw0KPiA+ICsgICAgZGMtPmJ1c190eXBlID0gVFlQRV9QQ0lFX0JVUzsNCj4gPiAg
IH0NCj4gPg0KPiA+ICAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIHNtbXV2M19hY2NlbF90eXBlX2lu
Zm8gPSB7DQo+IA0KPiBJIGFtIG5vdCBzZWVpbmcgdGhlIG5lZWQgZm9yIGEgcHhiLXBjaWUgYnVz
KHN3aXRjaCkgaW50cm9kdWNlZCBmb3IgZWFjaA0KPiAnYWNjZWwnLg0KPiBJc24ndCB0aGUgSU9S
VCBhYmxlIHRvIGRlZmluZSBkaWZmZXJlbnQgU01NVXMgZm9yIGRpZmZlcmVudCBSSURzPyAgIGlm
IHNvLA0KPiBpdHNuJ3QgdGhhdCBzdWZmaWNpZW50DQo+IHRvIGFzc29jaWF0ZSAoZGVmaW5lKSBh
biBTTU1VPC0+UklEIGFzc29jaWF0aW9uIHdpdGhvdXQgaW50cm9kdWNpbmcgYQ0KPiBweGItcGNp
ZT8NCj4gYW5kIGFnYWluLCBJJ20gbm90IHN1cmUgaG93IHRoYXQgaW1wcm92ZXMvZW5hYmxlcyB0
aGUgZGV2aWNlPC0+U01NVQ0KPiBhc3NvY2lhdGl2aXR5Pw0KDQpUaGFua3MgZm9yIHRha2luZyBh
IGxvb2sgYXQgdGhlIHNlcmllcy4gQXMgZGlzY3Vzc2VkIGVsc2V3aGVyZSBpbiB0aGlzIHRocmVh
ZCh3aXRoDQpFcmljKSwgbm9ybWFsbHkgaW4gcGh5c2ljYWwgd29ybGQgKG9yIGF0bGVhc3QgaW4g
dGhlIG1vc3QgY29tbW9uIGNhc2VzKSBTTU1VdjMNCmlzIGF0dGFjaGVkIHRvIFBDSWUgUm9vdCBD
b21wbGV4IGFuZCBpZiB5b3UgdGFrZSBhIGxvb2sgYXQgdGhlIElPUlQgc3BlYywgaXQgZGVzY3Jp
YmVzDQphc3NvY2lhdGlvbiBvZiBJRCBtYXBwaW5ncyBiZXR3ZWVuIGEgUkMgbm9kZSBhbmQgU01N
VVYzIG5vZGUuDQoNCkFuZCBpZiBteSB1bmRlcnN0YW5kaW5nIGlzIGNvcnJlY3QsIGluIFFlbXUs
IG9ubHkgcHhiLXBjaWUgYWxsb3dzIHlvdSB0byBhZGQNCmV4dHJhIHJvb3QgY29tcGxleGVzIGV2
ZW4gdGhvdWdoIGl0IGlzIHN0aWxsIHBsdWdnZWQgdG8gcGFyZW50KHBjaWUuMCkuIGllLCBmb3Ig
YWxsDQpkZXZpY2VzIGRvd25zdHJlYW0gaXQgYWN0cyBhcyBhIHJvb3QgY29tcGxleCBidXQgc3Rp
bGwgcGx1Z2dlZCBpbnRvIGEgcGFyZW50IHBjaWUuMC4NClRoaXMgYWxsb3dzIHVzIHRvIGFkZC9k
ZXNjcmliZSBtdWx0aXBsZSAic21tdXYzLWFjY2VsIiBlYWNoIGFzc29jaWF0ZWQgd2l0aCBhIFJD
Lg0KDQpIYXZpbmcgc2FpZCB0aGF0LCAgY3VycmVudCBjb2RlIG9ubHkgYWxsb3dzIHB4Yi1wY2ll
IHJvb3QgY29tcGxleGVzIGF2b2lkaW5nDQp0aGUgcGNpZS4wLiBUaGUgaWRlYSBiZWhpbmQgdGhp
cyB3YXMsIHVzZXIgY2FuIHVzZSBwY2llLjAgd2l0aCBhIG5vbiBhY2NlbCBTTU1VdjMNCmZvciBh
bnkgZW11bGF0ZWQgZGV2aWNlcyBhdm9pZGluZyB0aGUgcGVyZm9ybWFuY2UgYm90dGxlbmVja3Mg
d2UgYXJlDQpkaXNjdXNzaW5nIGZvciBlbXVsYXRlZCBkZXYrc21tdXYzLWFjY2VsIGNhc2VzLiBC
dXQgYmFzZWQgb24gdGhlIGZlZWRiYWNrIGZyb20NCkVyaWMgYW5kIERhbmllbCBJIHdpbGwgcmVs
YXggdGhhdCByZXN0cmljdGlvbiBhbmQgd2lsbCBhbGxvdyBhc3NvY2lhdGlvbiB3aXRoIHBjaWUu
MC4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQoNCg0KDQoNCg0KDQoNCiANCg0KPj4+IHRvIHJvb3Qg
Y29tcGxleGVzLg0KPiBGZWVsIGZyZWUgdG8gZW5saWdodGVuIG1lIHdoZXJlIEkgbWF5IGhhdmUg
bWlzLXJlYWQvaW50ZXJwcmV0ZWQgdGhlIElPUlQNCj4gJiBTTU1VdjMgc3BlY3MuDQo+IA0KPiBU
aGFua3MsDQo+IC0gRG9uDQo+IA0KDQo=

