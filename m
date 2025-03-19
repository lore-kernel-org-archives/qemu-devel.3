Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CB8C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwfU-0004Mb-2I; Wed, 19 Mar 2025 12:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tuwfQ-0004I5-1I; Wed, 19 Mar 2025 12:53:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tuwfN-00051t-7e; Wed, 19 Mar 2025 12:53:19 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZHvpL2934z67GVD;
 Thu, 20 Mar 2025 00:50:18 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id D3CBE1404FC;
 Thu, 20 Mar 2025 00:53:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Mar 2025 17:53:13 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 19 Mar 2025 17:53:13 +0100
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Thread-Topic: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Thread-Index: AQHbkpt/2E04sj23iE6hCb84oIWO4LNvjRwAgAgITACAAAOdAIAAEXKAgAL8TYCAABHEMA==
Date: Wed, 19 Mar 2025 16:53:13 +0000
Message-ID: <a1a62689da8c43ca98a4379773db241c@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <11895c78-d6ab-40c8-a500-4abed1565234@redhat.com>
In-Reply-To: <11895c78-d6ab-40c8-a500-4abed1565234@redhat.com>
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
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDE5LCAyMDI1IDQ6
NDYgUE0NCj4gVG86IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gQ2M6IFNo
YW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVh
d2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsg
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZpZGlhLmNvbTsNCj4gZGR1dGlsZUByZWRo
YXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOyBuYXRoYW5jQG52aWRpYS5jb207DQo+IG1vY2hz
QG52aWRpYS5jb207IHNtb3N0YWZhQGdvb2dsZS5jb207IExpbnV4YXJtDQo+IDxsaW51eGFybUBo
dWF3ZWkuY29tPjsgV2FuZ3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47DQo+IGpp
YW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8
am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4g
U3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjIgMDMvMjBdIGh3L2FybS9zbW11djMtYWNjZWw6IEFk
ZCBpbml0aWFsDQo+IGluZnJhc3RydWN0dXJlIGZvciBzbW11djMtYWNjZWwgZGV2aWNlDQo+ID4+
PiBJcyB0aGVyZSBhbnkgYmVuZWZpdCBmcm9tIGVtdWxhdGVkIGRldmljZXMgd29ya2luZyBpbiB0
aGUgSFctDQo+ID4+PiBhY2NlbGVyYXRlZCBuZXN0ZWQgdHJhbnNsYXRpb24gbW9kZT8NCj4gPj4g
Tm90IHJlYWxseSBidXQgZG8gd2UgaGF2ZSBhbnkganVzdGlmaWNhdGlvbiBmb3IgdXNpbmcgZGlm
ZmVyZW50IGRldmljZQ0KPiA+PiBuYW1lIGluIGFjY2VsIG1vZGU/IEkgYW0gbm90IGV2ZW4gc3Vy
ZSB0aGF0IGFjY2VsIG9wdGlvbiBpcyByZWFsbHkNCj4gPj4gbmVlZGVkLiBJZGVhbGx5IHRoZSBx
ZW11IGRldmljZSBzaG91bGQgYmUgYWJsZSB0byBkZXRlY3QgaXQgaXMNCj4gPj4gcHJvdGVjdGlu
ZyBhIFZGSU8gZGV2aWNlLCBpbiB3aGljaCBjYXNlIGl0IHNoYWxsIGNoZWNrIHdoZXRoZXIgbmVz
dGVkIGlzDQo+ID4+IHN1cHBvcnRlZCBieSBob3N0IFNNTVUgYW5kIHRoZW4gYXV0b21hdGljYWxs
eSB0dXJuIGFjY2VsIG1vZGU/DQo+ID4+DQo+ID4+IEkgZ2F2ZSB0aGUgZXhhbXBsZSBvZiB0aGUg
dmZpbyBkZXZpY2Ugd2hpY2ggaGFzIGRpZmZlcmVudCBjbGFzcw0KPiA+PiBpbXBsZW1lbnRyYXRp
b24gZGVwZW5kaW5nIG9uIHRoZSBpb21tdWZkIG9wdGlvbiBiZWluZyBzZXQgb3Igbm90Lg0KPiA+
IERvIHlvdSBtZWFuIHRoYXQgd2Ugc2hvdWxkIGp1c3QgY3JlYXRlIGEgcmVndWxhciBzbW11djMg
ZGV2aWNlIGFuZA0KPiA+IGxldCBhIFZGSU8gZGV2aWNlIHRvIHR1cm4gb24gdGhpcyBzbW11djMn
cyBhY2NlbCBtb2RlIGRlcGVuZGluZyBvbg0KPiA+IGl0cyBMRUdBQ1kvSU9NTVVGRCBjbGFzcz8N
Cj4gDQo+IG5vIHRoaXMgaXMgbm90IHdoYXQgSSBtZWFudC4gSSBnYXZlIGFuIGV4YW1wbGUgd2hl
cmUgZGVwZW5kaW5nIG9uIGFuDQo+IG9wdGlvbiBwYXNzZWQgdG8gdGh5ZSBWRklPIGRldmljZSB5
b3UgY2hvb3NlIG9uZSBjbGFzcyBpbXBsZW1lbnQgb3IgdGhlDQo+IG90aGVyLg0KPiA+DQo+ID4g
QW5vdGhlciBxdWVzdGlvbjogaG93IGRvZXMgYW4gZW11bGF0ZWQgZGV2aWNlIHdvcmsgd2l0aCBh
IHZTTU1VdjM/DQo+IEkgZG9uJ3QgZ2V0IHlvdXIgcXVlc3Rpb24uIHZTTU1VdjMgY3VycmVudGx5
IG9ubHkgd29ya3Mgd2l0aCBlbXVsYXRlZA0KPiBkZXZpY2VzLiBEaWQgeW91IG1lYW4gYWNjZWxl
cmF0ZWQgU01NVXYzPw0KPiA+IEkgY291bGQgaW1hZ2luZSB0aGF0IGFsbCB0aGUgYWNjZWwgc3Rl
cHMgd291bGQgYmUgYnlwYXNzZWQgc2luY2UNCj4gPiAhc2Rldi0+aWRldi4gWWV0LCB0aGUgZW11
bGF0ZWQgaW90bGIgc2hvdWxkIGNhY2hlIGl0cyB0cmFuc2xhdGlvbg0KPiA+IHNvIHdlIHdpbGwg
bmVlZCB0byBmbHVzaCB0aGUgaW90bGIsIHdoaWNoIHdpbGwgaW5jcmVhc2UgY29tcGxleGl0eQ0K
PiA+IGFzIHRoZSBUTEJJIGNvbW1hbmQgZGlzcGF0Y2hpbmcgZnVuY3Rpb24gd2lsbCBuZWVkIHRv
IGJlIGF3YXJlIHdoYXQNCj4gPiBBU0lEIGlzIGZvciBlbXVsYXRlZCBkZXZpY2UgYW5kIHdoYXQg
aXMgZm9yIHZmaW8gZGV2aWNlLi4NCj4gSSBkb24ndCBnZXQgdGhlIGlzc3VlLiBGb3IgZW11bGF0
ZWQgZGV2aWNlIHlvdSBnbyB0aHJvdWdoIHRoZSB1c3VhbA0KPiB0cmFuc2xhdGUgcGF0aCB3aGlj
aCBpbmRlZWQgY2FjaGVzIGNvbmZpZ3MgYW5kIHRyYW5zbGF0aW9ucy4gSW4gY2FzZSB0aGUNCj4g
Z3Vlc3QgaW52YWxpZGF0ZXMgc29tZXRoaW5nLCB5b3Uga25vdyB0aGUgU0lEIGFuZCB5b3UgZmlu
ZCB0aGUgZW50cmllcw0KPiBpbiB0aGUgY2FjaGUgdGhhdCBhcmUgdGFnZ2VkIGJ5IHRoaXMgU0lE
Lg0KDQpOb3QgYWx3YXlzIHlvdSBnZXQgc2lkLCBlZzogQ01EX1RMQklfTkhfQVNJRA0KDQpUaGFu
a3MsDQpTaGFtZWVyDQo=

