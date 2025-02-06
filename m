Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFB6C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3TJ-0004sQ-RS; Thu, 06 Feb 2025 10:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tg3TG-0004rA-Dk; Thu, 06 Feb 2025 10:07:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tg3TD-0008Bq-QB; Thu, 06 Feb 2025 10:07:14 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YpgP53nmqz6L55V;
 Thu,  6 Feb 2025 23:04:25 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 4FB71140534;
 Thu,  6 Feb 2025 23:07:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Feb 2025 16:07:07 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 6 Feb 2025 16:07:07 +0100
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rMv66IAgAA0HqCAAb2VAIAIsUnQgAADD4CAAB6MsIAAJxaAgAATMvA=
Date: Thu, 6 Feb 2025 15:07:06 +0000
Message-ID: <71116749d1234ab48a205fd2588151ec@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com> <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <Z51DmtP83741RAsb@redhat.com> <47d2c2556d794d87abf440263b2f7cd8@huawei.com>
 <Z6SQ3_5bcqseyzVa@redhat.com> <f898b6de4a664fe8810b06b7741e3120@huawei.com>
 <Z6TLSdwgajmHVmGH@redhat.com>
In-Reply-To: <Z6TLSdwgajmHVmGH@redhat.com>
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
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDYs
IDIwMjUgMjo0NyBQTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFs
aS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiBDYzogcWVtdS1hcm1Abm9uZ251Lm9yZzsg
cWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBlcmljLmF1Z2VyQHJlZGhhdC5jb207IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207DQo+IG5pY29saW5jQG52aWRpYS5jb207
IGRkdXRpbGVAcmVkaGF0LmNvbTsgTGludXhhcm0NCj4gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBX
YW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsNCj4gamlhbmdrdW5rdW4gPGpp
YW5na3Vua3VuQGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1l
cm9uQGh1YXdlaS5jb20+OyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsNCj4gbmF0aGFuY0Budmlk
aWEuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAvNV0gaHcvYXJtL3ZpcnQ6IEFkZCBz
dXBwb3J0IGZvciB1c2VyLWNyZWF0YWJsZQ0KPiBuZXN0ZWQgU01NVXYzDQo+IA0KPiBPbiBUaHUs
IEZlYiAwNiwgMjAyNSBhdCAwMTo1MToxNVBNICswMDAwLCBTaGFtZWVyYWxpIEtvbG90aHVtIFRo
b2RpDQo+IHdyb3RlOg0KPiA+IEhtbS4uSSBkb27igJl0IHRoaW5rIGp1c3Qgc3dhcHBpbmcgdGhl
IG9yZGVyIHdpbGwgY2hhbmdlIHRoZSBhc3NvY2lhdGlvbg0KPiB3aXRoDQo+ID4gR3Vlc3QgU01N
VSBoZXJlLiBCZWNhdXNlLCB3ZSBoYXZlLA0KPiA+DQo+ID4gPiAgLWRldmljZSBhcm0tc21tdXYz
LWFjY2VsLGlkPXNtbXV2MixidXM9cGNpZS4yDQo+ID4NCj4gPiBEdXJpbmcgc21tdXYzLWFjY2Vs
IHJlYWxpemUgdGltZSwgdGhpcyB3aWxsIHJlc3VsdCBpbiwNCj4gPiAgcGNpX3NldHVwX2lvbW11
KHByaW1hcnlfYnVzLCBvcHMsIHNtbXVfc3RhdGUpOw0KPiA+DQo+ID4gQW5kIHdoZW4gdGhlIHZm
aW8gZGV2IHJlYWxpemF0aW9uIGhhcHBlbnMsDQo+ID4gIHNldF9pb21tdV9kZXZpY2UoKQ0KPiA+
ICAgIHNtbXVfZGV2X3NldF9pb21tdV9kZXZpY2UoYnVzLCBzbW11X3N0YXRlLCAsKQ0KPiA+ICAg
ICAgIC0tPiB0aGlzIGlzIHdoZXJlIHRoZSBndWVzdCBzbW11djMtLT5ob3N0IHNtbXV2MyBhc3Nv
Y2lhdGlvbiBpcyBmaXJzdA0KPiA+ICAgICAgICAgICAgIGVzdGFibGlzaGVkLiBBbmQgYW55IGZ1
cnRoZXIgdmZpbyBkZXYgdG8gdGhpcyBHdWVzdCBTTU1VIHdpbGwNCj4gPiAgICAgICAgICAgICBv
bmx5IHN1Y2NlZWRzIGlmIGl0IGJlbG9uZ3MgdG8gdGhlIHNhbWUgcGh5cyBTTU1VLg0KPiA+DQo+
ID4gaWUsIHRoZSBHdWVzdCBTTU1VIHRvIHBjaSBidXMgYXNzb2NpYXRpb24sIGFjdHVhbGx5IG1h
a2Ugc3VyZSB5b3UgaGF2ZQ0KPiB0aGUNCj4gPiBzYW1lIEd1ZXN0IFNNTVUgZm9yIHRoZSBkZXZp
Y2UuDQo+IA0KPiBPaywgc28gYXQgdGltZSBvZiBWRklPIGRldmljZSByZWFsaXplLCBRRU1VIGlz
IHRlbGxpbmcgdGhlIGtlcm5lbA0KPiB0byBhc3NvY2lhdGUgYSBwaHlzaWNhbCBTTU1VLCBhbmQg
aXRzIGRvaW5nIHRoaXMgd2l0aCB0aGUgdmlydHVhbA0KPiBTTU1VIGF0dGFjaGVkIHRvIFBYQiBw
YXJlbnRpbmcgdGhlIFZGSU8gZGV2aWNlLg0KPiANCj4gPiBzbW11djIgLS0+IHBjaWUuMiAtLT4g
KHB4Yi1wY2llLCBudW1hX2lkID0gMSkNCj4gPiAwMDAwOmRldjIgLS0+ICBwY2llLnBvcnQyIC0t
PiBwY2llLjIgLS0+IHNtbXV2MiAocHhiLXBjaWUsIG51bWFfaWQgPSAxKQ0KPiA+DQo+ID4gSGVu
Y2UgdGhlIGFzc29jaWF0aW9uIG9mIDAwMDA6ZGV2MiB0byBHdWVzdCBTTU1VdjIgcmVtYWluIHNh
bWUuDQo+IA0KPiBZZXMsIEkgY29uY3VyIHRoZSBTTU1VIHBoeXNpY2FsIDwtPiB2aXJ0dWFsIGFz
c29jaWF0aW9uIHNob3VsZA0KPiBiZSBmaXhlZCwgYXMgbG9uZyBhcyB0aGUgc2FtZSBWRklPIGRl
dmljZSBpcyBhbHdheXMgYWRkZWQgdG8NCj4gdGhlIHNhbWUgdmlydHVhbCBTTU1VLg0KPiANCj4g
PiBJIGhvcGUgdGhpcyBpcyBjbGVhci4gQW5kIEkgYW0gbm90IHN1cmUgdGhlIGFzc29jaWF0aW9u
IHdpbGwgYmUgYnJva2VuIGluDQo+IGFueQ0KPiA+IG90aGVyIHdheSB1bmxlc3MgUWVtdSBDTEkg
c3BlY2lmeSB0aGUgZGV2IHRvIGEgZGlmZmVyZW50IFBYQi4NCj4gDQo+IEFsdGhvdWdoIHRoZSBv
cmRlcmluZyBpcyBhdCBsZWFzdCBwcmVkaWN0YWJsZSwgSSByZW1haW4gdW5jb21mb3J0YWJsZQ0K
PiBhYm91dCB0aGUgaWRlYSBvZiB0aGUgdmlydHVhbCBTTU1VIGFzc29jaWF0aW9uIHdpdGggdGhl
IHBoeXNpY2FsIFNNTVUNCj4gYmVpbmcgYSBzaWRlIGVmZmVjdCBvZiB0aGUgVkZJTyBkZXZpY2Ug
cGxhY2VtZW50Lg0KPiANCj4gVGhlcmUgaXMgc3RpbGwgdGhlIG9wZW4gZG9vciBmb3IgYWRtaW4g
bWlzLWNvbmZpZ3VyYXRpb24gdGhhdCB3aWxsIG5vdA0KPiBiZSBkaWFnbm9zZWQuIGVnIGNvbnNp
ZGVyIHdlIGF0dGFjaGVkIFZGSU8gZGV2aWNlIDEgZnJvbSB0aGUgaG9zdCBOVU1BDQo+IG5vZGUg
MSB0byAgYSBQWEIgYXNzb2NpYXRlZCB3aXRoIGhvc3QgTlVNQSBub2RlIDAuIEFzIGxvbmcgYXMg
dGhhdCdzDQo+IHRoZSBmaXJzdCBWRklPIGRldmljZSwgdGhlIGtlcm5lbCB3aWxsIGhhcHBpbHkg
YXNzb2NpYXRlIHRoZSBwaHlzaWNhbA0KPiBhbmQgZ3Vlc3QgU01NVXMuDQoNClllcy4gQSBtaXMt
Y29uZmlndXJhdGlvbiBjYW4gcGxhY2UgaXQgb24gYSB3cm9uZyBvbmUuIA0KIA0KPiBJZiB3ZSBz
ZXQgdGhlIHBoeXNpY2FsL2d1ZXN0IFNNTVUgcmVsYXRpb25zaGlwIGRpcmVjdGx5LCB0aGVuIGF0
IHRoZQ0KPiB0aW1lIHRoZSBWRklPIGRldmljZSBpcyBwbHVnZ2VkLCB3ZSBjYW4gZGlhZ25vc2Ug
dGhlIGluY29ycmVjdGx5DQo+IHBsYWNlZCBWRklPIGRldmljZSwgYW5kIGJldHRlciByZWFzb24g
YWJvdXQgYmVoYXZpb3VyLg0KDQpBZ3JlZS4NCg0KPiBJJ3ZlIGFub3RoZXIgcXVlc3Rpb24gYWJv
dXQgdW5wbHVnIGJlaGF2aW91ci4uDQo+IA0KPiAgMS4gUGx1ZyBhIFZGSU8gZGV2aWNlIGZvciBo
b3N0IFNNTVUgMSBpbnRvIGEgUFhCIHdpdGggZ3Vlc3QgU01NVSAxLg0KPiAgICAgICA9PiBLZXJu
ZWwgYXNzb2NpYXRlcyBob3N0IFNNTVUgMSBhbmQgZ3Vlc3QgU01NVSAxIHRvZ2V0aGVyDQo+ICAy
LiBVbnBsdWcgdGhpcyBWRklPIGRldmljZQ0KPiAgMy4gUGx1ZyBhIFZGSU8gZGV2aWNlIGZvciBo
b3N0IFNNTVUgMiBpbnRvIGEgUFhCIHdpdGggZ3Vlc3QgU01NVSAxLg0KPiANCj4gRG9lcyB0aGUg
aG9zdC9ndWVzdCBTTU1VIDE8LT4gMSBhc3NvY2lhdGlvbiByZW1haW4gc2V0IGFmdGVyIHN0ZXAg
MiwNCj4gaW1wbHlpbmcgc3RlcCAzIHdpbGwgZmFpbCA/IE9yIGRvZXMgaXQgZ2V0IHVuc2V0LCBh
bGxvd2luZyBzdGVwIDMNCj4gdG8gc3VjY2VlZCwgYW5kIGVzdGFibGlzaCBhIG5ldyBtYXBwaW5n
IGhvc3QgU01NVSAyIHRvIGd1ZXN0IFNNTVUgMS4NCg0KQXQgdGhlIG1vbWVudCB0aGUgZmlyc3Qg
YXNzb2NpYXRpb24gaXMgbm90IHBlcnNpc3RlbnQuIFNvIGEgbmV3IG1hcHBpbmcgDQppcyBwb3Nz
aWJsZS4NCiANCj4gSWYgc3RlcCAyIGRvZXMgTk9UIGJyZWFrIHRoZSBhc3NvY2lhdGlvbiwgZG8g
d2UgcHJlc2VydmUgdGhhdA0KPiBhY3Jvc3MgYSBzYXZldm0rbG9hZHZtIHNlcXVlbmNlIG9mIFFF
TVUuIElmIHdlIGRvbid0LCB0aGVuIHN0ZXANCj4gMyB3b3VsZCBmYWlsIGJlZm9yZSB0aGUgc2F2
ZXZtLCBidXQgc3VjY2VlZCBhZnRlciB0aGUgbG9hZHZtLg0KDQpSaWdodC4gSSBoYXZlbid0IGF0
dGVtcHRlZCBtaWdyYXRpb24gdGVzdHMgeWV0LiBCdXQgYWdyZWUgdGhhdCBhbiANCmV4cGxpY2l0
IGFzc29jaWF0aW9uIGlzIGJldHRlciB0byBtYWtlIG1pZ3JhdGlvbiBjb21wYXRpYmxlLiBBbHNv
DQpJIGFtIG5vdCBzdXJlIGlmIHRoZSB0YXJnZXQgaGFzIGEgZGlmZmVyZW50IHBoeXMgU01NVVYz
PC0tPiBkZXYNCm1hcHBpbmcgaG93IHdlIGhhbmRsZSB0aGF0Lg0KDQo+IEV4cGxpY2l0bHkgcmVw
cmVzZW50aW5nIHRoZSBob3N0IFNNTVUgYXNzb2NpYXRpb24gb24gdGhlIGd1ZXN0IFNNTVUNCj4g
Y29uZmlnIG1ha2VzIHRoaXMgYmVoYXZpb3VyIHVuYW1iaWd1b3VzLiBUaGUgaG9zdCAvIGd1ZXN0
IFNNTVUNCj4gcmVsYXRpb25zaGlwIGlzIGZpeGVkIGZvciB0aGUgbGlmZXRpbWUgb2YgdGhlIFZN
IGFuZCBpbnZhcmlhbnQgb2YNCj4gd2hhdGV2ZXIgVkZJTyBkZXZpY2UgaXMgKG9yIHdhcyBwcmV2
aW91c2x5KSBwbHVnZ2VkLg0KPiANCj4gU28gSSBzdGlsbCBnbyBiYWNrIHRvIG15IGdlbmVyYWwg
cHJpbmNpcGxlIHRoYXQgYXV0b21hdGljIHNpZGUgZWZmZWN0cw0KPiBhcmUgYW4gdW5kZXNpcmFi
bGUgaWRlYSBpbiBRRU1VIGNvbmZpZ3VyYXRpb24uIFdlIGhhdmUgYSBsb25nIHRyYWRpdGlvbg0K
PiBvZiBtYWtpbmcgZXZlcnl0aGluZyBlbnRpcmVseSBleHBsaWNpdCB0byBwcm9kdWNlIGVhc2ls
eSBwcmVkaWN0YWJsZQ0KPiBiZWhhdmlvdXIuDQoNCk9rLiBDb252aW5jZWQg8J+Yii4gVGhhbmtz
IGZvciBleHBsYWluaW5nLg0KDQpTaGFtZWVyDQo=

