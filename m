Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FF9C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 08:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsdtl-0000YC-Jv; Thu, 13 Mar 2025 04:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsdtj-0000Xq-Mx; Thu, 13 Mar 2025 04:26:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsdth-0002jM-JM; Thu, 13 Mar 2025 04:26:35 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD0pX1Rrcz67Y2h;
 Thu, 13 Mar 2025 16:21:56 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 5D05E140CB1;
 Thu, 13 Mar 2025 16:26:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Mar 2025 09:26:27 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 13 Mar 2025 09:26:27 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 04/20] hw/arm/virt: Add support for smmuv3-accel
Thread-Topic: [RFC PATCH v2 04/20] hw/arm/virt: Add support for smmuv3-accel
Thread-Index: AQHbko9X7BBFIVL5UECoP8opJSgSfrNvkyYAgAAR74D///hiAIAAEm+A///xm4CAACG5AIAAAI4AgAD5XnA=
Date: Thu, 13 Mar 2025 08:26:27 +0000
Message-ID: <f4381814d71841a185ced57dfc4f4c62@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-5-shameerali.kolothum.thodi@huawei.com>
 <547f961e-380c-4ffe-8b8b-3e9d543aa702@redhat.com>
 <58c9c37876c64584b0c7961ec61696a3@huawei.com>
 <5b29ea01-1b86-4b48-a769-14986751a0f1@redhat.com>
 <5d894a546d3f4081ac2cfe98bd2ea612@huawei.com>
 <fb28c228-0c78-4412-ba91-a62cb4351793@redhat.com>
 <8490942b9428411e858a62a80ea12530@huawei.com>
 <df336b78-5a0f-450a-8d3c-95326f5eb9a0@redhat.com>
In-Reply-To: <df336b78-5a0f-450a-8d3c-95326f5eb9a0@redhat.com>
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTIs
IDIwMjUgNjozMSBQTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVl
cmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4g
cWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpn
Z0BudmlkaWEuY29tOyBuaWNvbGluY0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5jb207
IGJlcnJhbmdlQHJlZGhhdC5jb207IG5hdGhhbmNAbnZpZGlhLmNvbTsNCj4gbW9jaHNAbnZpZGlh
LmNvbTsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgTGludXhhcm0NCj4gPGxpbnV4YXJtQGh1YXdlaS5j
b20+OyBXYW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsNCj4gamlhbmdrdW5r
dW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhh
bi5jYW1lcm9uQGh1YXdlaS5jb20+OyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1JGQyBQQVRDSCB2MiAwNC8yMF0gaHcvYXJtL3ZpcnQ6IEFkZCBzdXBwb3J0IGZvciBz
bW11djMtDQo+IGFjY2VsDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gDQo+ID4+Pj4+IFRoYW5r
cyBmb3IgdGFraW5nIGEgbG9vay4gSSBhbSBqdXN0IGp1bXBpbmcgb24gdGhpcyBvbmUgZm9yIG5v
dy4NCj4gPj4+Pj4gWWVzLCB0aGVyZSB3ZXJlIGRpc2N1c3Npb25zIGFyb3VuZCB0aGF0LiBCdXQg
SSB3YXMgbm90IHN1cmUgd2UNCj4gPj4+Pj4gY29uY2x1ZGVkIG9uIGRlcHJlY2F0aW5nIHRoZSBt
YWNoaW5lIG9wdGlvbi4gU28gaWYgSSBnZXQgeW91DQo+ID4+Pj4+IGNvcnJlY3RseSB0aGUgaWRl
YSBpcywNCj4gPj4+Pj4NCj4gPj4+Pj4gaWYgd2UgaGF2ZSwNCj4gPj4+Pj4gLWRldmljZSBzbW11
djMgaXQgd2lsbCBpbnN0YW50aWF0ZSB0aGUgY3VycmVudCBtYWNoaW5lIHdpZGUgc21tdXYzDQo+
ID4+Pj4+IGFuZCBmb3IgLWRldmljZSBzbW11djMsYWNjZWwgdGhpcyBkZXZpY2U/DQo+ID4+Pj4g
eWVzIHRoYXQgd291bGQgYmUgbXkgcHJlZmVyZW5jZS4NCj4gPj4+IE9rLiBJIHdpbGwgbG9vayBp
bnRvIHRoYXQgaW4gbXkgbmV4dCByZXNwaW4uIEEgcXVpY2sgcXVlc3Rpb24uIERvZXMNCj4gPj4+
IHFlbXUgREVWSUNFIG1vZGVsIHN1cHBvcnQgdGhlIGRpZmZlcmVudGlhdGlvbiBsaWtlIGFib3Zl
IGVhc2lseT8gT3INCj4gd2UNCj4gPj4+IGhhdmUgdG8gbWFuYWdlIGl0IHdpdGggcHJvcGVydGll
cz8NCj4gPj4gTm90IHN1cmUgaWYgSSB1bmRlcnN0YW5kIHlvdSBxdWVzdGlvbi4gSSBtZWFudCBp
dCBjYW4gYmUgYSBib29sZWFuDQo+IGRldmljZQ0KPiA+PiBwcm9wZXJ0eSAoREVGSU5FX1BST1Bf
Qk9PTCkgc21tdXYzLGFjY2VsPW9uDQo+ID4+DQo+ID4+IE5vPw0KPiA+IFJpZ2h0LiBNeSBxdWVy
eSB3YXMgbW9yZSBhYm91dCBhbnkgaGlkZGVuIFFlbXUgbWFnaWMgdG8gaGF2ZSBkZXZpY2UNCj4g
aW5zdGFudGlhdGlvbg0KPiA+IHNpbWlsYXIgdG8gd2hhdCB3ZSBoYXZlIGF0IHRoZSBtb21lbnQg
ZXZlbiB0aG91Z2ggd2UgbmFtZSBib3RoDQo+IGRldmljZXMgInNtbXV2MyIuDQo+ID4NCj4gPiBU
aGF0IHdheSBJIGNhbiBrZWVwIG11Y2ggb2YgdGhlIGNvZGUgcmF0aGVyIHRoYW4gY2hlY2tpbmcg
ImFjY2VsIg0KPiBwcm9wZXJ0eQ0KPiA+IGluIFNNTVV2MyBjb2RlIGFuZCByZWRpcmVjdGluZyBj
YWxscy4gQnV0IGxvb2tzIGxpa2Ugbm90Lg0KPiBJIGRvbid0IHRoaW5rIHRoZXJlIGlzIGFueSBz
dWNoIGEgdHJpY2suDQo+IA0KPiBIYXZpbmcgdGhlIGxlZ2FjeSBkZXZpY2UgKHdpdGhvdXQgYWNj
ZWwpIG9ubHkgaW5zdGFudGlhYmxlIHdpdGggdGhlIHZpcnQNCj4gbWFjaGluZSBvcHRpb24gYW5k
IHRoZSBuZXcgYWNjZWxlcmF0ZWQgb25lIG9ubHkgaW5zdGFudGlhYmxlIHdpdGggYQ0KPiAtZGV2
aWNlIG9wdGlvbiBsb29rcyBzdHJhbmdlIHRvIG1lLiBCeSB0aGUgd2F5IHRoZXkgbW9kZWwgdGhl
IHNhbWUNCj4gZGV2aWNlIHNvIEkgdGhpbmsgaXQgbWFrZXMgbW9yZSBzZW5zZSB0byB1c2UgdGhl
IHNhbWUgZGV2aWNlIHdpdGggYW4NCj4gb3B0aW9uLg0KDQpPay4gV2lsbCBhZGRyZXNzIHRoYXQg
aW4gdGhlIG5leHQgcmVzcGluLg0KDQo+IEFsc28gZG8geW91IHNlZSBhbnl0aGluZyB0aGF0IHdv
dWxkIHByZXZlbnQgdGhlIGFjY2VsZXJhdGlvbiBlbmhhbmNlZA0KPiBkZXZpY2UgZnJvbSBiZWlu
ZyBhYmxlIHRvIHRyYW5zbGF0ZSBlbXVsYXRlZCBkZXZpY2VzIGFzIHdlbGwuIElkZWFsbHkNCj4g
dGhlIHNtbXUgZGV2aWNlIHNob3VsZCByZWFjdCBkaWZmZXJlbnRseSBkZXBlbmRpbmcgb24gdGhl
IGRldmljZSB3aGljaA0KPiBpcyB0cmFuc2xhdGVkLiBJIHRoaW5rIGl0IHdvcmtlZCB3aXRoIHRo
ZSBvcmlnaW5hbCBpbXBsZW1lbnRhdGlvbiBhcyBmYXINCj4gYXMgSSByZW1lbWJlci4NCg0KWWVz
LCBzbW11djMtYWNjZWwgd29ya3Mgd2l0aCBlbXVsYXRlZCBkZXZpY2VzIGFzIHdlbGwuIEN1cnJl
bnRseSB0aGUgb25seQ0KbGltaXRhdGlvbiBpcywgd2Ugc2hvdWxkIGhhdmUgYXQgbGVhc3Qgb25l
IHZmaS1wY2kgZGV2IGNvbGQgcGx1Z2dlZCBhcyBtZW50aW9uZWQNCmluIHRoZSBjb3ZlciBsZXR0
ZXIuIEhvcGVmdWxseSB3ZSB3aWxsIGJlIGFibGUgdG8gcmVzb2x2ZSB0aGF0IHJlc3RyaWN0aW9u
IHNvb24uDQoNClRoYW5rcywNClNoYW1lZXINCg0K

