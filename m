Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526DED6395D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 14:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDlVe-0008UD-4H; Wed, 20 Nov 2024 09:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tDlVc-0008To-0b; Wed, 20 Nov 2024 09:16:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tDlVZ-0007yH-VA; Wed, 20 Nov 2024 09:16:43 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xtk1M01Ydz6LD66;
 Wed, 20 Nov 2024 22:16:07 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 9270F140D26;
 Wed, 20 Nov 2024 22:16:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 15:16:26 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 20 Nov 2024 15:16:26 +0100
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
Thread-Index: AQHbMd3CYnIzOIz3QUan4PDL8HOdprK8zVGAgAAjLhCAABtdAIAAIywQgAAmhYCAAus70A==
Date: Wed, 20 Nov 2024 14:16:26 +0000
Message-ID: <30ff8ac9ee9b4012aa6962c86ac06375@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-5-shameerali.kolothum.thodi@huawei.com>
 <1dcea5ca-806f-4f51-8b13-faf5d62eb086@redhat.com>
 <efb9fb7fb0f04d92b7776cdbc474585d@huawei.com>
 <48bb0455-7c2e-4cc6-aa15-ebe4311d8430@redhat.com>
 <0803ec1a010a46b9811543e1044c3176@huawei.com>
 <aafc5fba-8d68-4796-a846-265362e7acac@redhat.com>
In-Reply-To: <aafc5fba-8d68-4796-a846-265362e7acac@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDE4LCAyMDI0IDY6
MTAgUE0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29s
b3RodW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZpZGlh
LmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBMaW51eGFy
bSA8bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKQ0KPiA8d2FuZ3pob3UxQGhpc2ls
aWNvbi5jb20+OyBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47DQo+IEpvbmF0
aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47DQo+IHpoYW5nZmVpLmdh
b0BsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDQvNV0gaHcvYXJtL3ZpcnQt
YWNwaS1idWlsZDogQnVpbGQgSU9SVCB3aXRoDQo+IG11bHRpcGxlIFNNTVUgbm9kZXMNCg0KWy4u
Ll0NCg0KPiA+IEkgdGhpbmsgdGhlIGFib3ZlIHdvbid0IGFmZmVjdCB0aGUgYmFzaWMgY2FzZSB3
aGVyZSBJIGhhdmUgb25seSBvbmUNCj4gPiBwY2llLXB4Yi9TTU1VdjMuIEJ1dCBldmVuIGluIHRo
YXQgY2FzZSBob3QgYWRkIHNlZW1zIG5vdCB3b3JraW5nLg0KPiA+DQo+ID4gSSB0cmllZCBoYWNr
aW5nIHRoZSBtaW4vbWF4IHJhbmdlcyBhcyBzdXNwZWN0ZWQgYnkgTmljb2xpbi4gQnV0IHN0aWxs
IG5vdA0KPiBlbm91Z2ggdG8NCj4gPiBnZXQgaXQgd29ya2luZy4gIERvIHlvdSBoYXZlIGFueSBo
aW50IG9uIHdoeSB0aGUgaG90IGFkZChkZXNjcmliZWQNCj4gYmVsb3cpIGlzIG5vdA0KPiA+IHdv
cmtpbmc/DQo+IEh1bSB0aG91Z2h0IHRoZSBkdXBsaWNhdGUgaWRtYXAgY291bGQgYmUgdGhlIGNh
dXNlLiBPdGhlcndpc2UgSSBoYXZlIG5vDQo+IGNsdWUuIEkgd291bGQgYWR2aWNlIHRvIGZpeCBp
dCBmaXJzdC4NCg0KSSB0aGluayBJIGhhdmUgYW4gaWRlYSB3aHkgdGhlIGhvdCBhZGQgd2FzIG5v
dCB3b3JraW5nLiANCg0KV2hlbiB3ZSBoYXZlIHRoZSBQQ0llIHRvcG9sb2d5IGFzIHNvbWV0aGlu
ZyBsaWtlIGJlbG93LA0KDQotZGV2aWNlIHB4Yi1wY2llLGlkPXBjaWUuMSxidXNfbnI9OCxidXM9
cGNpZS4wIFwNCi1kZXZpY2UgcGNpZS1yb290LXBvcnQsaWQ9cGNpZS5wb3J0MSxidXM9cGNpZS4x
LGNoYXNzaXM9MSBcDQotZGV2aWNlIHBjaWUtcm9vdC1wb3J0LGlkPXBjaWUucG9ydDIsYnVzPXBj
aWUuMSxjaGFzc2lzPTIgXA0KLWRldmljZSBhcm0tc21tdXYzLW5lc3RlZCxpZD1zbW11djEscGNp
LWJ1cz1wY2llLjEgXA0KLi4uDQoNClRoZSBjdXJyZW50IElPUlQgZ2VuZXJhdGlvbiBpbmNsdWRl
cyB0aGUgcGNpZS1yb290LXBvcnQgZGV2IGlkcyBhbHNvDQppbiB0aGUgU01NVXYzIG5vZGUgaWRt
YXBzLg0KDQpIZW5jZSwgd2hlbiBHdWVzdCBrZXJuZWwgbG9hZHMsIHBjaWVwb3J0IGlzIGFsc28g
YmVoaW5kIHRoZSBTTU1VdjMuDQoNClsgICAgMS40NjY2NzBdIHBjaWVwb3J0IDAwMDA6NjQ6MDAu
MDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDENCi4uLg0KWyAgICAxLjQ0ODIwNV0gcGNpZXBvcnQg
MDAwMDo2NDowMS4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMg0KDQoNClNvIHdoZW4gd2UgZG8g
YSAgaG90IGFkZCwNCmRldmljZV9hZGQgdmZpby1wY2ksaG9zdD0wMDAwOjc1OjAwLjEsYnVzPXBj
aWUucG9ydDEsaW9tbXVmZD1pb21tdWZkMA0KDQpUaGUgUWVtdSBob3RwbHVnIGV2ZW50IGhhbmRs
ZXIgdHJpZXMgdG8gaW5qZWN0IGFuIElSUSB0byB0aGUgR3Vlc3QgcGNpZXBvcnQNCmJ5IHJldHJp
ZXZpbmcgdGhlIE1TSSBhZGRyZXNzIGl0IGlzIGNvbmZpZ3VyZWQgd2l0aC4gDQoNCmhvdHBsdWdf
ZXZlbnRfbm90aWZ5KCkNCiAgICBtc2l4X3ByZXBhcmVfbWVzc2FnZSgpOiBbYWRkcmVzczogMHhm
ZmZmZjA0MF0NCiAgICAgICAgIG1zaXhfbm90aWZ5KCkNCg0KVGhlIElUUyBhZGRyZXNzIHJldHJp
ZXZlZCBoZXJlIGlzIGFjdHVhbGx5IHRoZSBTTU1VdjMgdHJhbnNsYXRlZCBpb3ZhIGFkZHIsDQpu
b3QgdGhlIEd1ZXN0IFBBLiAgU28gR3Vlc3QgbmV2ZXIgc2Vlcy9yZWNlaXZlcyB0aGUgaW50ZXJy
dXB0Lg0KDQpJIGRpZCBoYWNrIHRoZSBJT1JUIGNvZGUgdG8gZXhjbHVkZSB0aGUgcGNpZS1yb290
LXBvcnQgZGV2IGlkcyBmcm9tIHRoZSBTTU1VdjMNCm5vZGUgaWRtYXBzIGFuZCB0aGUgaG90IGFk
ZCBzZWVtcyB0byB3b3JrIGZpbmUuDQoNCkxvb2tzIGxpa2Ugd2UgbmVlZCB0byBmaW5kIGFsbCB0
aGUgcGNpZS1yb290LXBvcnQgZGV2IGlkcyBhc3NvY2lhdGVkIHdpdGggYQ0KU01NVXYzL3B4Yi1w
Y2llIGFuZCBleGNsdWRlIHRoZW0gZnJvbSBTTU1VdjMgbm9kZSBpZG1hcHMgdG8gZ2V0DQp0aGUg
aG90IGFkZCB3b3JraW5nLg0KDQpJIGFtIG5vdCBzdXJlIHRob3VnaCB0aGlzIHdpbGwgIGNyZWF0
ZSBhbnkgb3RoZXIgaXNzdWVzIGluIElPTU1VIGlzb2xhdGlvbiBjcml0ZXJpYQ0KKEFDUyBldGMs
KSwgZXNwZWNpYWxseSBpZiB3ZSB3YW50IHRvIGFjY2VzcyB0aGUgZGV2aWNlIGluIEd1ZXN0IHVz
ZXIgc3BhY2UoIEkgaG9wZQ0Kbm90KS4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQoNCg0KDQo=

