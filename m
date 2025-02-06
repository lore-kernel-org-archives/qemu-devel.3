Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D143C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 10:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyiS-00047q-0z; Thu, 06 Feb 2025 05:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tfyiO-00047V-RX; Thu, 06 Feb 2025 05:02:32 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tfyiL-0006ol-I4; Thu, 06 Feb 2025 05:02:32 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YpXgX049Cz6HJrv;
 Thu,  6 Feb 2025 18:01:28 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id E52A3140D1A;
 Thu,  6 Feb 2025 18:02:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Feb 2025 11:02:25 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 6 Feb 2025 11:02:25 +0100
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
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rMv66IAgAA0HqCAAb2VAIAIsUnQ
Date: Thu, 6 Feb 2025 10:02:25 +0000
Message-ID: <47d2c2556d794d87abf440263b2f7cd8@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com> <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <Z51DmtP83741RAsb@redhat.com>
In-Reply-To: <Z51DmtP83741RAsb@redhat.com>
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

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSmFu
dWFyeSAzMSwgMjAyNSA5OjQyIFBNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxz
aGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IENjOiBxZW11LWFybUBub25n
bnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsg
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZpZGlhLmNvbTsNCj4gbmljb2xpbmNAbnZp
ZGlhLmNvbTsgZGR1dGlsZUByZWRoYXQuY29tOyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVhd2Vp
LmNvbT47IFdhbmd6aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+Ow0KPiBqaWFuZ2t1
bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0
aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUkZDIFBBVENIIDAvNV0gaHcvYXJtL3ZpcnQ6IEFkZCBzdXBwb3J0IGZvciB1c2Vy
LWNyZWF0YWJsZQ0KPiBuZXN0ZWQgU01NVXYzDQo+IA0KPiBPbiBUaHUsIEphbiAzMCwgMjAyNSBh
dCAwNjowOToyNFBNICswMDAwLCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IHdyb3RlOg0K
PiA+DQo+ID4gRWFjaCAiYXJtLXNtbXV2My1uZXN0ZWQiIGluc3RhbmNlLCB3aGVuIHRoZSBmaXJz
dCBkZXZpY2UgZ2V0cyBhdHRhY2hlZA0KPiA+IHRvIGl0LCB3aWxsIGNyZWF0ZSBhIFMyIEhXUFQg
YW5kIGEgY29ycmVzcG9uZGluZyBTTU1VdjMgZG9tYWluIGluDQo+IGtlcm5lbA0KPiA+IFNNTVV2
MyBkcml2ZXIuIFRoaXMgZG9tYWluIHdpbGwgaGF2ZSBhIHBvaW50ZXIgcmVwcmVzZW50aW5nIHRo
ZSBwaHlzaWNhbA0KPiA+IFNNTVV2MyB0aGF0IHRoZSBkZXZpY2UgYmVsb25ncy4gQW5kIGFueSBv
dGhlciBkZXZpY2Ugd2hpY2ggYmVsb25ncyB0bw0KPiA+IHRoZSBzYW1lIHBoeXNpY2FsIFNNTVV2
MyBjYW4gc2hhcmUgdGhpcyBTMiBkb21haW4uDQo+IA0KPiBPaywgc28gZ2l2ZW4gdHdvIGd1ZXN0
IFNNTVV2M3MsICAgQSBhbmQgQiwgYW5kIHR3byBob3N0IFNNTVV2M3MsDQo+IEMgYW5kIEQsIHdl
IGNvdWxkIGVuZCB1cCB3aXRoIEEmQyBhbmQgQiZEIHBhaXJlZCwgb3Igd2UgY291bGQNCj4gZW5k
IHVwIHdpdGggQSZEIGFuZCBCJkMgcGFpcmVkLCBkZXBlbmRpbmcgb24gd2hldGhlciB3ZSBwbHVn
DQo+IHRoZSBmaXJzdCBWRklPIGRldmljZSBpbnRvIGd1ZXN0IFNNTVV2MyAgQSBvciBCLg0KPiAN
Cj4gVGhpcyBpcyBiYWQuICBCZWhhdmlvdXIgbXVzdCBub3QgdmFyeSBkZXBlbmRpbmcgb24gdGhl
IG9yZGVyDQo+IGluIHdoaWNoIHdlIGNyZWF0ZSBkZXZpY2VzLg0KPiANCj4gQW4gZ3Vlc3QgU01N
VXYzIGlzIHBhaXJlZCB0byBhIGd1ZXN0IFBYQi4gQSBndWVzdCBQWEIgaXMgbGlhYmxlDQo+IHRv
IGJlIHBhaXJlZCB0byBhIGd1ZXN0IE5VTUEgbm9kZS4gQSBndWVzdCBOVU1BIG5vZGUgaXMgbGlh
YmxlDQo+IHRvIGJlIHBhaXJlZCB0byBob3N0IE5VTUEgbm9kZS4gVGhlIGd1ZXN0L2hvc3QgU01N
VSBwYWlyaW5nDQo+IG11c3QgYmUgY2hvc2VuIHN1Y2ggdGhhdCBpdCBtYWtlcyBjb25jZXB0dWFs
IHNlbnNlIHdydCB0byB0aGUNCj4gZ3Vlc3QgUFhCIE5VTUEgdG8gaG9zdCBOVU1BIHBhaXJpbmcu
DQo+IA0KPiBJZiB0aGUga2VybmVsIHBpY2tzIGd1ZXN0PC0+aG9zdCBTTU1VIHBhaXJpbmdzIG9u
IGEgZmlyc3QtZGV2aWNlDQo+IGZpcnN0LXBhaXJlZCBiYXNpcywgdGhpcyBjYW4gZW5kIHVwIHdp
dGggaW5jb3JyZWN0IGd1ZXN0IE5VTUENCj4gY29uZmlndXJhdGlvbnMuDQoNCk9rLiBJIGFtIHRy
eWluZyB0byB1bmRlcnN0YW5kIGhvdyB0aGlzIGNhbiBoYXBwZW4gYXMgSSBhc3N1bWUgdGhlDQpH
dWVzdCBQWEIgbnVtYSBub2RlIGlzIHBpY2tlZCB1cCBieSB3aGF0ZXZlciBkZXZpY2Ugd2UgYXJl
DQphdHRhY2hpbmcgdG8gaXQgYW5kIGJhc2VkIG9uIHdoaWNoIG51bWFfaWQgdGhhdCBkZXZpY2Ug
YmVsb25ncyB0bw0KaW4gcGh5c2ljYWwgaG9zdC4NCg0KQW5kIHRoZSBwaHlzaWNhbCBzbW11djMg
bnVtYSBpZCB3aWxsIGJlIHRoZSBzYW1lIHRvIHRoYXQgb2YgdGhlDQpkZXZpY2UgbnVtYV9pZCAg
aXQgaXMgYXNzb2NpYXRlZCB3aXRoLiBJc24ndCBpdD8NCg0KRm9yIGV4YW1wbGUgSSBoYXZlIGEg
c3lzdGVtIGhlcmUsIHRoYXQgaGFzIDggcGh5cyBTTU1VdjNzIGFuZCBudW1hDQphc3NpZ25tZW50
cyBvbiB0aGlzIGlzIHNvbWV0aGluZyBsaWtlIGJlbG93LA0KDQpQaHlzIFNNTVV2My4wIC0tPiBu
b2RlIDANCiAgXC4uZGV2MSAtLT4gbm9kZTANClBoeXMgU01NVXYzLjEgLS0+IG5vZGUgMA0KXC4u
ZGV2MiAtLT5ub2RlMA0KUGh5cyBTTU1VdjMuMiAtLT4gbm9kZSAwDQpQaHlzIFNNTVV2My4zIC0t
PiBub2RlIDANCg0KUGh5cyBTTU1VdjMuNCAtLT4gbm9kZSAxDQpQaHlzIFNNTVV2My41IC0tPiBu
b2RlIDENClwuLmRldjUgLS0+IG5vZGUxDQpQaHlzIFNNTVV2My42IC0tPiBub2RlIDENClBoeXMg
U01NVXYzLjcgLS0+IG5vZGUgMQ0KDQoNCklmIEkgaGF2ZSB0byBhc3NpZ24gc2F5IGRldiAxLCAy
IGFuZCA1IHRvIGEgR3Vlc3QsIHdlIG5lZWQgdG8gc3BlY2lmeSAzDQogImFybS1zbW11djMtYWNj
ZWwiIGluc3RhbmNlcyBhcyB0aGV5IGJlbG9uZyB0byBkaWZmZXJlbnQgcGh5cyBTTU1VdjNzLg0K
DQotZGV2aWNlIHB4Yi1wY2llLGlkPXBjaWUuMSxidXNfbnI9MSxidXM9cGNpZS4wLG51bWFfaWQ9
MCBcDQotZGV2aWNlIHB4Yi1wY2llLGlkPXBjaWUuMixidXNfbnI9MixidXM9cGNpZS4wLG51bWFf
aWQ9MCBcDQotZGV2aWNlIHB4Yi1wY2llLGlkPXBjaWUuMyxidXNfbnI9MyxidXM9cGNpZS4wLG51
bWFfaWQ9MSBcDQotZGV2aWNlIGFybS1zbW11djMtYWNjZWwsaWQ9c21tdXYxLGJ1cz1wY2llLjEg
XA0KLWRldmljZSBhcm0tc21tdXYzLWFjY2VsLGlkPXNtbXV2MixidXM9cGNpZS4yIFwNCi1kZXZp
Y2UgYXJtLXNtbXV2My1hY2NlbCxpZD1zbW11djMsYnVzPXBjaWUuMyBcDQotZGV2aWNlIHBjaWUt
cm9vdC1wb3J0LGlkPXBjaWUucG9ydDEsYnVzPXBjaWUuMSxjaGFzc2lzPTEgXA0KLWRldmljZSBw
Y2llLXJvb3QtcG9ydCxpZD1wY2llLnBvcnQyLGJ1cz1wY2llLjMsY2hhc3Npcz0yIFwNCi1kZXZp
Y2UgcGNpZS1yb290LXBvcnQsaWQ9cGNpZS5wb3J0MyxidXM9cGNpZS4yLGNoYXNzaXM9MyBcDQot
ZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDAwMDpkZXYxLGJ1cz1wY2llLnBvcnQxLGlvbW11ZmQ9aW9t
bXVmZDAgXA0KLWRldmljZSB2ZmlvLXBjaSxob3N0PTAwMDA6IGRldjIsYnVzPXBjaWUucG9ydDIs
aW9tbXVmZD1pb21tdWZkMCBcDQotZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDAwMDogZGV2NSxidXM9
cGNpZS5wb3J0Myxpb21tdWZkPWlvbW11ZmQwDQoNClNvIEkgZ3Vlc3MgZXZlbiBpZiB3ZSBkb24n
dCBzcGVjaWZ5IHRoZSBwaHlzaWNhbCBTTU1VdjMgYXNzb2NpYXRpb24NCmV4cGxpY2l0bHksIHRo
ZSBrZXJuZWwgd2lsbCBjaGVjayB0aGF0IGJhc2VkIG9uIHRoZSBkZXZpY2VzIHRoZSBHdWVzdA0K
U01NVXYzIGlzIGF0dGFjaGVkIHRvIChhbmQgaGVuY2UgdGhlIE51bWEgYXNzb2NpYXRpb24pLCBy
aWdodD8NCg0KSW4gb3RoZXIgd29yZHMgaG93IGFuIGV4cGxpY2l0IGFzc29jaWF0aW9uIGhlbHBz
IHVzIGhlcmU/DQoNCk9yIGlzIGl0IHRoYXQgdGhlIEd1ZXN0IFBYQiBudW1hX2lkIGFsbG9jYXRp
b24gaXMgbm90IGFsd2F5cyBiYXNlZA0Kb24gZGV2aWNlIG51bWFfaWQ/DQoNCihNYXkgYmUgSSBh
bSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlLiBTb3JyeSkNCg0KVGhhbmtzLA0KU2hhbWVlciANCg0K
DQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCiANCj4gVGhlIG1nbXQgYXBwcyBuZWVkcyB0byBi
ZSBhYmxlIHRvIHRlbGwgUUVNVSBleGFjdGx5IHdoaWNoDQo+IGhvc3QgU01NVSB0byBwYWlyIHdp
dGggZWFjaCBndWVzdCBTTU1VLCBhbmQgUUVNVSBuZWVkcyB0bw0KPiB0aGVuIHRlbGwgdGhlIGtl
cm5lbC4NCj4gDQo+ID4gQW5kIGFzIEkgbWVudGlvbmVkIGluIGNvdmVyIGxldHRlciwgUWVtdSB3
aWxsIHJlcG9ydCwNCj4gPg0KPiA+ICINCj4gPiBBdHRlbXB0IHRvIGFkZCB0aGUgSE5TIFZGIHRv
IGEgZGlmZmVyZW50IFNNTVV2MyB3aWxsIHJlc3VsdCBpbiwNCj4gPg0KPiA+IC1kZXZpY2UgdmZp
by1wY2ksaG9zdD0wMDAwOjdkOjAyLjIsYnVzPXBjaWUucG9ydDMsaW9tbXVmZD1pb21tdWZkMDoN
Cj4gVW5hYmxlIHRvIGF0dGFjaCB2aW9tbXUNCj4gPiAtZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDAw
MDo3ZDowMi4yLGJ1cz1wY2llLnBvcnQzLGlvbW11ZmQ9aW9tbXVmZDA6DQo+IHZmaW8gMDAwMDo3
ZDowMi4yOg0KPiA+ICAgIEZhaWxlZCB0byBzZXQgaW9tbXVfZGV2aWNlOiBbaW9tbXVmZD0yOV0g
ZXJyb3IgYXR0YWNoIDAwMDA6N2Q6MDIuMg0KPiAoMzgpIHRvIGlkPTExOiBJbnZhbGlkIGFyZ3Vt
ZW50DQo+ID4NCj4gPiBBdCBwcmVzZW50IFFlbXUgaXMgbm90IGRvaW5nIGFueSBleHRyYSB2YWxp
ZGF0aW9uIG90aGVyIHRoYW4gdGhlIGFib3ZlDQo+ID4gZmFpbHVyZSB0byBtYWtlIHN1cmUgdGhl
IHVzZXIgY29uZmlndXJhdGlvbiBpcyBjb3JyZWN0IG9yIG5vdC4gVGhlDQo+ID4gYXNzdW1wdGlv
biBpcyBsaWJ2aXJ0IHdpbGwgdGFrZSBjYXJlIG9mIHRoaXMuDQo+ID4gIg0KPiA+IFNvIGluIHN1
bW1hcnksIGlmIHRoZSBsaWJ2aXJ0IGdldHMgaXQgd3JvbmcsIFFlbXUgd2lsbCBmYWlsIHdpdGgg
ZXJyb3IuDQo+IA0KPiBUaGF0J3MgZ29vZCBlcnJvciBjaGVja2luZywgYW5kIHJlcXVpcmVkLCBi
dXQgYWxzbyBpbnN1ZmZpY2llbnQNCj4gYXMgaWxsdXN0cmF0ZWQgYWJvdmUgSU1ITy4NCj4gDQo+
ID4gSWYgYSBtb3JlIGV4cGxpY2l0IGFzc29jaWF0aW9uIGlzIHJlcXVpcmVkLCBzb21lIGhlbHAg
ZnJvbSBrZXJuZWwgaXMNCj4gcmVxdWlyZWQNCj4gPiB0byBpZGVudGlmeSB0aGUgcGh5c2ljYWwg
U01NVXYzIGFzc29jaWF0ZWQgd2l0aCB0aGUgZGV2aWNlLg0KPiANCj4gWWVwLCBJIHRoaW5rIFNN
TVV2MyBpbmZvIGZvciBkZXZpY2VzIG5lZWRzIHRvIGJlIGV4cG9zZWQgdG8gdXNlcnNwYWNlLA0K
PiBhcyB3ZWxsIGFzIGEgbWVjaGFuaXNtIGZvciBRRU1VIHRvIHRlbGwgdGhlIGtlcm5lbCB0aGUg
U01NVSBtYXBwaW5nLg0KPiANCj4gDQo+IFdpdGggcmVnYXJkcywNCj4gRGFuaWVsDQo+IC0tDQo+
IHw6IGh0dHBzOi8vYmVycmFuZ2UuY29tICAgICAgLW8tICAgIGh0dHBzOi8vd3d3LmZsaWNrci5j
b20vcGhvdG9zL2RiZXJyYW5nZQ0KPiA6fA0KPiB8OiBodHRwczovL2xpYnZpcnQub3JnICAgICAg
ICAgLW8tICAgICAgICAgICAgaHR0cHM6Ly9mc3RvcDEzOC5iZXJyYW5nZS5jb20gOnwNCj4gfDog
aHR0cHM6Ly9lbnRhbmdsZS1waG90by5vcmcgICAgLW8tDQo+IGh0dHBzOi8vd3d3Lmluc3RhZ3Jh
bS5jb20vZGJlcnJhbmdlIDp8DQo+IA0KDQo=

