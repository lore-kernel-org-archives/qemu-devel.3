Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768D2E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 09:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN7Z4-0007NH-1z; Mon, 16 Dec 2024 04:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tN7Yu-0007ML-Mg; Mon, 16 Dec 2024 04:38:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tN7Ys-0003JB-6o; Mon, 16 Dec 2024 04:38:48 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YBZWd4Tnmz6K6V0;
 Mon, 16 Dec 2024 17:33:49 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 7BC5D140445;
 Mon, 16 Dec 2024 17:38:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Dec 2024 10:38:42 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 16 Dec 2024 10:38:42 +0100
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rLkOMCAgAAM2QCAAAk+AIAEiOAg
Date: Mon, 16 Dec 2024 09:38:42 +0000
Message-ID: <fd4edc329dd44b349a5c3d8d017d31ae@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <Z1w0cgrK6Ri6smFM@redhat.com>
In-Reply-To: <Z1w0cgrK6Ri6smFM@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.158.221]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.168, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAxMywg
MjAyNCAxOjIwIFBNDQo+IFRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBD
YzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9k
aUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4gcWVtdS1kZXZlbEBub25nbnUu
b3JnOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsg
bmljb2xpbmNAbnZpZGlhLmNvbTsgZGR1dGlsZUByZWRoYXQuY29tOw0KPiBMaW51eGFybSA8bGlu
dXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKQ0KPiA8d2FuZ3pob3UxQGhpc2lsaWNvbi5j
b20+OyBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47DQo+IEpvbmF0aGFuIENh
bWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47DQo+IHpoYW5nZmVpLmdhb0BsaW5h
cm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAvNV0gaHcvYXJtL3ZpcnQ6IEFkZCBz
dXBwb3J0IGZvciB1c2VyLWNyZWF0YWJsZQ0KPiBuZXN0ZWQgU01NVXYzDQo+IA0KPiBPbiBGcmks
IERlYyAxMywgMjAyNCBhdCAwODo0Njo0MkFNIC0wNDAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6
DQo+ID4gT24gRnJpLCBEZWMgMTMsIDIwMjQgYXQgMTI6MDA6NDNQTSArMDAwMCwgRGFuaWVsIFAu
IEJlcnJhbmfDqSB3cm90ZToNCj4gPiA+IE9uIEZyaSwgTm92IDA4LCAyMDI0IGF0IDEyOjUyOjM3
UE0gKzAwMDAsIFNoYW1lZXIgS29sb3RodW0gdmlhIHdyb3RlOg0KPiA+ID4gPiBIaSwNCj4gPiA+
ID4NCj4gPiA+ID4gVGhpcyBzZXJpZXMgYWRkcyBpbml0aWFsIHN1cHBvcnQgZm9yIGEgdXNlci1j
cmVhdGFibGUgImFybS1zbW11djMtDQo+IG5lc3RlZCINCj4gPiA+ID4gZGV2aWNlIHRvIFFlbXUu
IEF0IHByZXNlbnQgdGhlIFFlbXUgQVJNIFNNTVV2MyBlbXVsYXRpb24gaXMgcGVyDQo+IG1hY2hp
bmUNCj4gPiA+ID4gYW5kIGNhbm5vdCBzdXBwb3J0IG11bHRpcGxlIFNNTVV2M3MuDQo+ID4gPiA+
DQo+ID4gPiA+IEluIG9yZGVyIHRvIHN1cHBvcnQgdmZpby1wY2kgZGV2IGFzc2lnbm1lbnQgd2l0
aCB2U01NVXYzLCB0aGUNCj4gcGh5c2ljYWwNCj4gPiA+ID4gU01NVXYzIGhhcyB0byBiZSBjb25m
aWd1cmVkIGluIG5lc3RlZCBtb2RlLiBIYXZpbmcgYSBwbHVnZ2FibGUNCj4gPiA+ID4gImFybS1z
bW11djMtbmVzdGVkIiBkZXZpY2UgZW5hYmxlcyB1cyB0byBoYXZlIG11bHRpcGxlIHZTTU1VdjMN
Cj4gZm9yIEd1ZXN0cw0KPiA+ID4gPiBydW5uaW5nIG9uIGEgaG9zdCB3aXRoIG11bHRpcGxlIHBo
eXNpY2FsIFNNTVV2M3MuIEEgZmV3IGJlbmVmaXRzIG9mDQo+IGRvaW5nDQo+ID4gPiA+IHRoaXMg
YXJlLA0KPiA+ID4NCj4gPiA+IEknbSBub3QgdmVyeSBmYW1pbGlhciB3aXRoIGFybSwgYnV0IGZy
b20gdGhpcyBkZXNjcmlwdGlvbiBJJ20gbm90DQo+ID4gPiByZWFsbHkgc2VlaW5nIGhvdyAibmVz
dGluZyIgaXMgaW52b2x2ZWQgaGVyZS4gWW91J3JlIG9ubHkgdGFsa2luZw0KPiA+ID4gYWJvdXQg
dGhlIGhvc3QgYW5kIDEgTDEgZ3Vlc3QsIG5vIEwyIGd1ZXN0Lg0KPiA+DQo+ID4gbmVzdGluZyBp
cyB0aGUgdGVybSB0aGUgaW9tbXUgc2lkZSBpcyB1c2luZyB0byByZWZlciB0byB0aGUgMg0KPiA+
IGRpbWVuc2lvbmFsIHBhZ2luZywgaWUgYSBndWVzdCBwYWdlIHRhYmxlIG9uIHRvcCBvZiBhIGh5
cGVydmlzb3IgcGFnZQ0KPiA+IHRhYmxlLg0KPiA+DQo+ID4gTm90aGluZyB0byBkbyB3aXRoIHZt
IG5lc3RpbmcuDQo+IA0KPiBPaywgdGhhdCBuYW1pbmcgaXMgZGVzdGluZWQgdG8gY2F1c2UgY29u
ZnVzaW9uIGZvciBtYW55LCBnaXZlbiB0aGUNCj4gY29tbW9ubHkgdW5kZXJzdG9vZCB1c2Ugb2Yg
J25lc3RpbmcnIGluIHRoZSBjb250ZXh0IG9mIFZNcy4uLg0KPiANCj4gPg0KPiA+ID4gQWxzbyB3
aGF0IGlzIHRoZSByZWxhdGlvbiBiZXR3ZWVuIHRoZSBwaHlzaWNhbCBTTU1VdjMgYW5kIHRoZSBn
dWVzdA0KPiA+ID4gU01NVXYzIHRoYXQncyByZWZlcmVuY2VkID8gSXMgdGhpcyBpbiBmYWN0IHNv
bWUgZm9ybSBvZiBob3N0IGRldmljZQ0KPiA+ID4gcGFzc3Rocm91Z2ggcmF0aGVyIHRoYW4gbmVz
dGluZyA/DQo+ID4NCj4gPiBJdCBpcyBhbiBhY2NlZWxlcmF0aW9uIGZlYXR1cmUsIHRoZSBpb21t
dSBIVyBkb2VzIG1vcmUgd29yayBpbnN0ZWFkIG9mDQo+ID4gdGhlIHNvZnR3YXJlIGVtdWxhdGlu
ZyB0aGluZ3MuIFNpbWlsYXIgdG8gaG93IHRoZSAyZCBwYWdpbmcgb3B0aW9uIGluDQo+ID4gS1ZN
IGlzIGFuIGFjY2VsZXJhdGlvbiBmZWF0dXJlLg0KPiA+DQo+ID4gQWxsIG9mIHRoZSBpb21tdSBz
ZXJpZXMgb24gdmZpbyBhcmUgY3JlYXRpbmcgcGFyYXZpcnR1YWxpemVkIGlvbW11DQo+ID4gbW9k
ZWxzIGluc2lkZSB0aGUgVk0uIFRoZXkgYWNjZXNzIHZhcmlvdXMgbGV2ZWxzIG9mIEhXIGFjY2Vs
ZXJhdGlvbiB0bw0KPiA+IHNwZWVkIHVwIHRoZSBwYXJhdmlydHVhbGl6YXRpb24uDQo+IA0KPiAu
Li4gZGVzY3JpYmluZyBpdCBhcyBhIEhXIGFjY2VsZXJhdGVkIGlvbW11IG1ha2VzIGl0IHNpZ25p
ZmljYW50bHkgY2xlYXJlcg0KPiB0byBtZSB3aGF0IHRoaXMgcHJvcG9zYWwgaXMgYWJvdXQuIFBl
cmhhcHMgdGhlIGRldmljZSBpcyBiZXR0ZXIgbmFtZWQgYXMNCj4gImFybS1zbW11djMtYWNjZWwi
ID8NCg0KQWdyZWUuIFRoZXJlIHdlcmUgc2ltaWxhciBwcmV2aW91cyBjb21tZW50cyBmcm9tIHJl
dmlld2VycyB0aGF0IGN1cnJlbnQgc21tdXYzIA0KYWxyZWFkeSBoYXMgZW11bGF0ZWQgc3RhZ2Ug
MSBhbmQgc3RhZ2UgMiBzdXBwb3J0IGFuZCByZWZlcnMgdG8gdGhhdCBhcyAibmVzdGVkIg0KaW4g
Y29kZS4gU28gdGhpcyB3aWxsIGJlIHJlbmFtZWQgYXMgYWJvdmUuIA0KDQpUaGFua3MsDQpTaGFt
ZWVyDQoNCg0K

