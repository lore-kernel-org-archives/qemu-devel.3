Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BF2C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPyp-0002qV-H5; Wed, 12 Mar 2025 13:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsPyI-0002aC-Tg; Wed, 12 Mar 2025 13:34:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsPyG-0004vX-Pp; Wed, 12 Mar 2025 13:34:22 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCd1916z3z6J6mj;
 Thu, 13 Mar 2025 01:29:49 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 5651B140D26;
 Thu, 13 Mar 2025 01:34:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Mar 2025 18:34:18 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 12 Mar 2025 18:34:18 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 04/20] hw/arm/virt: Add support for smmuv3-accel
Thread-Topic: [RFC PATCH v2 04/20] hw/arm/virt: Add support for smmuv3-accel
Thread-Index: AQHbko9X7BBFIVL5UECoP8opJSgSfrNvkyYAgAAR74D///hiAIAAEm+A///xm4CAACG5AA==
Date: Wed, 12 Mar 2025 17:34:17 +0000
Message-ID: <8490942b9428411e858a62a80ea12530@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-5-shameerali.kolothum.thodi@huawei.com>
 <547f961e-380c-4ffe-8b8b-3e9d543aa702@redhat.com>
 <58c9c37876c64584b0c7961ec61696a3@huawei.com>
 <5b29ea01-1b86-4b48-a769-14986751a0f1@redhat.com>
 <5d894a546d3f4081ac2cfe98bd2ea612@huawei.com>
 <fb28c228-0c78-4412-ba91-a62cb4351793@redhat.com>
In-Reply-To: <fb28c228-0c78-4412-ba91-a62cb4351793@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.214]
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
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDEyLCAyMDI1IDQ6
MjggUE0NCj4gVG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29s
b3RodW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZpZGlh
LmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsNCj4gZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5n
ZUByZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207DQo+IG1vY2hzQG52aWRpYS5jb207IHNt
b3N0YWZhQGdvb2dsZS5jb207IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWkuY29tPjsgV2Fu
Z3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47DQo+IGppYW5na3Vua3VuIDxqaWFu
Z2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJv
bkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtS
RkMgUEFUQ0ggdjIgMDQvMjBdIGh3L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3Igc21tdXYzLQ0K
PiBhY2NlbA0KDQo+ID4+IEhpIFNoYW1lZXIsDQo+ID4+Pj4gSSBrbm93IHRoZXJlIHdlcmUgcXVp
dGUgYSBsb3Qgb2YgZGljdXNzaW9ucyBvbiB0aGUgMXN0IG11bHRpDQo+ID4+Pj4gaW5zdGFudGlh
dGlvbiBzZXJpZXMgcmVsYXRlZCB0byB0aGUgd2F5IHdlIGluc3RhbmF0aWF0ZSB0aGF0IGRldmlj
ZQ0KPiA+Pj4+IGFuZCBtYXliZSBJIG1pc3NlZCBzb21lIGJsb2NrZXJzIGJ1dCB3aHkgd291bGRu
J3Qgd2UgYWxsb3cgdGhlDQo+ID4+Pj4gaW5zdGFudGlhdGlvbiBvZiB0aGUgbGVnYWN5IHNtbXUg
ZGV2aWNlIHdpdGggLWRldmljZSB0b28uIEkgdGhpbmsNCj4gPj4+PiB0aGlzIHdvdWxkIGJlIHNp
bXBsZXIgZm9yIGxpYnZpcnQgYW5kIHdlIHdvdWxkIHNvbWVob3cgZGVwcmVjYXRlDQo+ID4+Pj4g
dGhlIG1hY2hpbmUgb3B0aW9uIG1ldGhvZD8gd291bGQgdGhhdCBtYWtlIGEgcHJvYmxlbSBpZiB5
b3Ugd2VyZQ0KPiB0bw0KPiA+Pj4+IHVzZSAtZGV2aWNlIHNtbXUsYWNjZWwgb3Igc29tZXRoaW5n
IGFsaWtlPw0KPiA+Pj4gVGhhbmtzIGZvciB0YWtpbmcgYSBsb29rLiBJIGFtIGp1c3QganVtcGlu
ZyBvbiB0aGlzIG9uZSBmb3Igbm93Lg0KPiA+Pj4gWWVzLCB0aGVyZSB3ZXJlIGRpc2N1c3Npb25z
IGFyb3VuZCB0aGF0LiBCdXQgSSB3YXMgbm90IHN1cmUgd2UNCj4gPj4+IGNvbmNsdWRlZCBvbiBk
ZXByZWNhdGluZyB0aGUgbWFjaGluZSBvcHRpb24uIFNvIGlmIEkgZ2V0IHlvdQ0KPiA+Pj4gY29y
cmVjdGx5IHRoZSBpZGVhIGlzLA0KPiA+Pj4NCj4gPj4+IGlmIHdlIGhhdmUsDQo+ID4+PiAtZGV2
aWNlIHNtbXV2MyBpdCB3aWxsIGluc3RhbnRpYXRlIHRoZSBjdXJyZW50IG1hY2hpbmUgd2lkZSBz
bW11djMNCj4gPj4+IGFuZCBmb3IgLWRldmljZSBzbW11djMsYWNjZWwgdGhpcyBkZXZpY2U/DQo+
ID4+IHllcyB0aGF0IHdvdWxkIGJlIG15IHByZWZlcmVuY2UuDQo+ID4gT2suIEkgd2lsbCBsb29r
IGludG8gdGhhdCBpbiBteSBuZXh0IHJlc3Bpbi4gQSBxdWljayBxdWVzdGlvbi4gRG9lcw0KPiA+
IHFlbXUgREVWSUNFIG1vZGVsIHN1cHBvcnQgdGhlIGRpZmZlcmVudGlhdGlvbiBsaWtlIGFib3Zl
IGVhc2lseT8gT3Igd2UNCj4gPiBoYXZlIHRvIG1hbmFnZSBpdCB3aXRoIHByb3BlcnRpZXM/DQo+
IE5vdCBzdXJlIGlmIEkgdW5kZXJzdGFuZCB5b3UgcXVlc3Rpb24uIEkgbWVhbnQgaXQgY2FuIGJl
IGEgYm9vbGVhbiBkZXZpY2UNCj4gcHJvcGVydHkgKERFRklORV9QUk9QX0JPT0wpIHNtbXV2Myxh
Y2NlbD1vbg0KPiANCj4gTm8/DQoNClJpZ2h0LiBNeSBxdWVyeSB3YXMgbW9yZSBhYm91dCBhbnkg
aGlkZGVuIFFlbXUgbWFnaWMgdG8gaGF2ZSBkZXZpY2UgaW5zdGFudGlhdGlvbg0Kc2ltaWxhciB0
byB3aGF0IHdlIGhhdmUgYXQgdGhlIG1vbWVudCBldmVuIHRob3VnaCB3ZSBuYW1lIGJvdGggZGV2
aWNlcyAic21tdXYzIi4NCiANClRoYXQgd2F5IEkgY2FuIGtlZXAgbXVjaCBvZiB0aGUgY29kZSBy
YXRoZXIgdGhhbiBjaGVja2luZyAiYWNjZWwiIHByb3BlcnR5DQppbiBTTU1VdjMgY29kZSBhbmQg
cmVkaXJlY3RpbmcgY2FsbHMuIEJ1dCBsb29rcyBsaWtlIG5vdC4gDQoNClRoYW5rcywNClNoYW1l
ZXINCg0KDQoNCg0K

