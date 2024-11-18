Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D608CD4922E
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 15:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD3Es-0003fE-6b; Mon, 18 Nov 2024 10:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tD3Ek-0003cL-E4; Mon, 18 Nov 2024 10:00:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tD3Eh-0000Py-1b; Mon, 18 Nov 2024 10:00:22 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XsW2f2FJ3z6K8yM;
 Mon, 18 Nov 2024 22:58:02 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id DA784140AE5;
 Mon, 18 Nov 2024 23:00:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 16:00:13 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Mon, 18 Nov 2024 16:00:13 +0100
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
Thread-Index: AQHbMd3CYnIzOIz3QUan4PDL8HOdprK8zVGAgAAjLhCAABtdAIAAIywQ
Date: Mon, 18 Nov 2024 15:00:13 +0000
Message-ID: <0803ec1a010a46b9811543e1044c3176@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-5-shameerali.kolothum.thodi@huawei.com>
 <1dcea5ca-806f-4f51-8b13-faf5d62eb086@redhat.com>
 <efb9fb7fb0f04d92b7776cdbc474585d@huawei.com>
 <48bb0455-7c2e-4cc6-aa15-ebe4311d8430@redhat.com>
In-Reply-To: <48bb0455-7c2e-4cc6-aa15-ebe4311d8430@redhat.com>
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
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTgs
IDIwMjQgMTo0NiBQTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVl
cmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4g
cWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpn
Z0BudmlkaWEuY29tOyBuaWNvbGluY0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5jb207
IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgV2FuZ3pob3UgKEIpDQo+IDx3YW5nemhv
dTFAaGlzaWxpY29uLmNvbT47IGppYW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsN
Cj4gSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsNCj4gemhh
bmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggNC81XSBody9h
cm0vdmlydC1hY3BpLWJ1aWxkOiBCdWlsZCBJT1JUIHdpdGgNCj4gbXVsdGlwbGUgU01NVSBub2Rl
cw0KPiANCg0KPiA+Pj4gICAgICAvKiBOdW1iZXIgb2YgSU9SVCBOb2RlcyAqLw0KPiA+Pj4gQEAg
LTM0MiwxMCArMzU2LDkgQEAgYnVpbGRfaW9ydChHQXJyYXkgKnRhYmxlX2RhdGEsIEJJT1NMaW5r
ZXINCj4gPj4gKmxpbmtlciwgVmlydE1hY2hpbmVTdGF0ZSAqdm1zKQ0KPiA+Pj4gICAgICAvKiBH
SUMgSVRTIElkZW50aWZpZXIgQXJyYXkgKi8NCj4gPj4+ICAgICAgYnVpbGRfYXBwZW5kX2ludF9u
b3ByZWZpeCh0YWJsZV9kYXRhLCAwIC8qIE1BRFQgdHJhbnNsYXRpb25faWQgKi8sDQo+ID4+IDQp
Ow0KPiA+Pj4gLSAgICBpZiAodm1zLT5pb21tdSA9PSBWSVJUX0lPTU1VX1NNTVVWMykgew0KPiA+
Pj4gLSAgICAgICAgaW50IGlycSA9ICB2bXMtPmlycW1hcFtWSVJUX1NNTVVdICsgQVJNX1NQSV9C
QVNFOw0KPiA+Pj4gKyAgICBmb3IgKGkgPSAwOyBpIDwgbnVtX3NtbXVzOyBpKyspIHsNCj4gPj4+
ICsgICAgICAgIHNtbXVfb2Zmc2V0W2ldID0gdGFibGVfZGF0YS0+bGVuIC0gdGFibGUudGFibGVf
b2Zmc2V0Ow0KPiA+Pj4NCj4gPj4gSSB3b3VsZCBoYXZlIGV4cGVjdGVkIGNoYW5nZXMgaW4gdGhl
IHNtbXUgaWRtYXAgaGFzIHdlbGwuIElmIGEgZ2l2ZW4NCj4gPj4gU01NVSBpbnN0YW5jZSBub3cg
cHJvdGVjdHMgYSBnaXZlbiBidXMgaGllcmFyY2h5IHNob3VsZG4ndCBpdCBiZQ0KPiA+PiByZWZs
ZWN0ZWQgaW4gYSBkaWZmZXJlbnRpYXRlZCBTTU1VIGlkbWFwIGZvciBlYWNoIG9mIHRoZW0gKFJJ
RCBzdWJzZXQNCj4gb2YNCj4gPj4gU01NVS0+cGNpLWJ1cyBtYXBwaW5nIHRvIGEgc3BlY2lmaWMg
SU9SVCBTTU1VIG5vZGUpPyBIb3cgaXMgaXQgZG9uZQ0KPiA+PiBjdXJyZW50bHk/DQo+ID4gSSB0
aG91Z2h0IHRoYXQgc21tdV9pZG1hcHMgd2lsbCBiZSBoYW5kbGVkIGJ5IHRoaXMgPw0KPiA+DQo+
ID4gb2JqZWN0X2NoaWxkX2ZvcmVhY2hfcmVjdXJzaXZlKG9iamVjdF9nZXRfcm9vdCgpLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvcnRfaG9zdF9icmlkZ2Vz
LCBzbW11X2lkbWFwcyk7DQo+IHRvIG1lIHRoaXMgdHJhdmVyc2VzIHRoZSBxZW11IG9iamVjdCBo
aWVyYXJjaHkgdG8gZmluZCBhbGwgaG9zdCBicmlkZ2VzDQo+IGFuZCBmb3IgZWFjaCBvZiB0aGVt
IGJ1aWxkcyBhbiBpZG1hcCBhcnJheSAoc21tdV9pZG1hcHMgbWFwcGluZyB0aGlzDQo+IFJDDQo+
IFJJRCByYW5nZSB0byB0aGlzIFNNTVUpLiBCdXQgdG8gbWUgdGhvc2UgaWRtYXBzIHdpbGwgYmUg
YXNzaWduZWQgdG8NCj4gKmFsbCogU01NVSBpbnN0ZWFjZXMgbGVhZGluZyB0byBhIHdvbmcgSU9S
VCBkZXNjcmlwdGlvbiBiZWNhdXNlIGFsbA0KPiBTTU1VcyB3aWxsIGJlIHByb3RlY3RpbmcgYWxs
IGRldmljZXMuIFlvdSBzaGFsbCBvbmx5IHJldGFpbiBpZG1hcHMgd2hpY2gNCj4gY29ycmVzcG9u
ZCB0byB0aGUgcGNpX2J1cyBhIGdpdmVuIHZTTU1VIGlzIGF0dGFjaGVkIHRvLiBUaGVuIGVhY2gg
U01NVQ0KPiB3aWxsIHByb3RlY3QgYSBkaXN0aW5jdCBQQ0llIHN1YnRyZWUgd2hpY2ggZG9lcyBu
b3Qgc2VlbSB0aGUgY2FzZSB0b2RheS4NCj4gQXQgbGVhc3QgdGhhdCdzIG15IGN1cnJlbnQgdW5k
ZXJzdGFuZGluZy4NCg0KQWguLnJpZ2h0LiBJIHdpbGwgZml4IHRoYXQgaW4gbmV4dCB2ZXJzaW9u
LiANCg0KSSB0aGluayB0aGUgYWJvdmUgd29uJ3QgYWZmZWN0IHRoZSBiYXNpYyBjYXNlIHdoZXJl
IEkgaGF2ZSBvbmx5IG9uZQ0KcGNpZS1weGIvU01NVXYzLiBCdXQgZXZlbiBpbiB0aGF0IGNhc2Ug
aG90IGFkZCBzZWVtcyBub3Qgd29ya2luZy4NCg0KSSB0cmllZCBoYWNraW5nIHRoZSBtaW4vbWF4
IHJhbmdlcyBhcyBzdXNwZWN0ZWQgYnkgTmljb2xpbi4gQnV0IHN0aWxsIG5vdCBlbm91Z2ggdG8g
DQpnZXQgaXQgd29ya2luZy4gIERvIHlvdSBoYXZlIGFueSBoaW50IG9uIHdoeSB0aGUgaG90IGFk
ZChkZXNjcmliZWQgYmVsb3cpIGlzIG5vdA0Kd29ya2luZz8NCg0KVGhhbmtzLA0KU2hhbWVlcg0K
DQo+IA0KPiBFcmljDQo+IA0KPiANCj4gPg0KPiA+IEJ1dCBpdCBpcyBwb3NzaWJsZSB0aGF0LCB0
aGVyZSBpcyBhIGJ1ZyBpbiB0aGlzIElPUlQgZ2VuZXJhdGlvbiBoZXJlIGFzIEkgYW0NCj4gbm90
DQo+ID4gYWJsZSB0byBob3QgYWRkICBkZXZpY2VzLiBJdCBsb29rcyBsaWtlIHRoZSBwY2llaHAg
aW50ZXJydXB0IGlzIG5vdA0KPiBnZW5lcmF0ZWQvcmVjZWl2ZWQNCj4gPiBmb3Igc29tZSByZWFz
b24uIE5pY29saW5bMF0gaXMgc3VzcGVjdGluZyB0aGUgbWluL21heCBidXMgcmFuZ2UgaW4NCj4g
PiBpb3J0X2hvc3RfYnJpZGdlcygpIG1heSBub3QgbGVhdmUgZW5vdWdoIHJhbmdlcyBmb3IgaG90
IGFkZCBsYXRlci4NCj4gPg0KPiA+IENvbGQgcGx1Z2dpbmcgZGV2aWNlcyB0byBkaWZmZXJlbnQg
U01NVXYzL3BjaWUtcHhiIHNlZW1zIHRvIGJlIGFscmlnaHQuDQo+ID4NCj4gPiBJIHdpbGwgZGVi
dWcgdGhhdCBzb29uLg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFNoYW1lZXINCj4gPiBbMF0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9aelBkMUYlMkZVQTJNS01id2xAQXN1cmFk
YS0NCj4gTnZpZGlhLw0KPiA+DQo+ID4NCj4gDQoNCg==

