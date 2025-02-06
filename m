Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82437C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg68I-0005CG-Qq; Thu, 06 Feb 2025 12:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tg68G-0005A3-AJ; Thu, 06 Feb 2025 12:57:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tg68D-0001A4-OX; Thu, 06 Feb 2025 12:57:43 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YplBK04D4z6M4KH;
 Fri,  7 Feb 2025 01:55:21 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 75B8E140A30;
 Fri,  7 Feb 2025 01:57:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Feb 2025 18:57:38 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 6 Feb 2025 18:57:38 +0100
To: Jason Gunthorpe <jgg@nvidia.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rMv66IAgAA0HqCAAb2VAIAIsUnQgAADD4CAAB6MsIAAJxaAgAATMvCAABLUAIAAAjUAgAAKIYCAABKiIA==
Date: Thu, 6 Feb 2025 17:57:38 +0000
Message-ID: <eb4375c4ca914b1887f5f8a501b93354@huawei.com>
References: <Z5uiGnAxUf4jXTEI@redhat.com>
 <7ecabe74e0514367baf28d67675e5db8@huawei.com> <Z51DmtP83741RAsb@redhat.com>
 <47d2c2556d794d87abf440263b2f7cd8@huawei.com> <Z6SQ3_5bcqseyzVa@redhat.com>
 <f898b6de4a664fe8810b06b7741e3120@huawei.com> <Z6TLSdwgajmHVmGH@redhat.com>
 <71116749d1234ab48a205fd2588151ec@huawei.com>
 <20250206170238.GG2960738@nvidia.com> <Z6TtCLQ35UI12T77@redhat.com>
 <20250206174647.GA3480821@nvidia.com>
In-Reply-To: <20250206174647.GA3480821@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.189]
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDYsIDIwMjUgNTo0
NyBQTQ0KPiBUbzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4g
Q2M6IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhv
ZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZzsgZXJpYy5hdWdlckByZWRoYXQuY29tOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7
IG5pY29saW5jQG52aWRpYS5jb207IGRkdXRpbGVAcmVkaGF0LmNvbTsNCj4gTGludXhhcm0gPGxp
bnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhvdSAoQikNCj4gPHdhbmd6aG91MUBoaXNpbGljb24u
Y29tPjsgamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+Ow0KPiBKb25hdGhhbiBD
YW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiB6aGFuZ2ZlaS5nYW9AbGlu
YXJvLm9yZzsgbmF0aGFuY0BudmlkaWEuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAv
NV0gaHcvYXJtL3ZpcnQ6IEFkZCBzdXBwb3J0IGZvciB1c2VyLWNyZWF0YWJsZQ0KPiBuZXN0ZWQg
U01NVXYzDQo+IA0KPiBPbiBUaHUsIEZlYiAwNiwgMjAyNSBhdCAwNToxMDozMlBNICswMDAwLCBE
YW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPiA+IE9uIFRodSwgRmViIDA2LCAyMDI1IGF0IDAx
OjAyOjM4UE0gLTA0MDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiA+IE9uIFRodSwgRmVi
IDA2LCAyMDI1IGF0IDAzOjA3OjA2UE0gKzAwMDAsIFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkN
Cj4gd3JvdGU6DQo+ID4gPiA+ID4gSWYgd2Ugc2V0IHRoZSBwaHlzaWNhbC9ndWVzdCBTTU1VIHJl
bGF0aW9uc2hpcCBkaXJlY3RseSwgdGhlbiBhdCB0aGUNCj4gPiA+ID4gPiB0aW1lIHRoZSBWRklP
IGRldmljZSBpcyBwbHVnZ2VkLCB3ZSBjYW4gZGlhZ25vc2UgdGhlIGluY29ycmVjdGx5DQo+ID4g
PiA+ID4gcGxhY2VkIFZGSU8gZGV2aWNlLCBhbmQgYmV0dGVyIHJlYXNvbiBhYm91dCBiZWhhdmlv
dXIuDQo+ID4gPiA+DQo+ID4gPiA+IEFncmVlLg0KPiA+ID4NCj4gPiA+IENhbiB5b3UganVzdCB0
YWtlIGluIGEgVkZJTyBjZGV2IEZEIHJlZmVyZW5jZSBvbiB0aGlzIGNvbW1hbmQgbGluZToNCj4g
PiA+DQo+ID4gPiAgLWRldmljZSBhcm0tc21tdXYzLWFjY2VsLGlkPXNtbXV2MixidXM9cGNpZS4y
DQo+ID4gPg0KPiA+ID4gQW5kIHRoYXQgd2lsbCBsb2NrIHRoZSBwU01NVS92U01NVSByZWxhdGlv
bnNoaXA/DQo+ID4NCj4gPiBXZSBzaG91bGRuJ3QgYXNzdW1lIGFueSBWRklPIGRldmljZSBleGlz
dHMgaW4gdGhlIFFFTVUgY25vZmlnIGF0IHRoZQ0KPiB0aW1lDQo+ID4gd2UgcmVhbGl6ZSB0aGUg
dmlydHVhbCBzc211LiBJIGV4cGVjdCB0aGUgU01NVSBtYXkgYmUgY29sZCBwbHVnZ2VkLA0KPiB3
aGlsZQ0KPiA+IHRoZSBWRklPIGRldmljZXMgbWF5IGJlIGhvdCBwbHVnZ2VkIGFyYml0cmFybHkg
bGF0ZXIsIGFuZCB3ZSBzaG91bGQgaGF2ZQ0KPiA+IHRoZSBhc3NvY2lhdGlvbiBpbml0aWFsaXpl
ZCB0aGUgU01NVSBpcyByZWFsaXplZC4NCj4gDQo+IFRoaXMgaXMgbm90IHN1cHBvcnRlZCBrZXJu
ZWwgc2lkZSwgeW91IGNhbid0IGluc3RhbnRpYXRlIGEgdklPTU1VDQo+IHdpdGhvdXQgYSBWRklP
IGRldmljZSB0aGF0IHVzZXMgaXQuIEZvciBzZWN1cml0eS4NCg0KSSB0aGluayB0aGF0IGlzIGZp
bmUgaWYgUWVtdSBrbm93cyBhYm91dCBhc3NvY2lhdGlvbiBiZWZvcmVoYW5kLiBEdXJpbmcgDQp2
SU9NTVUgaW5zdGFudGlhdGlvbiBpdCBjYW4gY3Jvc3MgY2hlY2sgd2hldGhlciB0aGUgdXNlciBz
cGVjaWZpZWQNCnBTTU1VIDwtPnZTTU1VIGlzIGNvcnJlY3QgZm9yIHRoZSBkZXZpY2UuDQoNCkFs
c28gaG93IGRvIHdlIGRvIGl0IHdpdGggbXVsdGlwbGUgVkYgZGV2aWNlcyB1bmRlciBhIHBTVU1N
VSA/IFdoaWNoDQpjZGV2IGZkIGluIHRoYXQgY2FzZT8gDQoNClRoYW5rcywNClNoYW1lZXINCg==

