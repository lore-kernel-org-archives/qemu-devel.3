Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A1FC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsP2p-0000Kg-0M; Wed, 12 Mar 2025 12:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsP2L-0000HX-Ge; Wed, 12 Mar 2025 12:34:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsP2E-00042M-M3; Wed, 12 Mar 2025 12:34:26 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCbk72XcBz6J9qF;
 Thu, 13 Mar 2025 00:31:43 +0800 (CST)
Received: from frapeml100006.china.huawei.com (unknown [7.182.85.201])
 by mail.maildlp.com (Postfix) with ESMTPS id 139CC1403A0;
 Thu, 13 Mar 2025 00:34:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100006.china.huawei.com (7.182.85.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Mar 2025 17:34:18 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 12 Mar 2025 17:34:18 +0100
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
Subject: RE: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie bus
Thread-Topic: [RFC PATCH v2 05/20] hw/arm/smmuv3-accel: Associate a pxb-pcie
 bus
Thread-Index: AQHbkps6in4QB/PMZUednFRw1zRmILNvm8wAgAAU7IA=
Date: Wed, 12 Mar 2025 16:34:18 +0000
Message-ID: <9ffee8119fc441aeb760073c5f152fa4@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-6-shameerali.kolothum.thodi@huawei.com>
 <79bcc36c-1a12-4b18-a54c-afe734d6bef0@redhat.com>
In-Reply-To: <79bcc36c-1a12-4b18-a54c-afe734d6bef0@redhat.com>
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTIs
IDIwMjUgNDowOCBQTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVl
cmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4g
cWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpn
Z0BudmlkaWEuY29tOyBuaWNvbGluY0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5jb207
IGJlcnJhbmdlQHJlZGhhdC5jb207IG5hdGhhbmNAbnZpZGlhLmNvbTsNCj4gbW9jaHNAbnZpZGlh
LmNvbTsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgTGludXhhcm0NCj4gPGxpbnV4YXJtQGh1YXdlaS5j
b20+OyBXYW5nemhvdSAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsNCj4gamlhbmdrdW5r
dW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhh
bi5jYW1lcm9uQGh1YXdlaS5jb20+OyB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0
OiBSZTogW1JGQyBQQVRDSCB2MiAwNS8yMF0gaHcvYXJtL3NtbXV2My1hY2NlbDogQXNzb2NpYXRl
IGEgcHhiLQ0KPiBwY2llIGJ1cw0KPiANCj4gSGkgU2hhbWVlciwNCj4gDQo+IA0KPiBPbiAzLzEx
LzI1IDM6MTAgUE0sIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4gVXNlcsKgbXVzdCBhc3Nv
Y2lhdGUgYSBweGItcGNpZSByb290IGJ1cyB0byBzbW11djMtYWNjZWwNCj4gPiBhbmQgdGhhdCBp
c8Kgc2V0IGFzIHRoZSBwcmltYXJ5LWJ1cyBmb3IgdGhlIHNtbXUgZGV2Lg0KPiB3aHkgZG8gd2Ug
cmVxdWlyZSBhIHB4Yi1wY2llIHJvb3QgYnVzPyB3aHkgY2FuJ3QgcGNpLjAgcm9vdCBidXMgYmUg
dXNlZA0KPiBmb3Igc2ltcGxlciB1c2UgY2FzZXMgKGllLiBJIGp1c3Qgd2FudCB0byBwYXNzdGhv
dWdoIGEgTklDIGluDQo+IGFjY2VsZXJhdGVkIG1vZGUpLiBPciBtYXkgcGNpLjAgaXMgYWxzbyBj
YWxsZWQgYSBwYXgtcGNpZSByb290IGJ1cz8NCg0KVGhlIGlkZWEgd2FzIHNpbmNlIHBjaWUuMCBp
cyB0aGUgZGVmYXVsdCBSQyB3aXRoIHZpcnQsIGxlYXZlIHRoYXQgdG8gY2FzZXMgd2hlcmUNCndl
IHdhbnQgdG8gYXR0YWNoIGFueSBlbXVsYXRlZCBkZXZpY2VzIGFuZCB1c2UgcHhiLXBjaWUgYmFz
ZWQgUkNzIGZvciB2ZmlvLXBjaS4NCg0KPiANCj4gQmVzaWRlcywgd2h5IGRvIHdlIHB1dCB0aGUg
Y29uc3RyYWludCB0byBwbHVnIG9uIGEgcm9vdCBidXMuIEkga25vdyB0aGF0DQo+IGF0IHRoaXMg
cG9pbnQgd2UgYWx3YXlzIHBsdWcgdG8gcGNpLjAgYnV0IHdpdGggdGhlIG5ldyAtZGV2aWNlIG9w
dGlvbiBpdA0KPiB3b3VsZCBiZSBwb3NzaWJsZSB0byBwbHVnIGl0IGFueXdoZXJlIGluIHRoZSBw
Y2llIGhpZXJhcmNoeS4gQXQgU09DDQo+IGxldmVsIGNhbid0IGFuIFNNTVUgYmUgcGx1Z2dlZCBh
bnl3aGVyZSBwcm90ZWN0aW5nIGp1c3QgYSBmZXcgUklEcz8NCg0KSW4gbXkgdW5kZXJzdGFuZGlu
ZyBub3JtYWxseShvciBhdGxlYXN0IGluIHRoZSBtb3N0IGNvbW1vbiBjYXNlcykgaXQgaXMgYXR0
YWNoZWQgDQp0byByb290IGNvbXBsZXhlcy4gQWxzbyBJT1JUIG1hcHBpbmdzIGFyZSBhdCB0aGUg
cm9vdCBjb21wbGV4IGxldmVsLCByaWdodD8NCg0KVG8gDQo+ID4gU2lnbmVkLW9mZi1ieTogU2hh
bWVlciBLb2xvdGh1bQ0KPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0K
PiA+IC0tLQ0KPiA+ICBody9hcm0vc21tdXYzLWFjY2VsLmMgfCAxOSArKysrKysrKysrKysrKysr
KysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaHcvYXJtL3NtbXV2My1hY2NlbC5jIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+
ID4gaW5kZXggYzMyNzY2MTYzNi4uMTQ3MWI2NTM3NCAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0v
c21tdXYzLWFjY2VsLmMNCj4gPiArKysgYi9ody9hcm0vc21tdXYzLWFjY2VsLmMNCj4gPiBAQCAt
OSw2ICs5LDIxIEBADQo+ID4gICNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+ID4NCj4gPiAgI2lu
Y2x1ZGUgImh3L2FybS9zbW11djMtYWNjZWwuaCINCj4gPiArI2luY2x1ZGUgImh3L3BjaS9wY2lf
YnJpZGdlLmgiDQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHNtbXV2M19hY2NlbF9weGJfcGNpZV9i
dXMoT2JqZWN0ICpvYmosIHZvaWQgKm9wYXF1ZSkNCj4gPiArew0KPiA+ICsgICAgRGV2aWNlU3Rh
dGUgKmQgPSBvcGFxdWU7DQo+ID4gKw0KPiA+ICsgICAgaWYgKG9iamVjdF9keW5hbWljX2Nhc3Qo
b2JqLCAicHhiLXBjaWUtYnVzIikpIHsNCj4gPiArICAgICAgICBQQ0lCdXMgKmJ1cyA9IFBDSV9I
T1NUX0JSSURHRShvYmotPnBhcmVudCktPmJ1czsNCj4gPiArICAgICAgICBpZiAoZC0+cGFyZW50
X2J1cyAmJiAhc3RyY21wKGJ1cy0+cWJ1cy5uYW1lLCBkLT5wYXJlbnRfYnVzLQ0KPiA+bmFtZSkp
IHsNCj4gPiArICAgICAgICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVChkKSwg
InByaW1hcnktYnVzIiwgT0JKRUNUKGJ1cyksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmZXJyb3JfYWJvcnQpOw0KPiBpZiB5b3Ugd2FudCB0byBzdG9wIHRoZSBy
ZWN1cnNpdmUgc2VhcmNoIEkgdGhpbmsgeW91IG5lZWQgdG8gcmV0dXJuDQo+IHNvbWV0aGluZyAh
PSAwIGhlcmUuDQoNCk9rLg0KIA0KPiBJIGRvbid0IHJlYWxseSB1bmRlcnN0YW5kIHdoeSB3ZSBk
b24ndCBzaW1wbHkgc2V0IHRoZSBwcmltYXJ5LWJ1cyB0bw0KPiA8YnVzPiB3aGVyZSAtZGV2aWNl
IGFybS1zbW11djMtYWNjZWwsIGJ1cz08YnVzPj8gb3IgbWF5YmUgZW5mb3JjZSB0aGF0DQo+IHRo
aXMgYnVzIGlzIGFuIGFjdHVhbCByb290IGJ1cyBpZiB3ZSByZWFsbHkgbmVlZCB0aGF0Pw0KDQpU
aGUgcHJpbWFyeS1idXMgaGVyZSBpcyBhY3R1YWxseSB0aGUgcHJvcGVydHkgb2YgdGhlIHBhcmVu
dCBTTU1VIGRldmljZS4NClRoaXMgb25lIG5vdyBoYXMsDQoNCi1kZXZpY2UgYXJtLXNtbXV2My1h
Y2NlbCwgYnVzIGZvcm1hdC4NCg0KDQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICsg
ICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBzbW11X2FjY2VsX3Jl
YWxpemUoRGV2aWNlU3RhdGUgKmQsIEVycm9yICoqZXJycCkNCj4gPiAgew0KPiA+IEBAIC0xNyw2
ICszMiw5IEBAIHN0YXRpYyB2b2lkIHNtbXVfYWNjZWxfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZCwg
RXJyb3INCj4gKiplcnJwKQ0KPiA+ICAgICAgU3lzQnVzRGV2aWNlICpkZXYgPSBTWVNfQlVTX0RF
VklDRShkKTsNCj4gPiAgICAgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPiA+DQo+ID4gKyAg
ICBvYmplY3RfY2hpbGRfZm9yZWFjaF9yZWN1cnNpdmUob2JqZWN0X2dldF9yb290KCksDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc21tdXYzX2FjY2VsX3B4Yl9wY2ll
X2J1cywgZCk7DQo+ID4gKw0KPiA+ICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9CSkVD
VChkZXYpLCAiYWNjZWwiLCB0cnVlLCAmZXJyb3JfYWJvcnQpOw0KPiA+ICAgICAgYy0+cGFyZW50
X3JlYWxpemUoZCwgJmxvY2FsX2Vycik7DQo+ID4gICAgICBpZiAobG9jYWxfZXJyKSB7DQo+ID4g
QEAgLTMzLDYgKzUxLDcgQEAgc3RhdGljIHZvaWQgc21tdXYzX2FjY2VsX2NsYXNzX2luaXQoT2Jq
ZWN0Q2xhc3MNCj4gKmtsYXNzLCB2b2lkICpkYXRhKQ0KPiA+ICAgICAgZGV2aWNlX2NsYXNzX3Nl
dF9wYXJlbnRfcmVhbGl6ZShkYywgc21tdV9hY2NlbF9yZWFsaXplLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmYy0+cGFyZW50X3JlYWxpemUpOw0KPiA+ICAgICAg
ZGMtPmhvdHBsdWdnYWJsZSA9IGZhbHNlOw0KPiA+ICsgICAgZGMtPmJ1c190eXBlID0gVFlQRV9Q
Q0lFX0JVUzsNCj4gc2hvdWxkbid0IGl0IGJlbG93IHRvIDMvMjA/IEl0IGlzIG5vdCByZWFsbHkg
cmVsYXRlZCB0byBwcmltYXJ5X2J1cw0KPiBzZXR0aW5nPw0KDQpUaGlzIGlzIHRvIHNldCB0aGUg
YnVzIHByb3BlcnR5IG9mIHRoaXMgc21tdXYzLWFjY2VsIGRldmljZS4gQXMgbWVudGlvbmVkIA0K
YWJvdmUgcHJpbWFyeS1idXMgaXMgdGhlIHByb3BlcnR5IG9mIHBhcmVudCBUWVBFX0FSTV9TTU1V
IGRldmljZS4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

