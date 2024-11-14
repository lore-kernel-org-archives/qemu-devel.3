Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3245CD65C5A
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 08:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVFJ-0003ut-If; Thu, 14 Nov 2024 03:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tBVEz-0003RZ-5L; Thu, 14 Nov 2024 03:30:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tBVEv-0002tF-Ll; Thu, 14 Nov 2024 03:30:12 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xptcb5j16z6K8s5;
 Thu, 14 Nov 2024 16:29:51 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id D6C67140A30;
 Thu, 14 Nov 2024 16:30:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 09:30:05 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Thu, 14 Nov 2024 09:30:05 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 3/5] hw/arm/smmuv3: Associate a pci bus with a SMMUv3
 Nested device
Thread-Topic: [RFC PATCH 3/5] hw/arm/smmuv3: Associate a pci bus with a SMMUv3
 Nested device
Thread-Index: AQHbMd20WuQYJ64eBk2hccc55H+W27K1duYAgAEBjkA=
Date: Thu, 14 Nov 2024 08:30:05 +0000
Message-ID: <90d72b3d74f94ed7b47c0d1cb8c0984f@huawei.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-4-shameerali.kolothum.thodi@huawei.com>
 <a1edc7ec-6450-4409-b8b2-b4026baee242@redhat.com>
In-Reply-To: <a1edc7ec-6450-4409-b8b2-b4026baee242@redhat.com>
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
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.738, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDEzLCAyMDI0
IDU6NTkgUE0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGku
a29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZp
ZGlhLmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBMaW51
eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKQ0KPiA8d2FuZ3pob3UxQGhp
c2lsaWNvbi5jb20+OyBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47DQo+IEpv
bmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47DQo+IHpoYW5nZmVp
Lmdhb0BsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDMvNV0gaHcvYXJtL3Nt
bXV2MzogQXNzb2NpYXRlIGEgcGNpIGJ1cyB3aXRoIGENCj4gU01NVXYzIE5lc3RlZCBkZXZpY2UN
Cj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiAxMS84LzI0IDEzOjUyLCBTaGFtZWVyIEtvbG90
aHVtIHdyb3RlOg0KPiA+IFN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIGFkZCBJT1JUIG1vZGlmaWNh
dGlvbnMgdG8gZ2V0IHRoaXMgd29ya2luZy4NCj4gYWRkIGEgcHJvcGVyIGNvbW1pdCBtc2cgb25j
ZSBub24gUkZDIDstKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bQ0K
PiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICBo
dy9hcm0vc21tdXYzLmMgICAgICAgICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICBpbmNsdWRlL2h3L2FybS9zbW11djMuaCB8ICAyICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgMjkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11djMu
YyBiL2h3L2FybS9zbW11djMuYw0KPiA+IGluZGV4IDAwMzNlYjgxMjUuLjliMGE3NzY3NjkgMTAw
NjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2My5jDQo+ID4gKysrIGIvaHcvYXJtL3NtbXV2My5j
DQo+ID4gQEAgLTI0LDYgKzI0LDcgQEANCj4gPiAgI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGll
cy5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvcWRldi1jb3JlLmgiDQo+ID4gICNpbmNsdWRlICJody9w
Y2kvcGNpLmgiDQo+ID4gKyNpbmNsdWRlICJody9wY2kvcGNpX2JyaWRnZS5oIg0KPiA+ICAjaW5j
bHVkZSAiY3B1LmgiDQo+ID4gICNpbmNsdWRlICJ0cmFjZS5oIg0KPiA+ICAjaW5jbHVkZSAicWVt
dS9sb2cuaCINCj4gPiBAQCAtMjIwMSwxMiArMjIwMiwzMiBAQCBzdGF0aWMgdm9pZCBzbW11X3Jl
YWxpemUoRGV2aWNlU3RhdGUgKmQsDQo+IEVycm9yICoqZXJycCkNCj4gPiAgICAgIHNtbXVfaW5p
dF9pcnEocywgZGV2KTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgc21tdXYzX25lc3Rl
ZF9wY2lfaG9zdF9icmlkZ2UoT2JqZWN0ICpvYmosIHZvaWQgKm9wYXF1ZSkNCj4gPiArew0KPiA+
ICsgICAgRGV2aWNlU3RhdGUgKmQgPSBvcGFxdWU7DQo+ID4gKyAgICBTTU1VdjNOZXN0ZWRTdGF0
ZSAqc19uZXN0ZWQgPSBBUk1fU01NVVYzX05FU1RFRChkKTsNCj4gPiArDQo+ID4gKyAgICBpZiAo
b2JqZWN0X2R5bmFtaWNfY2FzdChvYmosIFRZUEVfUENJX0hPU1RfQlJJREdFKSkgew0KPiA+ICsg
ICAgICAgIFBDSUJ1cyAqYnVzID0gUENJX0hPU1RfQlJJREdFKG9iaiktPmJ1czsNCj4gPiArICAg
ICAgICBpZiAoc19uZXN0ZWQtPnBjaV9idXMgJiYgIXN0cmNtcChidXMtPnFidXMubmFtZSwgc19u
ZXN0ZWQtDQo+ID5wY2lfYnVzKSkgew0KPiA+ICsgICAgICAgICAgICBvYmplY3RfcHJvcGVydHlf
c2V0X2xpbmsoT0JKRUNUKGQpLCAicHJpbWFyeS1idXMiLCBPQkpFQ1QoYnVzKSwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJvcl9hYm9ydCk7DQo+ID4gKyAg
ICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICsgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+
ID4gIHN0YXRpYyB2b2lkIHNtbXVfbmVzdGVkX3JlYWxpemUoRGV2aWNlU3RhdGUgKmQsIEVycm9y
ICoqZXJycCkNCj4gPiAgew0KPiA+ICAgICAgU01NVXYzTmVzdGVkU3RhdGUgKnNfbmVzdGVkID0g
QVJNX1NNTVVWM19ORVNURUQoZCk7DQo+ID4gICAgICBTTU1VdjNOZXN0ZWRDbGFzcyAqYyA9DQo+
IEFSTV9TTU1VVjNfTkVTVEVEX0dFVF9DTEFTUyhzX25lc3RlZCk7DQo+ID4gKyAgICBTeXNCdXNE
ZXZpY2UgKmRldiA9IFNZU19CVVNfREVWSUNFKGQpOw0KPiA+ICAgICAgRXJyb3IgKmxvY2FsX2Vy
ciA9IE5VTEw7DQo+ID4NCj4gPiArICAgIG9iamVjdF9jaGlsZF9mb3JlYWNoX3JlY3Vyc2l2ZShv
YmplY3RfZ2V0X3Jvb3QoKSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzbW11djNfbmVzdGVkX3BjaV9ob3N0X2JyaWRnZSwgZCk7DQo+IFVzaW5nIGEgZGlmZmVyZW50
IG9wYXF1ZSBzdHJ1Y3QgcG9pbnRlciB5b3UgbWF5IHByb3Blcmx5IHVzZSB0aGUgZXJycA0KPiBh
bmQgbmljZWx5IGZhaWwgaWYgdGhlIGJ1cyBpcyBub3QgZm91bmQgKGF2b2lkIHVzaW5nIGVycm9y
X2Fib3J0KS4NCg0KT2suDQoNCj4gPiArICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpF
Q1QoZGV2KSwgIm5lc3RlZCIsIHRydWUsICZlcnJvcl9hYm9ydCk7DQo+IHdoeSBkbyB5b3UgbmVl
ZCB0aGF0IG5lc3RlZCBwcm9wZXJ0eSBhcyB0aGUgU01NVSBpcyBhbHJlYWR5IHR5cGUnZA0KPiBk
aWZmZXJlbnRseS4NCg0KSSB0aGluayBpdCBpcyBiZWNhdXNlIHRoZXJlIGFyZSBwcmV2aW91cyBw
YXRjaGVzIGluIE5pY29saW4ncyBicmFuY2ggdGhhdCB1c2VkIHRoaXMNCiJuZXN0ZWQiIHByb3Bl
cnR5IHRvIGRpZmZlcmVudGlhdGUgdGhlIGFkZHJlc3MgcGFjZS4gSSB3aWxsIGNoZWNrIGFuZCB1
cGRhdGUuDQoNCj4gPiArDQo+ID4gICAgICBjLT5wYXJlbnRfcmVhbGl6ZShkLCAmbG9jYWxfZXJy
KTsNCj4gPiAgICAgIGlmIChsb2NhbF9lcnIpIHsNCj4gPiAgICAgICAgICBlcnJvcl9wcm9wYWdh
dGUoZXJycCwgbG9jYWxfZXJyKTsNCj4gPiBAQCAtMjI5Myw2ICsyMzE0LDExIEBAIHN0YXRpYyBQ
cm9wZXJ0eSBzbW11djNfcHJvcGVydGllc1tdID0gew0KPiA+ICAgICAgREVGSU5FX1BST1BfRU5E
X09GX0xJU1QoKQ0KPiA+ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBQcm9wZXJ0eSBzbW11djNfbmVz
dGVkX3Byb3BlcnRpZXNbXSA9IHsNCj4gPiArICAgIERFRklORV9QUk9QX1NUUklORygicGNpLWJ1
cyIsIFNNTVV2M05lc3RlZFN0YXRlLCBwY2lfYnVzKSwNCj4gbml0OiBtYXliZSB3ZSBjYW4gdXNl
IHRoZSAiYnVzIiBuYW1lIGluc3RlYWQgb2YgcGNpLWJ1cw0KDQpPay4NCg0KVGhhbmtzLA0KU2hh
bWVlcg0K

