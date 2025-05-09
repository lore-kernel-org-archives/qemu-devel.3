Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A11C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 08:01:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDIej-0001aN-Np; Fri, 09 May 2025 04:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uDIeg-0001Zo-UW; Fri, 09 May 2025 04:00:27 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uDIed-0000Fz-Ng; Fri, 09 May 2025 04:00:26 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zv1ZG3JKJz6H7lR;
 Fri,  9 May 2025 15:57:42 +0800 (CST)
Received: from frapeml100008.china.huawei.com (unknown [7.182.85.131])
 by mail.maildlp.com (Postfix) with ESMTPS id 42200140519;
 Fri,  9 May 2025 16:00:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100008.china.huawei.com (7.182.85.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 May 2025 10:00:15 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Fri, 9 May 2025 10:00:15 +0200
To: Peter Maydell <peter.maydell@linaro.org>, Donald Dutile
 <ddutile@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>, Shameer Kolothum via
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Topic: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Index: AQHbu1V0fvNxmQCU0kS/eGPfhGB2G7PFgqACgAB1wICAANEzi4AAFpHggAHGkICAAANjAIABTtRA
Date: Fri, 9 May 2025 08:00:14 +0000
Message-ID: <3d7824d9fcf04e2e961d30a5f3404b52@huawei.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <877c2ut0zk.fsf@pond.sub.org>
 <e02e884b-0f3d-4426-8a67-2cbd23e80e8c@redhat.com>
 <87frhglwjl.fsf@pond.sub.org> <72f9043a73294bfc9b539ae9b94836d3@huawei.com>
 <d21e0c57-b89a-4c79-958e-e633de039e4c@redhat.com>
 <CAFEAcA9bZ6Rd4PSMG61mJ5Ja07j3--DQE7KqA8RZwxGH3N51sA@mail.gmail.com>
In-Reply-To: <CAFEAcA9bZ6Rd4PSMG61mJ5Ja07j3--DQE7KqA8RZwxGH3N51sA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDgsIDIwMjUg
Mjo1OCBQTQ0KPiBUbzogRG9uYWxkIER1dGlsZSA8ZGR1dGlsZUByZWRoYXQuY29tPg0KPiBDYzog
U2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBo
dWF3ZWkuY29tPjsgTWFya3VzIEFybWJydXN0ZXINCj4gPGFybWJydUByZWRoYXQuY29tPjsgU2hh
bWVlciBLb2xvdGh1bSB2aWEgPHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc+OyBxZW11LWFybUBu
b25nbnUub3JnOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207DQo+IGpnZ0BudmlkaWEuY29tOyBuaWNv
bGluY0BudmlkaWEuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOw0KPiBuYXRoYW5jQG52aWRpYS5j
b207IG1vY2hzQG52aWRpYS5jb207IHNtb3N0YWZhQGdvb2dsZS5jb207IExpbnV4YXJtDQo+IDxs
aW51eGFybUBodWF3ZWkuY29tPjsgV2FuZ3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNv
bT47DQo+IGppYW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2Ft
ZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFy
by5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzZdIGh3L2FybS9zbW11djM6IEFkZCBz
dXBwb3J0IHRvIGFzc29jaWF0ZSBhDQo+IFBDSWUgUkMNCj4gDQo+IE9uIFRodSwgOCBNYXkgMjAy
NSBhdCAxNDo0NiwgRG9uYWxkIER1dGlsZSA8ZGR1dGlsZUByZWRoYXQuY29tPiB3cm90ZToNCj4g
DQo+ID4gSSB3b3VsZCByZWZlciB0byB0aGUgQVJNIFNNTVUgc3BlYywgRmlndXJlIDIuMyBpbiB0
aGUgRy5hIHZlcnNpb24sIHdoZXJlDQo+ID4gaXQncyBzbGlnaHRseSBkaWZmZXJlbnQ7IG1vcmUg
bGlrZToNCj4gPg0KPiA+ICAgKy0tLS0tLS0tLS0tLS0tLS0tLSsNCj4gPiAgIHwgICBQQ0llIERl
dmljZXMgICB8IChvbmUgZGV2aWNlLCB1bmxlc3MgYSBQQ0llIHN3aXRjaCBpcyBidHduIHRoZSBS
QyAmDQo+ICdEZXZpY2VzJzsNCj4gPiAgICstLS0tLS0tLS0tLS0tLS0tLS0rICAgb3IsIHNlZSBt
b3JlIHR5cGljYWwgZXhwYW5zaW9uIGJlbG93KQ0KPiA+ICAgICAgICAgICAgIHwNCj4gPiAgICAg
ICstLS0tLS0tLS0tLS0tKw0KPiA+ICAgICAgfCAgUENJZSBSQyBBICB8DQo+ID4gICAgICArLS0t
LS0tLS0tLS0tLSsNCj4gPiAgICAgICAgICAgICB8DQo+ID4gICAgICArLS0tLS0tdi0tLSsgICAg
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+ICAgICAgfCBTTU1VdjMu
QSB8ICAgIHwgV2lkZSBhc3NvcnRtZW50IG9mIG90aGVyIHBsYXRmb3JtIHwNCj4gPiAgICAgIHwg
KElPTU1VKSAgfCAgICB8ICAgZGV2aWNlcyBub3QgdXNpbmcgU01NVSAgICAgICAgICB8DQo+ID4g
ICAgICArLS0tLSstLS0tLSsgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Kw0KPiA+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgIHwgICB8ICAgfA0KPiA+ICAg
ICstLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0rLS0tKy0rDQo+ID4gICAgfCAgICAg
ICAgIFN5c3RlbSBJbnRlcmNvbm5lY3QgICAgICAgICAgIHwNCj4gPiAgICArLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfA0KPiA+ICAgICstLS0tLS0tKy0tLS0tLS0tKyAgICAgKy0tLS0tKy0tLS0tLS0t
LS0tLS0rDQo+ID4gICAgfCAgIFN5c3RlbSBSQU0gICB8PC0tLT58IENQVSAoTlVNQSBzb2NrZXQp
IHwNCj4gPiAgICArLS0tLS0tLS0tLS0tLS0tLSsgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tKw0K
PiA+DQo+ID4gSW4gZmFjdCwgdGhlIFBDSWUgY2FuIGJlIHF1aXRlIGNvbXBsZXggd2l0aCBQQ0ll
IGJyaWRnZXMsIGFuZCBtdWx0aXBsZQ0KPiBSb290IFBvcnRzIChSUCdzKSwNCj4gPiBhbmQgbXVs
dGlwbGUgU01NVSdzOg0KPiA+DQo+ID4gICAgICArLS0tLS0tLS0tLS0tLS0rICAgKy0tLS0tLS0t
LS0tLS0tKyAgICstLS0tLS0tLS0tLS0tLSsNCj4gPiAgICAgIHwgUENJZSBEZXZpY2UgIHwgICB8
IFBDSWUgRGV2aWNlICB8ICAgfCBQQ0llIERldmljZSAgfA0KPiA+ICAgICAgKy0tLS0tLS0tLS0t
LS0tKyAgICstLS0tLS0tLS0tLS0tLSsgICArLS0tLS0tLS0tLS0tLS0rDQo+ID4gICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgIHwgICAgICAgIDwtLS0gUENJ
ZSBidXMNCj4gPiAgICAgICArLS0tLS0tLS0tLSsgICAgICAgKy0tLS0tLS0tLS0rICAgICAgKy0t
LS0tLS0tLS0rDQo+ID4gICAgICAgfCBQQ0llIFJQICB8ICAgICAgIHwgUENJZSBSUCAgfCAgICAg
IHwgUENJZSBSUCAgfCAgPC0gbWF5IGJlIFBDSSBCcmlkZ2UsIG1heQ0KPiBub3QNCj4gPiAgICAg
ICArLS0tLS0tLS0tLSsgICAgICAgKy0tLS0tLS0tLS0rICAgICAgKy0tLS0tLS0tLS0rDQo+ID4g
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgfA0KPiA+ICAg
ICAgICstLS0tLS0tLS0tKyAgICAgICArLS0tLS0tLS0tLSsgICAgICAgKy0tLS0tLS0tLS0rDQo+
ID4gICAgICAgfCAgU01NVSAgICB8ICAgICAgIHwgIFNNTVUgICAgfCAgICAgICB8ICBTTU1VICAg
IHwNCj4gPiAgICAgICArLS0tLS0tLS0tLSsgICAgICAgKy0tLS0tLS0tLS0rICAgICAgICstLS0t
LS0tLS0tKw0KPiA+ICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgIHwgICA8LSBtYXkgYmUgYSBidXMsIG1heSBub3QoaGlkZGVuIGZyb20NCj4gT1MpDQo+ID4g
ICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgICAgICArLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gICAgICAgICAgICAgIHwgICAgICAgICAgUENJIFJDIEEg
ICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0K
PiA+DQo+IA0KPiANCj4gPiBUaGUgZmluYWwgdGFrZSBhd2F5OiB0aGUgKFFFTVUpIFNNTVUvSU9N
TVUgbXVzdCBiZSBhc3NvY2lhdGVkIHdpdGgNCj4gYSBQQ0llIGJ1cw0KPiA+IE9SLCB0aGUgZm9y
bWF0IGhhcyB0byBiZSBzb21ldGhpbmcgbGlrZToNCj4gPiAgICAtZGV2aWNlIHNtbXV2MywgaWQ9
c21tdXYzLjENCj4gPiAgICAtZGV2aWNlIDxibGFoPiwgc21tdT1zbW11djMuMQ0KPiA+IHdoZXJl
IHRoZSBkZXZpY2UgPC0+IFNNTVUgKG9yIGlmIGV4dGVuZGVkIHRvIHg4NiwgaW9tbXUpIGFzc29j
aWF0aXZpdHkgaXMNCj4gc2V0IHcvbyBidXMgYXNzb2NpYXRpdml0eS4NCj4gDQo+IFRoZSBwcm9i
bGVtIGhlcmUgc2VlbXMgdG8gbWUgdG8gYmUgdGhhdCBpbiB0aGUgaGFyZHdhcmUgd2UncmUNCj4g
bW9kZWxsaW5nIHRoZSBTTU1VIGFsd2F5cyBleGlzdHMsIGJlY2F1c2UgaXQncyBpbiB0aGUgU29D
LA0KPiBidXQgeW91J3JlIHRyeWluZyB0byBhcnJhbmdlIGZvciBpdCB0byBiZSBjcmVhdGVkIG9u
IHRoZQ0KPiBjb21tYW5kIGxpbmUsIHZpYSAtZGV2aWNlLg0KPiANCj4gV2UgZG9uJ3QgaGF2ZSBh
bnkgb2YgdGhlc2UgcHJvYmxlbXMgd2l0aCB0aGUgY3VycmVudCAndmlydCcNCj4gYm9hcmQgY29k
ZSwgYmVjYXVzZSB3ZSBoYXZlIHRoZSBib2FyZCBjb2RlIGNyZWF0ZSB0aGUgaW9tbXUNCj4gKGlm
IHRoZSB1c2VyIGFza3MgZm9yIGl0IHZpYSB0aGUgaW9tbXUgbWFjaGluZSBwcm9wZXJ0eSksDQo+
IGFuZCBpdCBjYW4gd2lyZSBpdCB1cCB0byB0aGUgUENJIHJvb3QgY29tcGxleCBhcyBuZWVkZWQu
DQoNClllcywgY3VycmVudGx5IHZpcnQgY3JlYXRlcyBhIFNNTVV2MyBpbnN0YW5jZSBhbmQgYXNz
b2NpYXRlcyBpdCB3aXRoDQpwY2llLjAgYnkgZGVmYXVsdC4gSG93ZXZlciwgdGhpcyBzZXR1cCBp
c24ndCBpZGVhbCBvbmNlIHdlIGludHJvZHVjZQ0Kc3VwcG9ydCBmb3IgYWNjZWxlcmF0ZWQgU01N
VXYzLCB3aGVyZSB3ZSBuZWVkIHRvIGNvbmZpZ3VyZSB0aGUNCmhvc3QgU01NVXYzIGZvciBuZXN0
ZWQgc3RhZ2UgdHJhbnNsYXRpb24uIFRoaXMgaXMgZXNzZW50aWFsIGZvciBWRklPLVBDSQ0KcGFz
c3Rocm91Z2ggc2NlbmFyaW9zLCB3aGVyZSB0aGUgZ3Vlc3QgbWFuYWdlcyB0aGUgc3RhZ2UtMSBw
YWdlIHRhYmxlcw0KYW5kIHRoZSBob3N0IG1hbmFnZXMgc3RhZ2UtMi4NCg0KSW4gc3VjaCBjYXNl
cywgZGV2aWNlcyBtYXkgYmUgYXNzb2NpYXRlZCB3aXRoIGRpZmZlcmVudCBob3N0IFNNTVV2M3Ms
IA0KYW5kIGhhdmluZyBhIHNpbmdsZSB2U01NVXYzIGluIHRoZSBndWVzdCBpc24ndCBpZGVhbCBh
cy0NCg0KLVdlIHdvdWxkIG5lZWQgdG8gYnJvYWRjYXN0IFRMQklzIG9yIHBlcmZvcm0gbG9va3Vw
cyB0byBpZGVudGlmeSB0aGUNCiBjb3JyZXNwb25kaW5nIGhvc3QgU01NVXYzLg0KLVRoZSBwaHlz
aWNhbCBTTU1VdjNzIG1pZ2h0IGRpZmZlciBpbiBmdW5jdGlvbmFsaXR5Lg0KLVNvbWUgU01NVXYz
IGltcGxlbWVudGF0aW9ucyBvZmZlciBhZGRpdGlvbmFsIHZpcnR1YWxpemF0aW9uIGZlYXR1cmVz
IChlLmcuLCB2Q01EUSksDQogIHdoZXJlIHRoZSBDTURRIGlzIGlzIGRpcmVjdGx5IGdldHMgbWFw
cGVkIHRvIHRoZSBHdWVzdCBhbmQgaW52YWxpZGF0aW9ucw0KICBhcmVuJ3QgIGV2ZW4gdHJhcHBl
ZC4NCg0KUGxlYXNlIHJlZmVyIHRvIHRoZSBlYXJsaWVyIFJGQyBbMV0sIHdoaWNoIHByb3Bvc2Vk
IGEgbmV3IGFybS1zbW11djMtYWNjZWwNCmRldmljZS4gVGhlIG1haW4gZmVlZGJhY2sgb24gdGhh
dCBSRkMgd2FzIHRvIGluc3RlYWQgY29udmVydCB0aGUgZXhpc3RpbmcNCmFybS1zbW11djMgaW50
byBhIHVzZXItY3JlYXRhYmxlIGRldmljZSwgYW5kIGludHJvZHVjZSBhY2NlbGVyYXRpb24gc3Vw
cG9ydA0KdmlhIGFuIG9wdGlvbmFsIHByb3BlcnR5Og0KDQotZGV2aWNlIGFybS1zbW11djMsYWNj
ZWw9b24sLi4NCg0KVGhpcyBzZXJpZXMgaXMgdGhlIGZpcnN0IHN0ZXAgdG93YXJkIHRoYXQgZ29h
bOKAlG1ha2luZyB0aGUgY3VycmVudCBhcm0tc21tdXYzIGRldmljZQ0KdXNlci1jcmVhdGFibGUu
DQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSdzIGEgYmV0dGVyIGFwcHJvYWNoIHRvIGlu
dGVncmF0aW5nIGFjY2VsZXJhdGVkDQpTTU1VdjMgc3VwcG9ydCBoZXJlLg0KDQpUaGFua3MsDQpT
aGFtZWVyDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MDMxMTE0
MTA0NS42NjYyMC0xLXNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbS8NCg==

