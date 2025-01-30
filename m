Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D141C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdYz4-0007yD-Jg; Thu, 30 Jan 2025 13:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tdYz1-0007xI-LL; Thu, 30 Jan 2025 13:09:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tdYyz-0006Ab-6j; Thu, 30 Jan 2025 13:09:43 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkRq130W4z6K92N;
 Fri, 31 Jan 2025 02:08:45 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id C7B65140CF4;
 Fri, 31 Jan 2025 02:09:24 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 Jan 2025 19:09:24 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 30 Jan 2025 19:09:24 +0100
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rMv66IAgAA0HqA=
Date: Thu, 30 Jan 2025 18:09:24 +0000
Message-ID: <7ecabe74e0514367baf28d67675e5db8@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com>
In-Reply-To: <Z5uiGnAxUf4jXTEI@redhat.com>
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

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBK
YW51YXJ5IDMwLCAyMDI1IDQ6MDAgUE0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkg
PHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gQ2M6IHFlbXUtYXJtQG5v
bmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gZXJpYy5hdWdlckByZWRoYXQuY29t
OyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpnZ0BudmlkaWEuY29tOw0KPiBuaWNvbGluY0Bu
dmlkaWEuY29tOyBkZHV0aWxlQHJlZGhhdC5jb207IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3
ZWkuY29tPjsgV2FuZ3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47DQo+IGppYW5n
a3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9u
YXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3Vi
amVjdDogUmU6IFtSRkMgUEFUQ0ggMC81XSBody9hcm0vdmlydDogQWRkIHN1cHBvcnQgZm9yIHVz
ZXItY3JlYXRhYmxlDQo+IG5lc3RlZCBTTU1VdjMNCj4gDQo+IE9uIEZyaSwgTm92IDA4LCAyMDI0
IGF0IDEyOjUyOjM3UE0gKzAwMDAsIFNoYW1lZXIgS29sb3RodW0gdmlhIHdyb3RlOg0KPiA+IEhv
dyB0byB1c2UgaXQoRWc6KToNCj4gPg0KPiA+IE9uIGEgSGlTaWxpY29uIHBsYXRmb3JtIHRoYXQg
aGFzIG11bHRpcGxlIHBoeXNpY2FsIFNNTVV2M3MsIHRoZSBBQ0MgWklQDQo+IFZGDQo+ID4gZGV2
aWNlcyBhbmQgSE5TIFZGIGRldmljZXMgYXJlIGJlaGluZCBkaWZmZXJlbnQgU01NVXYzcy4gU28g
Zm9yIGENCj4gR3Vlc3QsDQo+ID4gc3BlY2lmeSB0d28gc21tdXYzLW5lc3RlZCBkZXZpY2VzIGVh
Y2ggYmVoaW5kIGEgcHhiLXBjaWUgYXMgYmVsb3csDQo+ID4NCj4gPiAuL3FlbXUtc3lzdGVtLWFh
cmNoNjQgLW1hY2hpbmUgdmlydCxnaWMtdmVyc2lvbj0zLGRlZmF1bHQtYnVzLWJ5cGFzcy0NCj4g
aW9tbXU9b24gXA0KPiA+IC1lbmFibGUta3ZtIC1jcHUgaG9zdCAtbSA0RyAtc21wIGNwdXM9OCxt
YXhjcHVzPTggXA0KPiA+IC1vYmplY3QgaW9tbXVmZCxpZD1pb21tdWZkMCBcDQo+ID4gLWJpb3Mg
UUVNVV9FRkkuZmQgXA0KPiA+IC1rZXJuZWwgSW1hZ2UgXA0KPiA+IC1kZXZpY2UgdmlydGlvLWJs
ay1kZXZpY2UsZHJpdmU9ZnMgXA0KPiA+IC1kcml2ZSBpZj1ub25lLGZpbGU9cm9vdGZzLnFjb3cy
LGlkPWZzIFwNCj4gPiAtZGV2aWNlIHB4Yi1wY2llLGlkPXBjaWUuMSxidXNfbnI9OCxidXM9cGNp
ZS4wIFwNCj4gPiAtZGV2aWNlIHBjaWUtcm9vdC1wb3J0LGlkPXBjaWUucG9ydDEsYnVzPXBjaWUu
MSxjaGFzc2lzPTEgXA0KPiA+IC1kZXZpY2UgYXJtLXNtbXV2My1uZXN0ZWQsaWQ9c21tdXYxLHBj
aS1idXM9cGNpZS4xIFwNCj4gPiAtZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDAwMDo3ZDowMi4xLGJ1
cz1wY2llLnBvcnQxLGlvbW11ZmQ9aW9tbXVmZDAgXA0KPiA+IC1kZXZpY2UgcHhiLXBjaWUsaWQ9
cGNpZS4yLGJ1c19ucj0xNixidXM9cGNpZS4wIFwNCj4gPiAtZGV2aWNlIHBjaWUtcm9vdC1wb3J0
LGlkPXBjaWUucG9ydDIsYnVzPXBjaWUuMixjaGFzc2lzPTIgXA0KPiA+IC1kZXZpY2UgYXJtLXNt
bXV2My1uZXN0ZWQsaWQ9c21tdXYyLHBjaS1idXM9cGNpZS4yIFwNCj4gPiAtZGV2aWNlIHZmaW8t
cGNpLGhvc3Q9MDAwMDo3NTowMC4xLGJ1cz1wY2llLnBvcnQyLGlvbW11ZmQ9aW9tbXVmZDAgXA0K
PiA+IC1hcHBlbmQgInJkaW5pdD1pbml0IGNvbnNvbGU9dHR5QU1BMCByb290PS9kZXYvdmRhMiBy
dw0KPiBlYXJseWNvbj1wbDAxMSwweDkwMDAwMDAiIFwNCj4gPiAtZGV2aWNlIHZpcnRpby05cC1w
Y2ksZnNkZXY9cDlmczIsbW91bnRfdGFnPXA5LGJ1cz1wY2llLjAgXA0KPiA+IC1mc2RldiBsb2Nh
bCxpZD1wOWZzMixwYXRoPXA5cm9vdCxzZWN1cml0eV9tb2RlbD1tYXBwZWQgXA0KPiA+IC1uZXQg
bm9uZSBcDQo+ID4gLW5vZ3JhcGhpYw0KPiANCj4gQWJvdmUgeW91IHNheSB0aGUgaG9zdCBoYXMg
MiBTTU1VdjMgZGV2aWNlcywgYW5kIHlvdSd2ZSBjcmVhdGVkIDINCj4gU01NVXYzDQo+IGd1ZXN0
IGRldmljZXMgdG8gbWF0Y2guDQo+IA0KPiBUaGUgdmFyaW91cyBlbWFpbHMgaW4gdGhpcyB0aHJl
YWQgJiBsaWJ2aXJ0IHRocmVhZCwgaW5kaWNhdGUgdGhhdCBlYWNoDQo+IGd1ZXN0IFNNTVV2MyBp
cyBhc3NvY2lhdGVkIHdpdGggYSBob3N0IFNNTVV2MywgYnV0IEkgZG9uJ3Qgc2VlIGFueQ0KPiBw
cm9wZXJ0eSBvbiB0aGUgY29tbWFuZCBsaW5lIGZvciAnYXJtLXNzbXYzLW5lc3RlZCcgdGhhdCB0
ZWxscyBpdCB3aGljaA0KPiBob3N0IGVTTU1VdjMgaXQgaXMgdG8gYmUgYXNzb2NpYXRlZCB3aXRo
Lg0KPiANCj4gSG93IGRvZXMgdGhpcyBhc3NvY2lhdGlvbiB3b3JrID8NCg0KWW91IGFyZSByaWdo
dC4gVGhlIGFzc29jaWF0aW9uIGlzIG5vdCB2ZXJ5IG9idmlvdXMgaW4gUWVtdS4gVGhlIGFzc29j
aWF0aW9uDQphbmQgY2hlY2tpbmcgaXMgZG9uZSBpbXBsaWNpdGx5IGJ5IGtlcm5lbCBhdCB0aGUg
bW9tZW50LiAgSSB3aWxsIHRyeSB0byBleHBsYWluDQppdCBoZXJlLg0KDQpFYWNoICJhcm0tc21t
dXYzLW5lc3RlZCIgaW5zdGFuY2UsIHdoZW4gdGhlIGZpcnN0IGRldmljZSBnZXRzIGF0dGFjaGVk
DQp0byBpdCwgd2lsbCBjcmVhdGUgYSBTMiBIV1BUIGFuZCBhIGNvcnJlc3BvbmRpbmcgU01NVXYz
IGRvbWFpbiBpbiBrZXJuZWwNClNNTVV2MyBkcml2ZXIuIFRoaXMgZG9tYWluIHdpbGwgaGF2ZSBh
IHBvaW50ZXIgcmVwcmVzZW50aW5nIHRoZSBwaHlzaWNhbA0KU01NVXYzIHRoYXQgdGhlIGRldmlj
ZSBiZWxvbmdzLiBBbmQgYW55IG90aGVyIGRldmljZSB3aGljaCBiZWxvbmdzIHRvDQp0aGUgc2Ft
ZSBwaHlzaWNhbCBTTU1VdjMgY2FuIHNoYXJlIHRoaXMgUzIgZG9tYWluLg0KDQpJZiBhIGRldmlj
ZSB0aGF0IGJlbG9uZ3MgdG8gYSBkaWZmZXJlbnQgcGh5c2ljYWwgU01NVXYzIGdldHMgYXR0YWNo
ZWQgdG8NCnRoZSBhYm92ZSBkb21haW4sIHRoZSBIV1BUIGF0dGFjaCB3aWxsIGV2ZW50dWFsbHkg
ZmFpbCBhcyB0aGUgcGh5c2ljYWwNCnNtbXV2MyBpbiB0aGUgZG9tYWlucyB3aWxsIGhhdmUgYSBt
aXNtYXRjaCwNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjEzL3NvdXJjZS9k
cml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jI0wyODYwDQoNCkFuZCBh
cyBJIG1lbnRpb25lZCBpbiBjb3ZlciBsZXR0ZXIsIFFlbXUgd2lsbCByZXBvcnQsDQoNCiINCkF0
dGVtcHQgdG8gYWRkIHRoZSBITlMgVkYgdG8gYSBkaWZmZXJlbnQgU01NVXYzIHdpbGwgcmVzdWx0
IGluLA0KDQotZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDAwMDo3ZDowMi4yLGJ1cz1wY2llLnBvcnQz
LGlvbW11ZmQ9aW9tbXVmZDA6IFVuYWJsZSB0byBhdHRhY2ggdmlvbW11DQotZGV2aWNlIHZmaW8t
cGNpLGhvc3Q9MDAwMDo3ZDowMi4yLGJ1cz1wY2llLnBvcnQzLGlvbW11ZmQ9aW9tbXVmZDA6IHZm
aW8gMDAwMDo3ZDowMi4yOg0KICAgRmFpbGVkIHRvIHNldCBpb21tdV9kZXZpY2U6IFtpb21tdWZk
PTI5XSBlcnJvciBhdHRhY2ggMDAwMDo3ZDowMi4yICgzOCkgdG8gaWQ9MTE6IEludmFsaWQgYXJn
dW1lbnQNCg0KQXQgcHJlc2VudCBRZW11IGlzIG5vdCBkb2luZyBhbnkgZXh0cmEgdmFsaWRhdGlv
biBvdGhlciB0aGFuIHRoZSBhYm92ZSANCmZhaWx1cmUgdG8gbWFrZSBzdXJlIHRoZSB1c2VyIGNv
bmZpZ3VyYXRpb24gaXMgY29ycmVjdCBvciBub3QuIFRoZQ0KYXNzdW1wdGlvbiBpcyBsaWJ2aXJ0
IHdpbGwgdGFrZSBjYXJlIG9mIHRoaXMuDQoiDQpTbyBpbiBzdW1tYXJ5LCBpZiB0aGUgbGlidmly
dCBnZXRzIGl0IHdyb25nLCBRZW11IHdpbGwgZmFpbCB3aXRoIGVycm9yLg0KDQpJZiBhIG1vcmUg
ZXhwbGljaXQgYXNzb2NpYXRpb24gaXMgcmVxdWlyZWQsIHNvbWUgaGVscCBmcm9tIGtlcm5lbCBp
cyByZXF1aXJlZA0KdG8gaWRlbnRpZnkgdGhlIHBoeXNpY2FsIFNNTVV2MyBhc3NvY2lhdGVkIHdp
dGggdGhlIGRldmljZS4gIA0KDQpKYXNvbi9OaWNvbGluLCBhbnkgdGhvdWdodHMgb24gdGhpcz8N
Cg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo=

