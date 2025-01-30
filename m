Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95348C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZ90-0002eL-3P; Thu, 30 Jan 2025 13:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tdZ8x-0002dF-Kc; Thu, 30 Jan 2025 13:19:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tdZ8u-0008TX-Rh; Thu, 30 Jan 2025 13:19:59 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkS1K2Lnbz6M4PN;
 Fri, 31 Jan 2025 02:17:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 8A204140517;
 Fri, 31 Jan 2025 02:19:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 Jan 2025 19:19:48 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 30 Jan 2025 19:19:48 +0100
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 3/5] hw/arm/smmuv3: Associate a pci bus with a SMMUv3
 Nested device
Thread-Topic: [RFC PATCH 3/5] hw/arm/smmuv3: Associate a pci bus with a SMMUv3
 Nested device
Thread-Index: AQHbMd20WuQYJ64eBk2hccc55H+W27Mv89aAgAAtOHA=
Date: Thu, 30 Jan 2025 18:19:48 +0000
Message-ID: <9045488914674b32b726f37c881d3e7f@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-4-shameerali.kolothum.thodi@huawei.com>
 <Z5uo9y6MppYQctW3@redhat.com>
In-Reply-To: <Z5uo9y6MppYQctW3@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.35.225]
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFAuIEJlcnJh
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMzAs
IDIwMjUgNDozMCBQTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFs
aS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiBDYzogcWVtdS1hcm1Abm9uZ251Lm9yZzsg
cWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBlcmljLmF1Z2VyQHJlZGhhdC5jb207IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207DQo+IG5pY29saW5jQG52aWRpYS5jb207
IGRkdXRpbGVAcmVkaGF0LmNvbTsgTGludXhhcm0NCj4gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBX
YW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsNCj4gamlhbmdrdW5rdW4gPGpp
YW5na3Vua3VuQGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1l
cm9uQGh1YXdlaS5jb20+OyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1JGQyBQQVRDSCAzLzVdIGh3L2FybS9zbW11djM6IEFzc29jaWF0ZSBhIHBjaSBidXMgd2l0aCBh
DQo+IFNNTVV2MyBOZXN0ZWQgZGV2aWNlDQo+IA0KPiBPbiBGcmksIE5vdiAwOCwgMjAyNCBhdCAx
Mjo1Mjo0MFBNICswMDAwLCBTaGFtZWVyIEtvbG90aHVtIHZpYSB3cm90ZToNCj4gPiBTdWJzZXF1
ZW50IHBhdGNoZXMgd2lsbCBhZGQgSU9SVCBtb2RpZmljYXRpb25zIHRvIGdldCB0aGlzIHdvcmtp
bmcuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVy
YWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L2FybS9zbW11
djMuYyAgICAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1
ZGUvaHcvYXJtL3NtbXV2My5oIHwgIDIgKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2My5jIGIvaHcvYXJt
L3NtbXV2My5jDQo+ID4gaW5kZXggMDAzM2ViODEyNS4uOWIwYTc3Njc2OSAxMDA2NDQNCj4gPiAt
LS0gYS9ody9hcm0vc21tdXYzLmMNCj4gPiArKysgYi9ody9hcm0vc21tdXYzLmMNCj4gPiBAQCAt
MjQsNiArMjQsNyBAQA0KPiA+ICAjaW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgiDQo+ID4g
ICNpbmNsdWRlICJody9xZGV2LWNvcmUuaCINCj4gPiAgI2luY2x1ZGUgImh3L3BjaS9wY2kuaCIN
Cj4gPiArI2luY2x1ZGUgImh3L3BjaS9wY2lfYnJpZGdlLmgiDQo+ID4gICNpbmNsdWRlICJjcHUu
aCINCj4gPiAgI2luY2x1ZGUgInRyYWNlLmgiDQo+ID4gICNpbmNsdWRlICJxZW11L2xvZy5oIg0K
PiA+IEBAIC0yMjAxLDEyICsyMjAyLDMyIEBAIHN0YXRpYyB2b2lkIHNtbXVfcmVhbGl6ZShEZXZp
Y2VTdGF0ZSAqZCwNCj4gRXJyb3IgKiplcnJwKQ0KPiA+ICAgICAgc21tdV9pbml0X2lycShzLCBk
ZXYpOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBzbW11djNfbmVzdGVkX3BjaV9ob3N0
X2JyaWRnZShPYmplY3QgKm9iaiwgdm9pZCAqb3BhcXVlKQ0KPiA+ICt7DQo+ID4gKyAgICBEZXZp
Y2VTdGF0ZSAqZCA9IG9wYXF1ZTsNCj4gPiArICAgIFNNTVV2M05lc3RlZFN0YXRlICpzX25lc3Rl
ZCA9IEFSTV9TTU1VVjNfTkVTVEVEKGQpOw0KPiA+ICsNCj4gPiArICAgIGlmIChvYmplY3RfZHlu
YW1pY19jYXN0KG9iaiwgVFlQRV9QQ0lfSE9TVF9CUklER0UpKSB7DQo+ID4gKyAgICAgICAgUENJ
QnVzICpidXMgPSBQQ0lfSE9TVF9CUklER0Uob2JqKS0+YnVzOw0KPiA+ICsgICAgICAgIGlmIChz
X25lc3RlZC0+cGNpX2J1cyAmJiAhc3RyY21wKGJ1cy0+cWJ1cy5uYW1lLCBzX25lc3RlZC0NCj4g
PnBjaV9idXMpKSB7DQo+ID4gKyAgICAgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhP
QkpFQ1QoZCksICJwcmltYXJ5LWJ1cyIsIE9CSkVDVChidXMpLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsNCj4gDQo+IElzIHRoZSBTTU1V
djNOZXN0ZWQgdXNlZnVsIGlmIG5vICdwcmltYXJ5LWJ1cycgaXMgc2V0ID8NCj4gDQo+IElmIG5v
dCwgdGhlbiB0aGUgJ3JlYWxpemUnIG1ldGhvZCBvdWdodCB0byB2YWxpZGF0ZSAncGNpLWJ1cycg
aXMgbm90DQo+IE5VTEwgYW5kIGFuZCByYWlzZSBhbiBlcnJvciBpZiBOVUxMLg0KPiANCj4gQWZ0
ZXIgb2JqZWN0X2NoaWxkX2ZvcmVhY2hfcmVjdXJzaXZlIHJldHVybnMsICdyZWFsaXplJyBzaG91
bGQNCj4gYWxzbyB2YWxpZGF0ZSB0aGF0ICdwcmltYXJ5LWJ1cycgaGFzIGJlZW4gc2V0LCBhbmQg
cmFpc2UgYW4gZXJyb3INCj4gaXQgbm90IHNldCwgdG8gZGV0ZWN0IHR5cG9zIGluIHRoZSAncGNp
LWJ1cycgcHJvcGVydHkuDQoNCkkgdGhpbmsgdGhhdCBnZXRzIGNoZWNrZWQgaW4gdGhlIHBhcmVu
dC0+cmVhbGl6ZSgpIA0KDQpzbW11X2Jhc2VfcmVhbGl6ZSgpDQoNCmlmIChzLT5wcmltYXJ5X2J1
cykgew0KICAgICAgICBwY2lfc2V0dXBfaW9tbXUocy0+cHJpbWFyeV9idXMsICZzbW11X29wcywg
cyk7DQogICAgfSBlbHNlIHsNCiAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiU01NVSBpcyBub3Qg
YXR0YWNoZWQgdG8gYW55IFBDSSBidXMhIik7DQogICAgfQ0KDQpJIHdpbGwgZG91YmxlIGNoZWNr
IGlmIHRoYXQgY292ZXJzIGFsbCB0aGUgY29ybmVyIGNhc2VzIG9yIG5vdC4NCg0KVGhhbmtzLA0K
U2hhbWVlcg0KDQo=

