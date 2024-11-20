Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9476D711C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 16:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDnX7-0008BG-KR; Wed, 20 Nov 2024 11:26:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tDnX4-00088N-Ft; Wed, 20 Nov 2024 11:26:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tDnX2-0002q7-5k; Wed, 20 Nov 2024 11:26:22 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xtmrt33HLz6K5xS;
 Thu, 21 Nov 2024 00:23:58 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id D4A701402C7;
 Thu, 21 Nov 2024 00:26:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 17:26:15 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 20 Nov 2024 17:26:15 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with multiple
 SMMU nodes
Thread-Topic: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with multiple
 SMMU nodes
Thread-Index: AQHbMd3CYnIzOIz3QUan4PDL8HOdprK8zVGAgAAjLhCAABtdAIAAIywQgAAmhYCAAus70IAAGD4AgAAU00A=
Date: Wed, 20 Nov 2024 16:26:15 +0000
Message-ID: <e13f2e9c0a6341e8b25b7945bc7bf413@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-5-shameerali.kolothum.thodi@huawei.com>
 <1dcea5ca-806f-4f51-8b13-faf5d62eb086@redhat.com>
 <efb9fb7fb0f04d92b7776cdbc474585d@huawei.com>
 <48bb0455-7c2e-4cc6-aa15-ebe4311d8430@redhat.com>
 <0803ec1a010a46b9811543e1044c3176@huawei.com>
 <aafc5fba-8d68-4796-a846-265362e7acac@redhat.com>
 <30ff8ac9ee9b4012aa6962c86ac06375@huawei.com>
 <41a67d4e-f7b8-4586-8d52-c32df400b675@redhat.com>
In-Reply-To: <41a67d4e-f7b8-4586-8d52-c32df400b675@redhat.com>
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
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIg
MjAsIDIwMjQgNDoxMSBQTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hh
bWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsN
Cj4gcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7
IGpnZ0BudmlkaWEuY29tOyBuaWNvbGluY0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5j
b207IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgV2FuZ3pob3UgKEIpDQo+IDx3YW5n
emhvdTFAaGlzaWxpY29uLmNvbT47IGppYW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29t
PjsNCj4gSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4g
emhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggNC81XSBo
dy9hcm0vdmlydC1hY3BpLWJ1aWxkOiBCdWlsZCBJT1JUIHdpdGgNCj4gbXVsdGlwbGUgU01NVSBu
b2Rlcw0KPiANCj4gSGkgU2hhbWVlciwNCj4gDQo+IE9uIDExLzIwLzI0IDE1OjE2LCBTaGFtZWVy
YWxpIEtvbG90aHVtIFRob2RpIHdyb3RlOg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4g
Pj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxOCwgMjAyNCA2OjEwIFBNDQo+ID4+IFRvOiBTaGFt
ZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+ID4+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1
YXdlaS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOw0KPiA+PiBxZW11LWRldmVsQG5vbmdudS5v
cmcNCj4gPj4gQ2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207IG5p
Y29saW5jQG52aWRpYS5jb207DQo+ID4+IGRkdXRpbGVAcmVkaGF0LmNvbTsgTGludXhhcm0gPGxp
bnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhvdSAoQikNCj4gPj4gPHdhbmd6aG91MUBoaXNpbGlj
b24uY29tPjsgamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+Ow0KPiA+PiBKb25h
dGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiA+PiB6aGFuZ2Zl
aS5nYW9AbGluYXJvLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCA0LzVdIGh3L2Fy
bS92aXJ0LWFjcGktYnVpbGQ6IEJ1aWxkIElPUlQgd2l0aA0KPiA+PiBtdWx0aXBsZSBTTU1VIG5v
ZGVzDQo+ID4gWy4uLl0NCj4gPg0KPiA+Pj4gSSB0aGluayB0aGUgYWJvdmUgd29uJ3QgYWZmZWN0
IHRoZSBiYXNpYyBjYXNlIHdoZXJlIEkgaGF2ZSBvbmx5IG9uZQ0KPiA+Pj4gcGNpZS1weGIvU01N
VXYzLiBCdXQgZXZlbiBpbiB0aGF0IGNhc2UgaG90IGFkZCBzZWVtcyBub3Qgd29ya2luZy4NCj4g
Pj4+DQo+ID4+PiBJIHRyaWVkIGhhY2tpbmcgdGhlIG1pbi9tYXggcmFuZ2VzIGFzIHN1c3BlY3Rl
ZCBieSBOaWNvbGluLiBCdXQgc3RpbGwgbm90DQo+ID4+IGVub3VnaCB0bw0KPiA+Pj4gZ2V0IGl0
IHdvcmtpbmcuICBEbyB5b3UgaGF2ZSBhbnkgaGludCBvbiB3aHkgdGhlIGhvdCBhZGQoZGVzY3Jp
YmVkDQo+ID4+IGJlbG93KSBpcyBub3QNCj4gPj4+IHdvcmtpbmc/DQo+ID4+IEh1bSB0aG91Z2h0
IHRoZSBkdXBsaWNhdGUgaWRtYXAgY291bGQgYmUgdGhlIGNhdXNlLiBPdGhlcndpc2UgSSBoYXZl
DQo+IG5vDQo+ID4+IGNsdWUuIEkgd291bGQgYWR2aWNlIHRvIGZpeCBpdCBmaXJzdC4NCj4gPiBJ
IHRoaW5rIEkgaGF2ZSBhbiBpZGVhIHdoeSB0aGUgaG90IGFkZCB3YXMgbm90IHdvcmtpbmcuDQo+
ID4NCj4gPiBXaGVuIHdlIGhhdmUgdGhlIFBDSWUgdG9wb2xvZ3kgYXMgc29tZXRoaW5nIGxpa2Ug
YmVsb3csDQo+ID4NCj4gPiAtZGV2aWNlIHB4Yi1wY2llLGlkPXBjaWUuMSxidXNfbnI9OCxidXM9
cGNpZS4wIFwNCj4gPiAtZGV2aWNlIHBjaWUtcm9vdC1wb3J0LGlkPXBjaWUucG9ydDEsYnVzPXBj
aWUuMSxjaGFzc2lzPTEgXA0KPiA+IC1kZXZpY2UgcGNpZS1yb290LXBvcnQsaWQ9cGNpZS5wb3J0
MixidXM9cGNpZS4xLGNoYXNzaXM9MiBcDQo+ID4gLWRldmljZSBhcm0tc21tdXYzLW5lc3RlZCxp
ZD1zbW11djEscGNpLWJ1cz1wY2llLjEgXA0KPiA+IC4uLg0KPiA+DQo+ID4gVGhlIGN1cnJlbnQg
SU9SVCBnZW5lcmF0aW9uIGluY2x1ZGVzIHRoZSBwY2llLXJvb3QtcG9ydCBkZXYgaWRzIGFsc28N
Cj4gPiBpbiB0aGUgU01NVXYzIG5vZGUgaWRtYXBzLg0KPiA+DQo+ID4gSGVuY2UsIHdoZW4gR3Vl
c3Qga2VybmVsIGxvYWRzLCBwY2llcG9ydCBpcyBhbHNvIGJlaGluZCB0aGUgU01NVXYzLg0KPiA+
DQo+ID4gWyAgICAxLjQ2NjY3MF0gcGNpZXBvcnQgMDAwMDo2NDowMC4wOiBBZGRpbmcgdG8gaW9t
bXUgZ3JvdXAgMQ0KPiA+IC4uLg0KPiA+IFsgICAgMS40NDgyMDVdIHBjaWVwb3J0IDAwMDA6NjQ6
MDEuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDINCj4gDQo+IEJ1dCBpdCBzaG91bGQgYmUgdGhl
IHNhbWUgd2l0aG91dCBtdWx0aS1pbnN0YW50aWF0aW9uLCBubz8gSSB3b3VsZCBoYXZlDQo+IGV4
cGVjdGVkIHRoaXMgYXMgbm9ybWFsLiBIYXMgeW91IHRlc3RlZCBob3QtcGx1ZyB3aXRob3V0IHRo
ZSBzZXJpZXMNCj4gbGF0ZXJseT8gRG8geW91IGhhdmUgdGhlIHNhbWUgcGI/DQoNClRoYXQgaXMg
YSBnb29kIHF1ZXN0aW9uLiBJIHdpbGwgZ2l2ZSBpdCBhIHRyeSBzb29uIGFuZCB1cGRhdGUuDQoN
ClRoYW5rcywNClNoYW1lZXIuDQo=

