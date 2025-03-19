Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1B6C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwyR-0003EE-Pd; Wed, 19 Mar 2025 13:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tuwyP-0003Di-RE; Wed, 19 Mar 2025 13:12:57 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tuwyN-0003C9-0C; Wed, 19 Mar 2025 13:12:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZHwDX3Qb1z6M4GW;
 Thu, 20 Mar 2025 01:09:32 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 3E128140863;
 Thu, 20 Mar 2025 01:12:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Mar 2025 18:12:50 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 19 Mar 2025 18:12:50 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Donald Dutile <ddutile@redhat.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Thread-Topic: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Thread-Index: AQHbkpt/2E04sj23iE6hCb84oIWO4LNvjRwAgAgITACAAAOdAIAAEXKAgAAEEoCAAA8zgIABdD8AgAALxgCAACQTgIAAMnOAgAEWtACAABIHwA==
Date: Wed, 19 Mar 2025 17:12:50 +0000
Message-ID: <dd973ecfbdc541f09540bdbcbf844047@huawei.com>
References: <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia> <20250317192453.GR9311@nvidia.com>
 <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
 <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
 <Z9nF6FaIU37BNg4B@Asurada-Nvidia>
 <3716d39d-3f88-4914-a9d6-440d379db3d7@redhat.com>
 <20250319002325.GG9311@nvidia.com>
 <27aee7f3-5316-40b7-bd7e-dc68a7a1d0d2@redhat.com>
In-Reply-To: <27aee7f3-5316-40b7-bd7e-dc68a7a1d0d2@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDE5LCAyMDI1IDU6
MDEgUE0NCj4gVG86IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBEb25hbGQgRHV0
aWxlDQo+IDxkZHV0aWxlQHJlZGhhdC5jb20+DQo+IENjOiBOaWNvbGluIENoZW4gPG5pY29saW5j
QG52aWRpYS5jb20+OyBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxpLmtv
bG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOw0KPiBxZW11LWRl
dmVsQG5vbmdudS5vcmc7IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsNCj4gYmVycmFuZ2VAcmVk
aGF0LmNvbTsgbmF0aGFuY0BudmlkaWEuY29tOyBtb2Noc0BudmlkaWEuY29tOw0KPiBzbW9zdGFm
YUBnb29nbGUuY29tOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChC
KQ0KPiA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+OyBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5A
aHVhd2VpLmNvbT47DQo+IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2Vp
LmNvbT47DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBB
VENIIHYyIDAzLzIwXSBody9hcm0vc21tdXYzLWFjY2VsOiBBZGQgaW5pdGlhbA0KPiBpbmZyYXN0
cnVjdHVyZSBmb3Igc21tdXYzLWFjY2VsIGRldmljZQ0KPiANCj4gSGksDQo+IA0KPiANCj4gT24g
My8xOS8yNSAxOjIzIEFNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVHVlLCBNYXIg
MTgsIDIwMjUgYXQgMDU6MjI6NTFQTSAtMDQwMCwgRG9uYWxkIER1dGlsZSB3cm90ZToNCj4gPg0K
PiA+PiBJIGFncmVlIHdpdGggRXJpYyB0aGF0ICdhY2NlbCcgaXNuJ3QgbmVlZGVkIC0tIHRoaXMg
c2hvdWxkIGJlDQo+ID4+IGFzY2VydGFpbmVkIGZyb20gdGhlIHBTTU1VIHRoYXQgYSBwaHlzaWNh
bCBkZXZpY2UgaXMgYXR0YWNoZWQgdG8uDQo+ID4gSSBzZWVtIHRvIHJlbWVtYmVyIHRoZSBwb2lu
dCB3YXMgbWFkZSB0aGF0IHdlIGRvbid0IGFjdHVhbGx5IGtub3cgaWYNCj4gPiBhY2NlbCBpcyBw
b3NzaWJsZSwgb3IgZGVzaXJlZCwgZXNwZWNpYWxseSBpbiB0aGUgY2FzZSBvZiBob3RwbHVnLg0K
PiB0aGF0J3Mgd2h5IEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIGlmIHdlIGNvdWxkIGluc3Rh
bnRpYXRlIGEgc2luZ2xlDQo+IHR5cGUgb2YgZGV2aWNlIHRoYXQgY2FuIGRvIGJvdGggYWNjZWwg
YW5kIG5vbiBhY2NlbCBtb2RlLg0KPiBNYXliZSB0aGF0IHdvdWxkIGJlIGF0IHRoZSBwcmljZSBv
ZiBhbHdheXMgZW5mb3JjaW5nIE1TSSByZXN2IHJlZ2lvbnMgb24NCj4gZ3Vlc3QgdG8gYXNzdXJl
IE1TSSBuZXN0aW5nIGlzIHBvc3NpYmxlLg0KPiANCj4gPg0KPiA+IFRoZSBhY2NlbGVyYXRlZCBt
b2RlIGhhcyBhIG51bWJlciBvZiBsaW1pdGF0aW9ucyB0aGF0IHRoZSBzb2Z0d2FyZQ0KPiA+IG1v
ZGUgZG9lcyBub3QgaGF2ZS4gSSB0aGluayBpdCBkb2VzIG1ha2Ugc2Vuc2UgdGhhdCB0aGUgdXNl
ciB3b3VsZA0KPiA+IGRlbGliZXJhdGVseSBjaG9vc2UgdG8gdXNlIGEgbW9yZSByZXN0cmljdGl2
ZSBvcGVyYXRpbmcgbW9kZSBhbmQgdGhlbg0KPiA+IHdvdWxkIGhhdmUgdG8gbWVldCB0aGUgcmVx
dWlyZW1lbnRzIC0gZWcgYnkgY3JlYXRpbmcgdGhlIHJlcXVpcmVkDQo+ID4gbnVtYmVyIGFuZCBj
b25maWd1cmF0aW9uIG9mIHZTTU1Vcy4NCj4gVG8gYXZvaWQgYW55IG1pc3VuZGVyc3RhbmRpbmcg
SSBhbSBub3QgcHVzaGluZyBmb3IgaGF2ZSBhIHNpbmdsZSB2U01NVQ0KPiBpbnN0YW5jZS4gSSBh
ZHZvY2F0ZSBmb3IgaGF2aW5nIHNldmVyYWwgaW5zdGFuY2VzLCBlYWNoIHNvbWVob3cNCj4gc3Bl
Y2lhbGl6ZWQgZm9yIFZGSU8gZGV2aWNlcyBvciBlbXVsYXRlZCBkZXZpY2VzLiBNYXliZSB3ZSBj
YW4gb3B0LWluDQo+IHdpdGggYWNjZWw9b24gYnV0IHRoZSBkZWZhdWx0IGNvdWxkIGJlIGF1dG8g
KHRoZSBwcm9wZXJ0eSBjYW4gYmUNCj4gQVVUT19PTl9PRkYpIHdoZXJlIHRoZSBjb2RlIGRldGVj
dHMgaWYgYSBWRklPIGRldmljZSBpcyB0cmFuc2xhdGVkLkluDQo+IGNhc2UgaW5jb21wYXRpYmxl
IGRldmljZXMgYXJlIHRyYW5zbGF0ZWQgaW50byBhIHNhbWUgdlNNTVUgaW5zdGFuY2UgSQ0KPiBn
dWVzcyBpdCBjb3VsZCBiZSBkZXRlY3RlZCBhbmQgd2lsbCBmYWlsLg0KPiANCj4gV2hhdCBJIGFt
IHB1c3NoaW5nIGZvciBpcyB0byBoYXZlIGEgc2luZ2xlIHR5cGUgb2YgUUVNVSBkZXZpY2Ugd2hp
Y2ggY2FuDQo+IGRvIGJvdGggYWNjZWwgYW5kIG5vbiBhY2NlbC4NCj4gPiBJbiBnZW5lcmFsIEkg
YWR2b2NhdGUgZm9yIGhhdmluZyBzZXZlcmFsIHZTTU1VIGluc3RhbmNlcywgZWFjaCBvZiB0aGVt
DQo+ID4NCj4gPj4gTm93Li4uIGhvdyBkb2VzIHZmaW8oPzsgd2h5IG5vdCBxZW11PykgbGF5ZXIg
ZGV0ZXJtaW5lIHRoYXQ/IC0tDQo+ID4+IHdoZXJlIGFyZSBTTU1VdjMgJ2FjY2VsJyBmZWF0dXJl
cyBleHBvc2VkIGVpdGhlcjogYSkgaW4gdGhlIGRldmljZQ0KPiA+PiBzdHJ1Y3QgKGZvciB0aGUg
c21tdXYzKSBvciAoYikgc29tZXdoZXJlIHVuZGVyIHN5c2ZzPyAuLi4gSSBjb3VsZG4ndA0KPiA+
PiBmaW5kIGFueXRoaW5nIHVuZGVyIGVpdGhlciBvbiBteSBnLWggc3lzdGVtLCBidXQgd291bGQg
YXBwcmVjaWF0ZSBhDQo+ID4+IHB0ciBpZiB0aGVyZSBpcy4NCj4gPiBJIHRoaW5rIGl0IGlzIG5v
dCBkaXNjb3ZlcmFibGUgeWV0IG90aGVyIHRoYXRuIHRocm91Z2gNCj4gPiB0cnktYW5kLWZhaWwu
IERpc2NvdmVyYWJpbGl0eSB3b3VsZCBwcm9iYWJseSBiZSBzb21lIGJpdHMgaW4gYW4NCj4gPiBp
b21tdWZkIEdFVF9JTkZPIGlvY3RsIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+IHllYWggYnV0
IGF0IGxlYXN0IHdlIGNhbiBlYXNpbHkgZGV0ZWN0IGlmIGEgVkZJTyBkZXZpY2UgaXMgYmVlaW5n
DQo+IHRyYW5zbGF0ZWQgYnkgYSB2U01NVSBpbnN0YW5jZSBpbiB3aGljaCBjYXNlIHRoZXJlIGlz
IG5vIG90aGVyIGNob2ljZSB0bw0KPiB0dXJuIGFjY2VsIG9uLg0KDQpOb3Qgc3VyZSwgaG93IHlv
dSBjYW4gaGFuZGxlIGhvdHBsdWcgaW4gc3VjaCBhIGNhc2U/IEZvciBleGFtcGxlIGlmICB0aGUg
c21tdXYzDQpkZXYgc3RhcnRzIHdpdGggYW4gZW11bGF0ZWQgZGV2aWNlIGFuZCBsYXRlciB0cnkg
cGx1ZyBhIHZmaW8gZGV2PyBJbiBjYXNlIG9mICJhY2NlbCINCnRoZSBmZWF0dXJlIGJpdHMoSUlE
UikgaXMgcXVlcmllZCBmcm9tIHRoZSBob3N0IFNNTVV2MyBhbmQgaXMgcHJlc2VudGVkIHRvDQp0
byB0aGUgdlNNTVUoU2VlIHBhdGNoICAjMTYpLiBXZSBjYW4ndCBkbyB0aGlzIG9uY2UgR3Vlc3Qg
aXMgYm9vdGVkLg0KDQpBbHNvIERhbmllbCBwcmV2aW91c2x5IGNvbW1lbnRlZCBvbiBSRkN2MSB0
aGF0IGhlIHdvdWxkIGxpa2UgdG8gaGF2ZSBleHBsaWNpdA0KdlNNTVU8LS0+cFNNTVUgYXNzb2Np
YXRpb24gaW4gUWVtdSBjb21tYW5kIGxpbmUuIA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVt
dS1kZXZlbC9aNlRMU2R3Z2FqbUhWbUdIQHJlZGhhdC5jb20vDQoNClRob3VnaCB3ZSBhcmUgbm90
IHRoZXJlIHlldCB3aXRob3V0IGEgY29sZC1wbHVnZ2VkIFZGSU8gZGV2IGF0IHRoZSBtb21lbnQs
DQpoYXZpbmcgYXV0byBkZXRlY3Rpb24gb2YgYWNjZWwgaXMgbm90IHRoZSByaWdodCBhcHByb2Fj
aCBpZiB3ZSB3YW50IGFuIGV4cGxpY2l0DQphc3NvY2lhdGlvbiBpbiBRZW11IGNvbW1hbmQgbGlu
ZS4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

