Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF815C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz4o-0004Nh-IP; Wed, 02 Jul 2025 11:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uWz4N-0004II-MW; Wed, 02 Jul 2025 11:08:21 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uWz4H-0001eQ-Rc; Wed, 02 Jul 2025 11:08:19 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXNVY6dBFz6L5XQ;
 Wed,  2 Jul 2025 23:05:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 5D96B1402EA;
 Wed,  2 Jul 2025 23:08:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Jul 2025 17:08:03 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 2 Jul 2025 17:08:02 +0200
To: Nathan Chen <nathanc@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "berrange@redhat.com" <berrange@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, jiangkunkun <jiangkunkun@huawei.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Linuxarm <linuxarm@huawei.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "smostafa@google.com"
 <smostafa@google.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v5 00/11] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Thread-Topic: [PATCH v5 00/11] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Thread-Index: AQHb5C8S0d/fYPGiP0CF8356U8e6vbQd79AAgAEM2gA=
Date: Wed, 2 Jul 2025 15:08:02 +0000
Message-ID: <ea936a5cdfcb4d6187d35794d1eb65fd@huawei.com>
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <81708f09-849a-4b01-9e4c-a854ae26eefb@nvidia.com>
In-Reply-To: <81708f09-849a-4b01-9e4c-a854ae26eefb@nvidia.com>
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
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmF0aGFuIENoZW4gPG5h
dGhhbmNAbnZpZGlhLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDIsIDIwMjUgMjowMiBB
TQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBiZXJyYW5nZUByZWRoYXQuY29t
OyBkZHV0aWxlQHJlZGhhdC5jb207IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsNCj4gZ3VzdGF2by5y
b21lcm9AbGluYXJvLm9yZzsgaW1hbW1lZG9AcmVkaGF0LmNvbTsgamdnQG52aWRpYS5jb207DQo+
IGppYW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0K
PiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdl
aS5jb20+Ow0KPiBtb2Noc0BudmlkaWEuY29tOyBuYXRoYW5jQG52aWRpYS5jb207IG5pY29saW5j
QG52aWRpYS5jb207DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcWVtdS1hcm1Abm9uZ251
Lm9yZzsgU2hhbWVlcmFsaSBLb2xvdGh1bQ0KPiBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPjsgc21vc3RhZmFAZ29vZ2xlLmNvbTsNCj4gV2FuZ3pob3UgKEIpIDx3
YW5nemhvdTFAaGlzaWxpY29uLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjUgMDAvMTFdIGh3L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3IgdXNl
ciBjcmVhdGFibGUNCj4gU01NVXYzIGRldmljZQ0KPiANCj4gPiAgICBUbyBhZGRyZXNzIHRoaXMs
IHBhdGNoICM2IGluIHRoZSBzZXJpZXMgaW50cm9kdWNlcyBhIG5ldyBoZWxwZXINCj4gPiAgICBm
dW5jdGlvbiBwY2lfc2V0dXBfaW9tbXVfcGVyX2J1cygpLCB3aGljaCBleHBsaWNpdGx5IHNldHMg
dGhlDQo+ID4gICAgaW9tbXVfcGVyX2J1cyBmaWVsZCBpbiB0aGUgUENJQnVzIHN0cnVjdHVyZS4g
VGhpcyBhbGxvd3MNCj4gPiAgICBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oKSB0byBy
ZXRyaWV2ZSBJT01NVSBvcHMgYmFzZWQNCj4gPiAgICBvbiB0aGUgc3BlY2lmaWMgYnVzLg0KPiA+
DQo+ID4gICAgVGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyBzdXBwb3J0IGZvciBhIHVzZXIt
Y3JlYXRhYmxlIFNNTVV2Mw0KPiBkZXZpY2UNCj4gPiAgICAoLWRldmljZSBhcm0tc21tdXYzKSBp
biBRRU1VLg0KPiANCj4gVGVzdGVkLWJ5OiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29t
Pg0KPiANCj4gSSByZS1yYW4gdGhlIHRlc3QgZnJvbSB2MyBbMF0gYW5kIGFtIGFibGUgdG8gY3Jl
YXRlIDE2IFNNTVV2MyBkZXZpY2VzIGluDQo+IGEgcWVtdSBWTSB3aXRoIGVtdWxhdGVkIGRldmlj
ZXMgcHJvcGVybHkgYXNzb2NpYXRlZCB3aXRoIHRoZSBndWVzdA0KPiBTTU1Vcw0KPiBpbiBndWVz
dCBzeXNmcyAtIHZlcmlmaWVkIHdpdGggc29tZSBndWVzdCBTTU1VcyBoYXZpbmcgdHdvIG9yIHRo
cmVlDQo+IGVtdWxhdGVkIE5JQ3MgYXNzaWduZWQgdG8gdGhlbSB3aGlsZSBvdGhlciBndWVzdCBT
TU1VcyBoYXZlIGEgbWluaW11bQ0KPiBvZg0KPiBvbmUgYXNzaWduZWQuDQo+IA0KPiBSZW1vdmlu
ZyBTTU1VdjMgZGV2aWNlcyBmcm9tIHRoZSBWTSBjb25maWcgZGVzY3JpYmVkIGFib3ZlLCBJIGRv
IG5vdA0KPiBvYnNlcnZlIHRoZSBwcm9ibGVtYXRpYyBiZWhhdmlvciB3aGVyZSBkZXZpY2VzIGJl
aGluZCBQWEJzIHdpdGhvdXQNCj4gU01NVXMNCj4gZXJyb25lb3VzbHkgdXNlIHRoZSBhZGRyZXNz
IHNwYWNlIGZyb20gcGNpZS4wJ3MgU01NVS4gSSByZW1vdmVkIFNNTVV2Mw0KPiBkZXZpY2VzIGZy
b20gUFhCcyB3aXRoIG9uZSwgdHdvLCBhbmQgdGhyZWUgZW11bGF0ZWQgTklDcyBhc3NpZ25lZCB0
bw0KPiB0aGVtLiBCZWxvdyBhcmUgdGhlIGd1ZXN0IHRvcG9sb2d5IGFuZCBxZW11IGNvbW1hbmQg
dXNlZCB3aGVyZQ0KPiBTTU1VdjMNCj4gZGV2aWNlcyBhcmUgZXhjbHVkZWQgZnJvbSB0aGUgb3Jp
Z2luYWwgdGVzdDoNCg0KQ29vbC4gQXBwcmVjaWF0ZSB0ZXN0aW5nIHRoYXQgc3BlY2lmaWNhbGx5
Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCg==

