Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B951C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFFH-0002Sk-3R; Tue, 08 Jul 2025 16:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZE3e-0006xa-5b; Tue, 08 Jul 2025 15:32:57 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZE3R-0003kM-99; Tue, 08 Jul 2025 15:32:45 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bbvzF4Sywz6DBPV;
 Tue,  8 Jul 2025 16:53:45 +0800 (CST)
Received: from frapeml100007.china.huawei.com (unknown [7.182.85.133])
 by mail.maildlp.com (Postfix) with ESMTPS id 5910B1402EA;
 Tue,  8 Jul 2025 16:54:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 10:54:49 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 8 Jul 2025 10:54:49 +0200
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v6 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Thread-Topic: [PATCH v6 08/12] hw/arm/virt: Allow user-creatable SMMUv3 dev
 instantiation
Thread-Index: AQHb6/xJlPtpAHu5pEuj91bLuyZP37QnvekAgAA0r1A=
Date: Tue, 8 Jul 2025 08:54:49 +0000
Message-ID: <e4cd2ccede7b46df9bbcf63dcf492fcf@huawei.com>
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
 <20250703084643.85740-9-shameerali.kolothum.thodi@huawei.com>
 <b05cd1f5-db7a-45d3-a582-85c808adcd04@redhat.com>
In-Reply-To: <b05cd1f5-db7a-45d3-a582-85c808adcd04@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.203.177.241]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgOCwgMjAy
NSA4OjQxIEFNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+IDxzaGFtZWVyYWxp
LmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOw0KPiBxZW11
LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgamdnQG52
aWRpYS5jb207IG5pY29saW5jQG52aWRpYS5jb207DQo+IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVy
cmFuZ2VAcmVkaGF0LmNvbTsgaW1hbW1lZG9AcmVkaGF0LmNvbTsNCj4gbmF0aGFuY0BudmlkaWEu
Y29tOyBtb2Noc0BudmlkaWEuY29tOyBzbW9zdGFmYUBnb29nbGUuY29tOw0KPiBndXN0YXZvLnJv
bWVyb0BsaW5hcm8ub3JnOyBtc3RAcmVkaGF0LmNvbTsNCj4gbWFyY2VsLmFwZmVsYmF1bUBnbWFp
bC5jb207IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsNCj4gV2FuZ3pob3UgKEIpIDx3
YW5nemhvdTFAaGlzaWxpY29uLmNvbT47IGppYW5na3Vua3VuDQo+IDxqaWFuZ2t1bmt1bkBodWF3
ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29t
PjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwOC8x
Ml0gaHcvYXJtL3ZpcnQ6IEFsbG93IHVzZXItY3JlYXRhYmxlIFNNTVV2Mw0KPiBkZXYgaW5zdGFu
dGlhdGlvbg0KPiANCj4gSGkgU2hhbWVlciwNCj4gDQo+IE9uIDcvMy8yNSAxMDo0NiBBTSwgU2hh
bWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBBbGxvdyBjb2xkLXBsdWdnaW5nIG9mIGFuIFNNTVV2
MyBkZXZpY2Ugb24gdGhlIHZpcnQgbWFjaGluZSB3aGVuIG5vDQo+ID4gZ2xvYmFsIChsZWdhY3kp
IFNNTVV2MyBpcyBwcmVzZW50IG9yIHdoZW4gYSB2aXJ0aW8taW9tbXUgaXMgc3BlY2lmaWVkLg0K
PiA+DQo+ID4gVGhpcyB1c2VyLWNyZWF0ZWQgU01NVXYzIGRldmljZSBpcyB0aWVkIHRvIGEgc3Bl
Y2lmaWMgUENJIGJ1cyBwcm92aWRlZA0KPiA+IGJ5IHRoZSB1c2VyLCBzbyBlbnN1cmUgdGhlIElP
TU1VIG9wcyBhcmUgY29uZmlndXJlZCBhY2NvcmRpbmdseS4NCj4gPg0KPiA+IER1ZSB0byBjdXJy
ZW50IGxpbWl0YXRpb25zIGluIFFFTVXigJlzIGRldmljZSB0cmVlIHN1cHBvcnQsIHNwZWNpZmlj
YWxseQ0KPiA+IGl0cyBpbmFiaWxpdHkgdG8gcHJvcGVybHkgcHJlc2VudCBweGItcGNpZSBiYXNl
ZCByb290IGNvbXBsZXhlcyBhbmQNCj4gPiB0aGVpciBkZXZpY2VzLCB0aGUgZGV2aWNlIHRyZWUg
c3VwcG9ydCBmb3IgdGhlIG5ldyBTTU1VdjMgZGV2aWNlIGlzDQo+ID4gbGltaXRlZCB0byBjYXNl
cyB3aGVyZSBpdCBpcyBhdHRhY2hlZCB0byB0aGUgZGVmYXVsdCBwY2llLjAgcm9vdCBjb21wbGV4
Lg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVy
b25AaHVhd2VpLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckBy
ZWRoYXQuY29tPg0KPiA+IFRlc3RlZC1ieTogTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVyYWxpLmtv
bG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L2FybS9zbW11LWNvbW1v
bi5jICAgICAgICAgfCAgOCArKysrKy0NCj4gPiAgaHcvYXJtL3NtbXV2My5jICAgICAgICAgICAg
ICB8ICAyICsrDQo+ID4gIGh3L2FybS92aXJ0LmMgICAgICAgICAgICAgICAgfCA1MCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaHcvY29yZS9zeXNidXMtZmR0LmMg
ICAgICAgICB8ICAzICsrKw0KPiA+ICBpbmNsdWRlL2h3L2FybS9zbW11LWNvbW1vbi5oIHwgIDEg
Kw0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vc21tdS1jb21tb24uYyBiL2h3L2FybS9zbW11
LWNvbW1vbi5jDQo+ID4gaW5kZXggYjE1ZTdmZDBlNC4uMmVlNDY5MTI5OSAxMDA2NDQNCj4gPiAt
LS0gYS9ody9hcm0vc21tdS1jb21tb24uYw0KPiA+ICsrKyBiL2h3L2FybS9zbW11LWNvbW1vbi5j
DQo+ID4gQEAgLTk1OSw3ICs5NTksMTIgQEAgc3RhdGljIHZvaWQgc21tdV9iYXNlX3JlYWxpemUo
RGV2aWNlU3RhdGUgKmRldiwNCj4gRXJyb3IgKiplcnJwKQ0KPiA+ICAgICAgICAgICAgICAgICAg
Z290byBvdXRfZXJyOw0KPiA+ICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgfQ0KPiA+IC0g
ICAgICAgIHBjaV9zZXR1cF9pb21tdShwY2lfYnVzLCAmc21tdV9vcHMsIHMpOw0KPiA+ICsNCj4g
PiArICAgICAgICBpZiAocy0+c21tdV9wZXJfYnVzKSB7DQo+ID4gKyAgICAgICAgICAgIHBjaV9z
ZXR1cF9pb21tdV9wZXJfYnVzKHBjaV9idXMsICZzbW11X29wcywgcyk7DQo+ID4gKyAgICAgICAg
fSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgcGNpX3NldHVwX2lvbW11KHBjaV9idXMsICZzbW11
X29wcywgcyk7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICAgICAgICAgIHJldHVybjsNCj4gPiAgICAg
IH0NCj4gPiAgb3V0X2VycjoNCj4gPiBAQCAtOTg0LDYgKzk4OSw3IEBAIHN0YXRpYyB2b2lkIHNt
bXVfYmFzZV9yZXNldF9leGl0KE9iamVjdCAqb2JqLA0KPiBSZXNldFR5cGUgdHlwZSkNCj4gPg0K
PiA+ICBzdGF0aWMgY29uc3QgUHJvcGVydHkgc21tdV9kZXZfcHJvcGVydGllc1tdID0gew0KPiA+
ICAgICAgREVGSU5FX1BST1BfVUlOVDgoImJ1c19udW0iLCBTTU1VU3RhdGUsIGJ1c19udW0sIDAp
LA0KPiA+ICsgICAgREVGSU5FX1BST1BfQk9PTCgic21tdV9wZXJfYnVzIiwgU01NVVN0YXRlLCBz
bW11X3Blcl9idXMsDQo+IGZhbHNlKSwNCj4gPiAgICAgIERFRklORV9QUk9QX0xJTksoInByaW1h
cnktYnVzIiwgU01NVVN0YXRlLCBwcmltYXJ5X2J1cywNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgVFlQRV9QQ0lfQlVTLCBQQ0lCdXMgKiksDQo+ID4gIH07DQo+ID4gZGlmZiAtLWdpdCBhL2h3
L2FybS9zbW11djMuYyBiL2h3L2FybS9zbW11djMuYw0KPiA+IGluZGV4IGFiNjc5NzIzNTMuLmJj
ZjhhZjhkYzcgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2My5jDQo+ID4gKysrIGIvaHcv
YXJtL3NtbXV2My5jDQo+ID4gQEAgLTE5OTYsNiArMTk5Niw4IEBAIHN0YXRpYyB2b2lkIHNtbXV2
M19jbGFzc19pbml0KE9iamVjdENsYXNzDQo+ICprbGFzcywgY29uc3Qgdm9pZCAqZGF0YSkNCj4g
PiAgICAgIGRldmljZV9jbGFzc19zZXRfcGFyZW50X3JlYWxpemUoZGMsIHNtbXVfcmVhbGl6ZSwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmMtPnBhcmVudF9yZWFs
aXplKTsNCj4gPiAgICAgIGRldmljZV9jbGFzc19zZXRfcHJvcHMoZGMsIHNtbXV2M19wcm9wZXJ0
aWVzKTsNCj4gPiArICAgIGRjLT5ob3RwbHVnZ2FibGUgPSBmYWxzZTsNCj4gPiArICAgIGRjLT51
c2VyX2NyZWF0YWJsZSA9IHRydWU7DQo+ID4gIH0NCj4gPg0KPiA+ICBzdGF0aWMgaW50IHNtbXV2
M19ub3RpZnlfZmxhZ19jaGFuZ2VkKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSwNCj4gPiBkaWZm
IC0tZ2l0IGEvaHcvYXJtL3ZpcnQuYyBiL2h3L2FybS92aXJ0LmMNCj4gPiBpbmRleCAwNWExNDg4
MWNmLi44NjYyMTczYzQzIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS92aXJ0LmMNCj4gPiArKysg
Yi9ody9hcm0vdmlydC5jDQo+ID4gQEAgLTU2LDYgKzU2LDcgQEANCj4gPiAgI2luY2x1ZGUgInFl
bXUvY3V0aWxzLmgiDQo+ID4gICNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPiA+ICAj
aW5jbHVkZSAicWVtdS9tb2R1bGUuaCINCj4gPiArI2luY2x1ZGUgImh3L3BjaS9wY2lfYnVzLmgi
DQo+ID4gICNpbmNsdWRlICJody9wY2ktaG9zdC9ncGV4LmgiDQo+ID4gICNpbmNsdWRlICJody92
aXJ0aW8vdmlydGlvLXBjaS5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvY29yZS9zeXNidXMtZmR0Lmgi
DQo+ID4gQEAgLTE0NDAsNiArMTQ0MSwyOCBAQCBzdGF0aWMgdm9pZCBjcmVhdGVfc21tdXYzX2R0
X2JpbmRpbmdzKGNvbnN0DQo+IFZpcnRNYWNoaW5lU3RhdGUgKnZtcywgaHdhZGRyIGJhc2UsDQo+
ID4gICAgICBnX2ZyZWUobm9kZSk7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBjcmVh
dGVfc21tdXYzX2Rldl9kdGIoVmlydE1hY2hpbmVTdGF0ZSAqdm1zLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgRGV2aWNlU3RhdGUgKmRldiwgUENJQnVzICpidXMpDQo+
ID4gK3sNCj4gPiArICAgIFBsYXRmb3JtQnVzRGV2aWNlICpwYnVzID0gUExBVEZPUk1fQlVTX0RF
VklDRSh2bXMtDQo+ID5wbGF0Zm9ybV9idXNfZGV2KTsNCj4gPiArICAgIFN5c0J1c0RldmljZSAq
c2JkZXYgPSBTWVNfQlVTX0RFVklDRShkZXYpOw0KPiA+ICsgICAgaW50IGlycSA9IHBsYXRmb3Jt
X2J1c19nZXRfaXJxbihwYnVzLCBzYmRldiwgMCk7DQo+ID4gKyAgICBod2FkZHIgYmFzZSA9IHBs
YXRmb3JtX2J1c19nZXRfbW1pb19hZGRyKHBidXMsIHNiZGV2LCAwKTsNCj4gPiArICAgIE1hY2hp
bmVTdGF0ZSAqbXMgPSBNQUNISU5FKHZtcyk7DQo+ID4gKw0KPiA+ICsgICAgaWYgKHN0cmNtcCgi
cGNpZS4wIiwgYnVzLT5xYnVzLm5hbWUpKSB7DQo+ID4gKyAgICAgICAgd2Fybl9yZXBvcnQoIlNN
TVV2MyBkZXZpY2Ugb25seSBzdXBwb3J0ZWQgd2l0aCBwY2llLjAgZm9yIERUIik7DQo+IHdoaWxl
IHRlc3RpbmcgdGhlIHNlcmllcyBJIGhpdCB0aGUgd2FybmluZyB3aXRoIGEgcmhlbCBndWVzdCB3
aGljaCBib290cw0KPiB3aXRoIEFDUEkuDQo+IEkgdGhpbmsgd2Ugc2hhbGwgbWFrZSB0aGUgY2hl
Y2sgc21hcnRlciB0byBhdm9pZCB0aGF0Lg0KPiBtYXliZSBhbHNvIGNoZWNrIGZpcm13YXJlX2xv
YWRlZCBhbmQgdmlydF9pc19hY3BpX2VuYWJsZWQoKT8NCg0KVGhhbmtzIGZvciBnaXZpbmcgaXQg
YSBzcGluLiBZZXMsIGp1c3QgY29uZmlybWVkIHRoYXQgdGhlIHdhcm5pbmcgYXBwZWFycy4NClRo
ZSBhYm92ZSBjaGVjayB3aWxsIHdvcmssIGJ1dCBjYW4gd2UgbWFrZSB1c2Ugb2Ygdm1zLT5hY3Bp
X2RldiBmb3INCnRoaXMgY2hlY2sgaW5zdGVhZD8gSXQgaXMgZXNzZW50aWFsbHkgdGhlIHNhbWUg
YW5kIEkgdGhpbmsgdGhhdCB3aWxsIHdvcmsuIA0KDQogICAgaWYgKCF2bXMtPmFjcGlfZGV2ICYm
IHN0cmNtcCgicGNpZS4wIiwgYnVzLT5xYnVzLm5hbWUpKQ0KDQpQbGVhc2UgbGV0IG1lIGtub3cu
DQoNClRoYW5rcywNClNoYW1lZXINCg==

