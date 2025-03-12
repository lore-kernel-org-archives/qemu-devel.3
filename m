Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91120C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 17:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsPsX-0007yc-Nu; Wed, 12 Mar 2025 13:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsPsR-0007rM-Fj; Wed, 12 Mar 2025 13:28:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsPsO-0004C9-WC; Wed, 12 Mar 2025 13:28:19 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCct824pyz6J6lm;
 Thu, 13 Mar 2025 01:23:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 738C4140736;
 Thu, 13 Mar 2025 01:28:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Mar 2025 18:28:13 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 12 Mar 2025 18:28:13 +0100
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Thread-Topic: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie
 bus
Thread-Index: AQHbkps6in4QB/PMZUednFRw1zRmILNvm8wAgAAU7ID///PiAIAAHBLA
Date: Wed, 12 Mar 2025 17:28:13 +0000
Message-ID: <2f44b284cb854844889b9ee8b6239e0a@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <79bcc36c-1a12-4b18-a54c-afe734d6bef0@redhat.com>
 <9ffee8119fc441aeb760073c5f152fa4@huawei.com> <Z9G4sj9sHNYb1t78@redhat.com>
In-Reply-To: <Z9G4sj9sHNYb1t78@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFAuIEJlcnJh
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxMiwg
MjAyNSA0OjM5IFBNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxp
LmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IENjOiBlcmljLmF1Z2VyQHJlZGhhdC5jb207
IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtDQo+IGRldmVsQG5vbmdudS5vcmc7IHBldGVyLm1h
eWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207DQo+IG5pY29saW5jQG52aWRpYS5jb207
IGRkdXRpbGVAcmVkaGF0LmNvbTsgbmF0aGFuY0BudmlkaWEuY29tOw0KPiBtb2Noc0BudmlkaWEu
Y29tOyBzbW9zdGFmYUBnb29nbGUuY29tOyBMaW51eGFybQ0KPiA8bGludXhhcm1AaHVhd2VpLmNv
bT47IFdhbmd6aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+Ow0KPiBqaWFuZ2t1bmt1
biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUkZDIFBBVENIIHYyIDA1LzIwXSBody9hcm0vc21tdXYzLWFjY2VsOiBBc3NvY2lhdGUg
YSBweGItDQo+IHBjaWUgYnVzDQo+IA0KPiBPbiBXZWQsIE1hciAxMiwgMjAyNSBhdCAwNDozNDox
OFBNICswMDAwLCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IHdyb3RlOg0KPiA+IEhpIEVy
aWMsDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBF
cmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXks
IE1hcmNoIDEyLCAyMDI1IDQ6MDggUE0NCj4gPiA+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRo
b2RpDQo+ID4gPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1h
cm1Abm9uZ251Lm9yZzsNCj4gPiA+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+ID4gQ2M6IHBl
dGVyLm1heWRlbGxAbGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207IG5pY29saW5jQG52aWRpYS5j
b207DQo+ID4gPiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5jb207IG5hdGhh
bmNAbnZpZGlhLmNvbTsNCj4gPiA+IG1vY2hzQG52aWRpYS5jb207IHNtb3N0YWZhQGdvb2dsZS5j
b207IExpbnV4YXJtDQo+ID4gPiA8bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKSA8
d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+Ow0KPiA+ID4gamlhbmdrdW5rdW4gPGppYW5na3Vua3Vu
QGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+ID4gPiA8am9uYXRoYW4uY2FtZXJvbkBo
dWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gPiA+IFN1YmplY3Q6IFJlOiBb
UkZDIFBBVENIIHYyIDA1LzIwXSBody9hcm0vc21tdXYzLWFjY2VsOiBBc3NvY2lhdGUgYQ0KPiBw
eGItDQo+ID4gPiBwY2llIGJ1cw0KPiA+ID4NCj4gPiA+IEhpIFNoYW1lZXIsDQo+ID4gPg0KPiA+
ID4NCj4gPiA+IE9uIDMvMTEvMjUgMzoxMCBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4g
PiA+ID4gVXNlcsKgbXVzdCBhc3NvY2lhdGUgYSBweGItcGNpZSByb290IGJ1cyB0byBzbW11djMt
YWNjZWwNCj4gPiA+ID4gYW5kIHRoYXQgaXPCoHNldCBhcyB0aGUgcHJpbWFyeS1idXMgZm9yIHRo
ZSBzbW11IGRldi4NCj4gPiA+IHdoeSBkbyB3ZSByZXF1aXJlIGEgcHhiLXBjaWUgcm9vdCBidXM/
IHdoeSBjYW4ndCBwY2kuMCByb290IGJ1cyBiZSB1c2VkDQo+ID4gPiBmb3Igc2ltcGxlciB1c2Ug
Y2FzZXMgKGllLiBJIGp1c3Qgd2FudCB0byBwYXNzdGhvdWdoIGEgTklDIGluDQo+ID4gPiBhY2Nl
bGVyYXRlZCBtb2RlKS4gT3IgbWF5IHBjaS4wIGlzIGFsc28gY2FsbGVkIGEgcGF4LXBjaWUgcm9v
dCBidXM/DQo+ID4NCj4gPiBUaGUgaWRlYSB3YXMgc2luY2UgcGNpZS4wIGlzIHRoZSBkZWZhdWx0
IFJDIHdpdGggdmlydCwgbGVhdmUgdGhhdCB0byBjYXNlcw0KPiB3aGVyZQ0KPiA+IHdlIHdhbnQg
dG8gYXR0YWNoIGFueSBlbXVsYXRlZCBkZXZpY2VzIGFuZCB1c2UgcHhiLXBjaWUgYmFzZWQgUkNz
IGZvcg0KPiB2ZmlvLXBjaS4NCj4gDQo+IFRoZSBtYWpvcml0eSBvZiBtYW5hZ2VtZW50IGFwcGxp
Y2F0aW9ucyB3aWxsIG5ldmVyIGRvIGFueXRoaW5nIG90aGVyDQo+IHRoYW4gYSBmbGF0IFBDSShl
KSB0b3BvbG9neSBieSBkZWZhdWx0LiBTb21lIG1pZ2h0IGVuYWJsZSBweGItcGNpZSBhcw0KPiBh
biBvcHRpb25hbCBidXQgcGxlbnR5IHdvbid0IGV2ZXIgc3VwcG9ydCBpdC4gSWYgeW91IHdhbnQg
dG8gbWF4aW1pc2UNCj4gdGhlIHBvdGVudGlhbCB1c2VmdWxuZXNzIG9mIHRoZSBzc21tdXYzLWFj
Y2VsLCBhbmQgaXQgaXMgdGVjaG5pY2FsbHkNCj4gdmlhYmxlLCBpdCB3b3VsZCBiZSB3b3J0aCBw
ZXJtaXR0aW5nIGNob2ljZSBvZiBhdHRhY2htZW50IHRvIHRoZSByb290DQo+IGJ1cyBhcyBhbiBh
bHRlcmFuYXRpdmUgdG8gdGhlIHB4Yi4NCg0KT2suIEkgd2lsbCBsb29rIGludG8gdGhpcy4gVGhv
dWdoIEkgYW0gbm90IHN1cmUgd2hlbiB3ZSBoYXZlIHNtbXV2My1hY2NlbA0KdG8gcGNpZS4wIHdl
IGNhbiBzdGlsbCBoYXZlIGFkZGl0aW9uYWwgc21tdXYzLWFjY2VsIHdpdGggcHhiLXBjaWUgb3Ig
bm90Lg0KSXQgbG9va3MgbGlrZSBweGItcGNpZSB3aWxsIGJlIHBsdWdnZWQgaW50byBwY2llLjAu
IEFuZCBpZiB0aGF0IGlzIHRoZSBjYXNlDQpJT1JUIG1hcHBpbmdzIHdpbGwgYmUgZGlmZmljdWx0
IEkgZ3Vlc3MuIEkgbmVlZCB0byBkb3VibGUgY2hlY2suDQoNClRoYW5rcywNClNoYW1lZXINCg==

