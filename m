Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A717EC3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDEf-0000MF-PZ; Tue, 06 May 2025 04:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCDEd-0000Lt-IZ; Tue, 06 May 2025 04:01:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCDEa-00018V-Rg; Tue, 06 May 2025 04:01:03 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zs9gz55lmz6M559;
 Tue,  6 May 2025 15:56:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id F012C140370;
 Tue,  6 May 2025 16:00:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 May 2025 10:00:44 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 6 May 2025 10:00:44 +0200
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v2 2/6] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Thread-Topic: [PATCH v2 2/6] hw/arm/virt-acpi-build: Update IORT for multiple
 smmuv3 devices
Thread-Index: AQHbu00ZUUd2QcOmi06BQgcpw2jcEbO/cwCAgAXMvsA=
Date: Tue, 6 May 2025 08:00:44 +0000
Message-ID: <e3a42ab5929541af9612fc56eb63a9b8@huawei.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-3-shameerali.kolothum.thodi@huawei.com>
 <aBT9S25tQTVGKkii@Asurada-Nvidia>
In-Reply-To: <aBT9S25tQTVGKkii@Asurada-Nvidia>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiBTZW50OiBGcmlkYXksIE1heSAyLCAyMDI1IDY6MTQgUE0N
Cj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhv
ZGlAaHVhd2VpLmNvbT4NCj4gQ2M6IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsNCj4gZXJpYy5hdWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc7IGpnZ0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhh
dC5jb207IG5hdGhhbmNAbnZpZGlhLmNvbTsNCj4gbW9jaHNAbnZpZGlhLmNvbTsgc21vc3RhZmFA
Z29vZ2xlLmNvbTsgTGludXhhcm0NCj4gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhvdSAo
QikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsNCj4gamlhbmdrdW5rdW4gPGppYW5na3Vua3Vu
QGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdl
aS5jb20+OyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDIvNl0gaHcvYXJtL3ZpcnQtYWNwaS1idWlsZDogVXBkYXRlIElPUlQgZm9yDQo+IG11bHRpcGxl
IHNtbXV2MyBkZXZpY2VzDQo+IA0KPiBPbiBGcmksIE1heSAwMiwgMjAyNSBhdCAxMToyNzowM0FN
ICswMTAwLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IEBAIC00Myw2ICs0Myw3IEBADQo+
ID4gICNpbmNsdWRlICJody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNlLmgiDQo+ID4gICNpbmNs
dWRlICJody9hY3BpL3RwbS5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvYWNwaS9obWF0LmgiDQo+ID4g
KyNpbmNsdWRlICJody9hcm0vc21tdXYzLmgiDQo+ID4gICNpbmNsdWRlICJody9wY2kvcGNpZV9o
b3N0LmgiDQo+ID4gICNpbmNsdWRlICJody9wY2kvcGNpLmgiDQo+ID4gICNpbmNsdWRlICJody9w
Y2kvcGNpX2J1cy5oIg0KPiA+IEBAIC0yNjYsNiArMjY3LDc1IEBAIHN0YXRpYyBpbnQgaW9ydF9p
ZG1hcF9jb21wYXJlKGdjb25zdHBvaW50ZXIgYSwNCj4gZ2NvbnN0cG9pbnRlciBiKQ0KPiA+ICAg
ICAgcmV0dXJuIGlkbWFwX2EtPmlucHV0X2Jhc2UgLSBpZG1hcF9iLT5pbnB1dF9iYXNlOw0KPiA+
ICB9DQo+ID4NCj4gPiArc3RydWN0IFNNTVV2M0RldmljZSB7DQo+ID4gKyAgICBpbnQgaXJxOw0K
PiA+ICsgICAgaHdhZGRyIGJhc2U7DQo+ID4gKyAgICBHQXJyYXkgKnNtbXVfaWRtYXBzOw0KPiA+
ICsgICAgc2l6ZV90IG9mZnNldDsNCj4gPiArfTsNCj4gPiArdHlwZWRlZiBzdHJ1Y3QgU01NVXYz
RGV2aWNlIFNNTVV2M0RldmljZTsNCj4gDQo+ICJTTU1VdjNEZXZpY2UiIHNvdW5kcyB0b28gZ2Vu
ZXJhbCwgbGlrZSBjb21pbmcgZnJvbSBzbW11djMuaCA6LS8NCj4gDQo+IEdpdmVuIHRoaXMgZGVz
Y3JpYmVzIFNNTVV2MydzIElPUlQgbm9kZSwgSSBzdGlsbCB0aGluayB3ZSBzaG91bGQNCj4gbmFt
ZSBpdCBzb21ldGhpbmcgbGlrZSAiSW9ydFNNTVV2M05vZGUiIG9yIHNvLg0KDQpUaGUgd2F5IEkg
dGhvdWdodCBhYm91dCBpdCBpcywgaXQgaXMgbW9zdGx5IGEgc3RydWN0dXJlIHRvIGhvbGQgdGhl
IFNNTVV2MyBkZXZpY2UNCmluZm9ybWF0aW9uLCB0aGF0IHdpbGwgYmUgdXNlZCBpbiBJT1JUIG5v
ZGUgY3JlYXRpb24uIFdlIGFyZSBpbmRlZWQgZ29pbmcgdGhyb3VnaCB0aGUgDQpTTU1VdjMgZGV2
aWNlcyBjcmVhdGVkIGJ5IHZpcnQgYW5kIHBvcHVsYXRpbmcgdGhpcy4gSU9SVCBpcyBub3RoaW5n
IGJ1dCBBQ1BJIHdheSBmb3INCmRlc2NyaWJpbmcgdmFyaW91cyBkZXZpY2VzIGxpa2UgUENJRSBS
QywgU01NVXYzIGV0Yy4gSSB0aG91Z2h0IGl0IGlzIHZlcnkgY2xlYXIgZnJvbSBjb2RlDQp0aGF0
IGl0IGlzIHVzZWQgaW4gSU9SVCBhbmQgYW4gZXhwbGljaXQgSU9SVCBpbiB0aGUgbmFtZSBtYWtl
cyBhbnkgZGlmZmVyZW5jZSBoZXJlIPCfmIoNCg0KSGF2aW5nIHNhaWQgdGhhdCBJIGRvbuKAmXQg
aGF2ZSBhIHN0cm9uZyBiaWFzIHRvd2FyZHMgdGhpcy4gSSB3aWxsIGNvbnNpZGVyIGl0IHdoZW4g
SSByZXNwaW4uDQoNCj4gDQo+ID4gK3N0YXRpYyBpbnQgc21tdXYzX2Rldl9pZG1hcF9jb21wYXJl
KGdjb25zdHBvaW50ZXIgYSwgZ2NvbnN0cG9pbnRlcg0KPiBiKQ0KPiA+ICt7DQo+ID4gKyAgICBT
TU1VdjNEZXZpY2UgKnNkZXZfYSA9IChTTU1VdjNEZXZpY2UgKilhOw0KPiA+ICsgICAgU01NVXYz
RGV2aWNlICpzZGV2X2IgPSAoU01NVXYzRGV2aWNlICopYjsNCj4gPiArICAgIEFjcGlJb3J0SWRN
YXBwaW5nICptYXBfYSA9ICZnX2FycmF5X2luZGV4KHNkZXZfYS0+c21tdV9pZG1hcHMsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBY3BpSW9ydElk
TWFwcGluZywgMCk7DQo+ID4gKyAgICBBY3BpSW9ydElkTWFwcGluZyAqbWFwX2IgPSAmZ19hcnJh
eV9pbmRleChzZGV2X2ItPnNtbXVfaWRtYXBzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQWNwaUlvcnRJZE1hcHBpbmcsIDApOw0KPiA+ICsgICAg
cmV0dXJuIG1hcF9hLT5pbnB1dF9iYXNlIC0gbWFwX2ItPmlucHV0X2Jhc2U7DQo+ID4gK30NCj4g
PiArDQo+ID4gK3N0YXRpYyB2b2lkDQo+ID4gK2dldF9zbW11djNfbGVnYWN5X2RldihWaXJ0TWFj
aGluZVN0YXRlICp2bXMsIEdBcnJheSAqDQo+IHNtbXV2M19kZXZpY2VzKQ0KPiANCj4gR0FycmF5
ICpzbW11djNfZGV2aWNlcw0KPiANCj4gT3IgbWF5YmUgYWxpZ24gd2l0aCB0aGUgbm9uLWxlZ2Fj
eSBwYXRoLCBpLmUuICJzZGV2X2Jsb2IiPyBPciB0aGUNCj4gb3RoZXIgd2F5IGFyb3VuZC4NCg0K
U3VyZS4gSSB0aGluayB2b2lkICpzZGV2X2Jsb2IgZm9yIGJvdGggaXMgZ29vZC4NCiANCj4gT3Ro
ZXJ3aXNlLCBsZ3RtDQo+IFJldmlld2VkLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRp
YS5jb20+DQoNClRoYW5rcywNClNoYW1lZXINCg==

