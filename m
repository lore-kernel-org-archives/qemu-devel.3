Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DE5C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 15:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp7dD-0004EF-VG; Mon, 03 Mar 2025 10:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tp7ca-000491-0p; Mon, 03 Mar 2025 10:22:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tp7cP-0004aS-Nr; Mon, 03 Mar 2025 10:22:13 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z62XR3mXbz6H7Kh;
 Mon,  3 Mar 2025 23:19:03 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id E5F2E140A86;
 Mon,  3 Mar 2025 23:21:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Mar 2025 16:21:57 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 3 Mar 2025 16:21:57 +0100
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rLkOMCAgAAM2QCAAAz2gIAEhqeggCVVAYCAI176AIAE12cAgAGBGYCAAGn5AIACTjRQgAB/1ACAJxm5oA==
Date: Mon, 3 Mar 2025 15:21:57 +0000
Message-ID: <48e3ac70f9fb4867a9ef835c22d4fda8@huawei.com>
References: <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <f4e64a3a-5c1d-49f2-ac72-b84ecd353c9d@redhat.com>
 <Z6EQENkHJy7TrkYy@Asurada-Nvidia>
 <77f736f6-9ef9-462b-916e-c8cfff279044@redhat.com>
 <Z6KsAE9wnjWU0xMs@Asurada-Nvidia>
 <8224c38797344d1a9c0f453774925db3@huawei.com>
 <Z6UGVP3olKvakHUh@Asurada-Nvidia>
In-Reply-To: <Z6UGVP3olKvakHUh@Asurada-Nvidia>
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
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

SGkgTmljb2xpbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWNv
bGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBGZWJydWFy
eSA2LCAyMDI1IDY6NTggUE0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1l
ZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT4NCj4gQ2M6IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT47IGRkdXRpbGVAcmVkaGF0LmNvbTsgUGV0ZXINCj4gTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNv
bT47DQo+IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+OyBxZW11LWFy
bUBub25nbnUub3JnOw0KPiBxZW11LWRldmVsQG5vbmdudS5vcmc7IExpbnV4YXJtIDxsaW51eGFy
bUBodWF3ZWkuY29tPjsgV2FuZ3pob3UNCj4gKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47
IGppYW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsNCj4gSm9uYXRoYW4gQ2FtZXJv
biA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5v
cmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMC81XSBody9hcm0vdmlydDogQWRkIHN1cHBv
cnQgZm9yIHVzZXItY3JlYXRhYmxlDQo+IG5lc3RlZCBTTU1VdjMNCj4gDQpbLi5dDQoNCj4gPiBP
bmUgb2YgdGhlIGZlZWRiYWNrIEkgcmVjZWl2ZWQgb24gbXkgc2VyaWVzIHdhcyB0byByZW5hbWUg
ImFybS1zbW11djMtDQo+IG5lc3RlZCINCj4gPiB0byAiYXJtLXNtbXV2My1hY2NlbCIgYW5kIHBv
c3NpYmx5IHJlbmFtZSBmdW5jdGlvbiBuYW1lcyB0byBpbmNsdWRlDQo+ICJhY2NlbCcgYXMgd2Vs
bA0KPiA+IGFuZCBtb3ZlIHRob3NlIGZ1bmN0aW9ucyB0byBhIHNlcGFyYXRlICJzbW11djMtYWNj
ZWwuYyIgZmlsZS4gSSBzdXBwb3NlDQo+IHRoYXQgYXBwbGllcyB0bw0KPiA+IHRoZSAiIEFkZCBI
VyBhY2NlbGVyYXRlZCBuZXN0aW5nIHN1cHBvcnQgZm9yIGFybSBTTU1VdjMiIHNlcmllcyBhcw0K
PiB3ZWxsLg0KPiA+DQo+ID4gSXMgdGhhdCBmaW5lIHdpdGggeW91Pw0KPiANCj4gT2gsIG5vIHBy
b2JsZW0uIElmIHlvdSB3YW50IHRvIHJlbmFtZSB0aGUgd2hvbGUgdGhpbmcsIHBsZWFzZSBmZWVs
DQo+IGZyZWUuIEkgZG8gc2VlIHRoZSBuYW1pbmcgY29uZmxpY3QgYmV0d2VlbiB0aGUgIm5lc3Rl
ZCIgc3RhZ2UgYW5kDQo+IHRoZSAibmVzdGVkIiBIVyBmZWF0dXJlLCB3aGljaCBhcmUgYm90aCBz
dXBwb3J0ZWQgYnkgdGhlIHZTTU1VIG5vdy4NCg0KSSBhbSB3b3JraW5nIG9uIHRoZSBhYm92ZSBu
b3cgYW5kIGhhdmUgcXVpY2sgcXVlc3Rpb24gdG8geW918J+Yii4NCg0KTG9va2luZyBhdCB0aGUg
c21tdV9kZXZfYXR0YWNoX3Zpb21tdSgpIGZuIGhlcmVbMF0sDQppdCBhcHBlYXJzIHRvIGRvIHRo
ZSBmb2xsb3dpbmc6DQoNCjEuIEFsbG9jIGEgczJfaHdwdCBpZiBub3QgYWxsb2NhdGVkIGFscmVh
ZHkgYW5kIGF0dGFjaCBpdC4NCjIuIEFsbG9jYXRlIGFib3J0IGFuZCBieXBhc3MgaHdwdA0KMy4g
QXR0YWNoIGJ5cGFzcyBod3B0Lg0KDQpJIGRpZG4ndCBnZXQgd2h5IHdlIGFyZSBkb2luZyB0aGUg
c3RlcCAzIGhlcmUuIFRvIG1lIGl0IGxvb2tzIGxpa2UsDQp3aGVuIHdlIGF0dGFjaCB0aGUgczJf
aHdwdChpZSwgdGhlIG5lc3RlZCBwYXJlbnQgZG9tYWluIGF0dGFjaCksIA0KdGhlIGtlcm5lbCB3
aWxsIGRvLA0KDQphcm1fc21tdV9hdHRhY2hfZGV2KCkNCiAgYXJtX3NtbXVfbWFrZV9zMl9kb21h
aW5fc3RlKCkNCg0KSXQgYXBwZWFycyB0aHJvdWdoIHN0ZXAgMywgd2UgYWNoaWV2ZSB0aGUgc2Ft
ZSB0aGluZyBhZ2Fpbi4NCg0KT3IgaXQgaXMgcG9zc2libGUgSSBtaXNzZWQgc29tZXRoaW5nIG9i
dmlvdXMgaGVyZS4NCg0KUGxlYXNlIGxldCBtZSBrbm93Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoN
ClswXSBodHRwczovL2dpdGh1Yi5jb20vbmljb2xpbmMvcWVtdS9ibG9iL3dpcC9mb3Jfc2hhbWVl
cl8wMjA0MjAyNS9ody9hcm0vc21tdS1jb21tb24uYyNMOTEwQzEzLUw5MTBDMzUNCg0KDQo=

