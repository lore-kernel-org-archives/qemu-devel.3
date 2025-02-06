Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578AEC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6FN-0002Rw-Bv; Thu, 06 Feb 2025 13:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tg6FJ-0002R2-1n; Thu, 06 Feb 2025 13:05:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tg6FH-0002xj-E4; Thu, 06 Feb 2025 13:05:00 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YplNG3Mxnz6K8nW;
 Fri,  7 Feb 2025 02:03:58 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id 5B6BF1400DB;
 Fri,  7 Feb 2025 02:04:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Feb 2025 19:04:57 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 6 Feb 2025 19:04:57 +0100
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
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rMv66IAgAA0HqCAAb2VAIAIsUnQgAADD4CAAB6MsIAAJxaAgAATMvCAABLUAIAAAjUAgAAKIYCAAAJIgIAAAQ2AgAARRyA=
Date: Thu, 6 Feb 2025 18:04:57 +0000
Message-ID: <13b1d8b97a314cb28b87563fa9b45299@huawei.com>
References: <Z51DmtP83741RAsb@redhat.com>
 <47d2c2556d794d87abf440263b2f7cd8@huawei.com> <Z6SQ3_5bcqseyzVa@redhat.com>
 <f898b6de4a664fe8810b06b7741e3120@huawei.com> <Z6TLSdwgajmHVmGH@redhat.com>
 <71116749d1234ab48a205fd2588151ec@huawei.com>
 <20250206170238.GG2960738@nvidia.com> <Z6TtCLQ35UI12T77@redhat.com>
 <20250206174647.GA3480821@nvidia.com> <Z6T3cX_fM-aeYbMI@redhat.com>
 <20250206175843.GI2960738@nvidia.com>
In-Reply-To: <20250206175843.GI2960738@nvidia.com>
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
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDYsIDIwMjUgNTo1
OSBQTQ0KPiBUbzogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4g
Q2M6IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhv
ZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZzsgZXJpYy5hdWdlckByZWRoYXQuY29tOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7
IG5pY29saW5jQG52aWRpYS5jb207IGRkdXRpbGVAcmVkaGF0LmNvbTsNCj4gTGludXhhcm0gPGxp
bnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhvdSAoQikNCj4gPHdhbmd6aG91MUBoaXNpbGljb24u
Y29tPjsgamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+Ow0KPiBKb25hdGhhbiBD
YW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiB6aGFuZ2ZlaS5nYW9AbGlu
YXJvLm9yZzsgbmF0aGFuY0BudmlkaWEuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAv
NV0gaHcvYXJtL3ZpcnQ6IEFkZCBzdXBwb3J0IGZvciB1c2VyLWNyZWF0YWJsZQ0KPiBuZXN0ZWQg
U01NVXYzDQo+IA0KPiBPbiBUaHUsIEZlYiAwNiwgMjAyNSBhdCAwNTo1NDo1N1BNICswMDAwLCBE
YW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPiA+ID4gPiBXZSBzaG91bGRuJ3QgYXNzdW1lIGFu
eSBWRklPIGRldmljZSBleGlzdHMgaW4gdGhlIFFFTVUgY25vZmlnIGF0IHRoZQ0KPiB0aW1lDQo+
ID4gPiA+IHdlIHJlYWxpemUgdGhlIHZpcnR1YWwgc3NtdS4gSSBleHBlY3QgdGhlIFNNTVUgbWF5
IGJlIGNvbGQgcGx1Z2dlZCwNCj4gd2hpbGUNCj4gPiA+ID4gdGhlIFZGSU8gZGV2aWNlcyBtYXkg
YmUgaG90IHBsdWdnZWQgYXJiaXRyYXJseSBsYXRlciwgYW5kIHdlIHNob3VsZA0KPiBoYXZlDQo+
ID4gPiA+IHRoZSBhc3NvY2lhdGlvbiBpbml0aWFsaXplZCB0aGUgU01NVSBpcyByZWFsaXplZC4N
Cj4gPiA+DQo+ID4gPiBUaGlzIGlzIG5vdCBzdXBwb3J0ZWQga2VybmVsIHNpZGUsIHlvdSBjYW4n
dCBpbnN0YW50aWF0ZSBhIHZJT01NVQ0KPiA+ID4gd2l0aG91dCBhIFZGSU8gZGV2aWNlIHRoYXQg
dXNlcyBpdC4gRm9yIHNlY3VyaXR5Lg0KPiA+DQo+ID4gV2hhdCBhcmUgdGhlIHNlY3VyaXR5IGNv
bmNlcm5zIGhlcmUgPw0KPiANCj4gWW91IHNob3VsZCBub3QgYmUgYWJsZSB0byBvcGVuIGlvbW11
ZmQgYW5kIG1hbmlwdWxhdGUgaW9tbXUgSFcgdGhhdA0KPiB5b3UgZG9uJ3QgaGF2ZSBhIFZGSU8g
ZGVzY3JpcHRvciBmb3IsIGluY2x1ZGluZyBjcmVhdGluZyBwaHlzaWNhbA0KPiB2SU9NTVUgcmVz
b3VyY2VzLCBhbGxvY2F0aW5nIGNvbW1hbmQgcXVldWVzIGFuZCB3aGF0ZXZlciBlbHNlLg0KPiAN
Cj4gU29tZSBraW5kIG9mIGhvdCBwbHVnIHNtbXUgd291bGQgaGF2ZSB0byBjcmVhdGUgYSB2U01N
VSB3aXRob3V0IGFueQ0KPiBrZXJuZWwgYmFja2luZyBhbmQgdGhlbiBsYXRlciBiaW5kIGl0IHRv
IGEga2VybmVsIGltcGxlbWVudGF0aW9uLg0KDQpOb3Qgc3VyZSBJIGdldCB0aGUgcHJvYmxlbSB3
aXRoIGFzc29jaWF0aW5nIHZTTU1VIHdpdGggYSBwU01NVS4gU29tZXRoaW5nDQpsaWtlIGFuIGlv
bW11IGluc3RhbmNlIGlkIG1lbnRpb25lZCBiZWZvcmUsDQoNCi1kZXZpY2UgYXJtLXNtbXV2My1h
Y2NlbCxpZD1zbW11djIsYnVzPXBjaWUuMixob3N0LXNtbXU9aW9tbXUuMQ0KDQpUaGlzIGNhbiBy
ZWFsaXplIHRoZSB2U01NVSB3aXRob3V0IGFjdHVhbGx5IGNyZWF0aW5nIGEgdklPTU1VIGluIGtl
cm5lbC4NCkFuZCB3aGVuIHRoZSBkZXYgZ2V0cyBhdHRhY2hlZC9yZWFsaXplZCwgY2hlY2sgKEdF
VF9IV19JTkZPKXRoZSBzcGVjaWZpZWQNCmlvbW11IGluc3RhbmNlIGlkIG1hdGNoZXMgb3Igbm90
Lg0KDQpPciB0aGUgY29uY2VybiBoZXJlIGlzIGV4cG9ydGluZyBhbiBpb21tdSBpbnN0YW5jZSBp
ZCB0byB1c2VyIHNwYWNlPw0KDQpUaGFua3MsDQpTaGFtZWVyDQogDQo=

