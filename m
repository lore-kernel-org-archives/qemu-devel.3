Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11856C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEaz-00058o-9z; Tue, 08 Jul 2025 16:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZDS4-0000hx-A3; Tue, 08 Jul 2025 14:54:15 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uZDRh-00080A-CN; Tue, 08 Jul 2025 14:53:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bc47j01xtz6GFHW;
 Tue,  8 Jul 2025 23:01:37 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 1B9C3140433;
 Tue,  8 Jul 2025 23:02:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 17:02:40 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 8 Jul 2025 17:02:40 +0200
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
Thread-Index: AQHb6/xJlPtpAHu5pEuj91bLuyZP37QnvekAgAA0r1D///DkgIAAdq2Q
Date: Tue, 8 Jul 2025 15:02:40 +0000
Message-ID: <d2b262d012dd4d65a0bccaa036d4faf0@huawei.com>
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
 <20250703084643.85740-9-shameerali.kolothum.thodi@huawei.com>
 <b05cd1f5-db7a-45d3-a582-85c808adcd04@redhat.com>
 <e4cd2ccede7b46df9bbcf63dcf492fcf@huawei.com>
 <45c112f4-bcd3-44a1-a7b9-1ff0fa807f01@redhat.com>
In-Reply-To: <45c112f4-bcd3-44a1-a7b9-1ff0fa807f01@redhat.com>
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
NSAxMDo1NiBBTQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiA8c2hhbWVlcmFs
aS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsgcWVtdS1hcm1Abm9uZ251Lm9yZzsNCj4gcWVt
dS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IGpnZ0Bu
dmlkaWEuY29tOyBuaWNvbGluY0BudmlkaWEuY29tOw0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJl
cnJhbmdlQHJlZGhhdC5jb207IGltYW1tZWRvQHJlZGhhdC5jb207DQo+IG5hdGhhbmNAbnZpZGlh
LmNvbTsgbW9jaHNAbnZpZGlhLmNvbTsgc21vc3RhZmFAZ29vZ2xlLmNvbTsNCj4gZ3VzdGF2by5y
b21lcm9AbGluYXJvLm9yZzsgbXN0QHJlZGhhdC5jb207DQo+IG1hcmNlbC5hcGZlbGJhdW1AZ21h
aWwuY29tOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+IFdhbmd6aG91IChCKSA8
d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+OyBqaWFuZ2t1bmt1bg0KPiA8amlhbmdrdW5rdW5AaHVh
d2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNv
bT47IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDgv
MTJdIGh3L2FybS92aXJ0OiBBbGxvdyB1c2VyLWNyZWF0YWJsZSBTTU1VdjMNCj4gZGV2IGluc3Rh
bnRpYXRpb24NCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiBPbiA3LzgvMjUgMTA6NTQgQU0sIFNo
YW1lZXJhbGkgS29sb3RodW0gVGhvZGkgd3JvdGU6DQo+ID4gSGkgRXJpYywNCj4gPg0KPiA+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1
Z2VyQHJlZGhhdC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgOCwgMjAyNSA4OjQxIEFN
DQo+ID4+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+ID4+IDxzaGFtZWVyYWxpLmtv
bG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOw0KPiA+PiBxZW11
LWRldmVsQG5vbmdudS5vcmcNCj4gPj4gQ2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgamdn
QG52aWRpYS5jb207IG5pY29saW5jQG52aWRpYS5jb207DQo+ID4+IGRkdXRpbGVAcmVkaGF0LmNv
bTsgYmVycmFuZ2VAcmVkaGF0LmNvbTsgaW1hbW1lZG9AcmVkaGF0LmNvbTsNCj4gPj4gbmF0aGFu
Y0BudmlkaWEuY29tOyBtb2Noc0BudmlkaWEuY29tOyBzbW9zdGFmYUBnb29nbGUuY29tOw0KPiA+
PiBndXN0YXZvLnJvbWVyb0BsaW5hcm8ub3JnOyBtc3RAcmVkaGF0LmNvbTsNCj4gPj4gbWFyY2Vs
LmFwZmVsYmF1bUBnbWFpbC5jb207IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsNCj4g
Pj4gV2FuZ3pob3UgKEIpIDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47IGppYW5na3Vua3VuDQo+
ID4+IDxqaWFuZ2t1bmt1bkBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA+PiA8am9u
YXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgemhhbmdmZWkuZ2FvQGxpbmFyby5vcmcNCj4gPj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NiAwOC8xMl0gaHcvYXJtL3ZpcnQ6IEFsbG93IHVzZXItY3Jl
YXRhYmxlDQo+IFNNTVV2Mw0KPiA+PiBkZXYgaW5zdGFudGlhdGlvbg0KPiA+Pg0KPiA+PiBIaSBT
aGFtZWVyLA0KPiA+Pg0KPiA+PiBPbiA3LzMvMjUgMTA6NDYgQU0sIFNoYW1lZXIgS29sb3RodW0g
d3JvdGU6DQo+ID4+PiBBbGxvdyBjb2xkLXBsdWdnaW5nIG9mIGFuIFNNTVV2MyBkZXZpY2Ugb24g
dGhlIHZpcnQgbWFjaGluZSB3aGVuIG5vDQo+ID4+PiBnbG9iYWwgKGxlZ2FjeSkgU01NVXYzIGlz
IHByZXNlbnQgb3Igd2hlbiBhIHZpcnRpby1pb21tdSBpcyBzcGVjaWZpZWQuDQo+ID4+Pg0KPiA+
Pj4gVGhpcyB1c2VyLWNyZWF0ZWQgU01NVXYzIGRldmljZSBpcyB0aWVkIHRvIGEgc3BlY2lmaWMg
UENJIGJ1cyBwcm92aWRlZA0KPiA+Pj4gYnkgdGhlIHVzZXIsIHNvIGVuc3VyZSB0aGUgSU9NTVUg
b3BzIGFyZSBjb25maWd1cmVkIGFjY29yZGluZ2x5Lg0KPiA+Pj4NCj4gPj4+IER1ZSB0byBjdXJy
ZW50IGxpbWl0YXRpb25zIGluIFFFTVXigJlzIGRldmljZSB0cmVlIHN1cHBvcnQsIHNwZWNpZmlj
YWxseQ0KPiA+Pj4gaXRzIGluYWJpbGl0eSB0byBwcm9wZXJseSBwcmVzZW50IHB4Yi1wY2llIGJh
c2VkIHJvb3QgY29tcGxleGVzIGFuZA0KPiA+Pj4gdGhlaXIgZGV2aWNlcywgdGhlIGRldmljZSB0
cmVlIHN1cHBvcnQgZm9yIHRoZSBuZXcgU01NVXYzIGRldmljZSBpcw0KPiA+Pj4gbGltaXRlZCB0
byBjYXNlcyB3aGVyZSBpdCBpcyBhdHRhY2hlZCB0byB0aGUgZGVmYXVsdCBwY2llLjAgcm9vdCBj
b21wbGV4Lg0KPiA+Pj4NCj4gPj4+IFJldmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxqb25h
dGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+DQo+ID4+PiBSZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8
ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiA+Pj4gVGVzdGVkLWJ5OiBOYXRoYW4gQ2hlbiA8bmF0
aGFuY0BudmlkaWEuY29tPg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bQ0K
PiA+PiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+Pj4gLS0tDQo+
ID4+PiAgaHcvYXJtL3NtbXUtY29tbW9uLmMgICAgICAgICB8ICA4ICsrKysrLQ0KPiA+Pj4gIGh3
L2FybS9zbW11djMuYyAgICAgICAgICAgICAgfCAgMiArKw0KPiA+Pj4gIGh3L2FybS92aXJ0LmMg
ICAgICAgICAgICAgICAgfCA1MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPj4+ICBody9jb3JlL3N5c2J1cy1mZHQuYyAgICAgICAgIHwgIDMgKysrDQo+ID4+PiAgaW5j
bHVkZS9ody9hcm0vc21tdS1jb21tb24uaCB8ICAxICsNCj4gPj4+ICA1IGZpbGVzIGNoYW5nZWQs
IDYzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0
IGEvaHcvYXJtL3NtbXUtY29tbW9uLmMgYi9ody9hcm0vc21tdS1jb21tb24uYw0KPiA+Pj4gaW5k
ZXggYjE1ZTdmZDBlNC4uMmVlNDY5MTI5OSAxMDA2NDQNCj4gPj4+IC0tLSBhL2h3L2FybS9zbW11
LWNvbW1vbi5jDQo+ID4+PiArKysgYi9ody9hcm0vc21tdS1jb21tb24uYw0KPiA+Pj4gQEAgLTk1
OSw3ICs5NTksMTIgQEAgc3RhdGljIHZvaWQgc21tdV9iYXNlX3JlYWxpemUoRGV2aWNlU3RhdGUN
Cj4gKmRldiwNCj4gPj4gRXJyb3IgKiplcnJwKQ0KPiA+Pj4gICAgICAgICAgICAgICAgICBnb3Rv
IG91dF9lcnI7DQo+ID4+PiAgICAgICAgICAgICAgfQ0KPiA+Pj4gICAgICAgICAgfQ0KPiA+Pj4g
LSAgICAgICAgcGNpX3NldHVwX2lvbW11KHBjaV9idXMsICZzbW11X29wcywgcyk7DQo+ID4+PiAr
DQo+ID4+PiArICAgICAgICBpZiAocy0+c21tdV9wZXJfYnVzKSB7DQo+ID4+PiArICAgICAgICAg
ICAgcGNpX3NldHVwX2lvbW11X3Blcl9idXMocGNpX2J1cywgJnNtbXVfb3BzLCBzKTsNCj4gPj4+
ICsgICAgICAgIH0gZWxzZSB7DQo+ID4+PiArICAgICAgICAgICAgcGNpX3NldHVwX2lvbW11KHBj
aV9idXMsICZzbW11X29wcywgcyk7DQo+ID4+PiArICAgICAgICB9DQo+ID4+PiAgICAgICAgICBy
ZXR1cm47DQo+ID4+PiAgICAgIH0NCj4gPj4+ICBvdXRfZXJyOg0KPiA+Pj4gQEAgLTk4NCw2ICs5
ODksNyBAQCBzdGF0aWMgdm9pZCBzbW11X2Jhc2VfcmVzZXRfZXhpdChPYmplY3QgKm9iaiwNCj4g
Pj4gUmVzZXRUeXBlIHR5cGUpDQo+ID4+PiAgc3RhdGljIGNvbnN0IFByb3BlcnR5IHNtbXVfZGV2
X3Byb3BlcnRpZXNbXSA9IHsNCj4gPj4+ICAgICAgREVGSU5FX1BST1BfVUlOVDgoImJ1c19udW0i
LCBTTU1VU3RhdGUsIGJ1c19udW0sIDApLA0KPiA+Pj4gKyAgICBERUZJTkVfUFJPUF9CT09MKCJz
bW11X3Blcl9idXMiLCBTTU1VU3RhdGUsIHNtbXVfcGVyX2J1cywNCj4gPj4gZmFsc2UpLA0KPiA+
Pj4gICAgICBERUZJTkVfUFJPUF9MSU5LKCJwcmltYXJ5LWJ1cyIsIFNNTVVTdGF0ZSwgcHJpbWFy
eV9idXMsDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9QQ0lfQlVTLCBQQ0lCdXMg
KiksDQo+ID4+PiAgfTsNCj4gPj4+IGRpZmYgLS1naXQgYS9ody9hcm0vc21tdXYzLmMgYi9ody9h
cm0vc21tdXYzLmMNCj4gPj4+IGluZGV4IGFiNjc5NzIzNTMuLmJjZjhhZjhkYzcgMTAwNjQ0DQo+
ID4+PiAtLS0gYS9ody9hcm0vc21tdXYzLmMNCj4gPj4+ICsrKyBiL2h3L2FybS9zbW11djMuYw0K
PiA+Pj4gQEAgLTE5OTYsNiArMTk5Niw4IEBAIHN0YXRpYyB2b2lkIHNtbXV2M19jbGFzc19pbml0
KE9iamVjdENsYXNzDQo+ID4+ICprbGFzcywgY29uc3Qgdm9pZCAqZGF0YSkNCj4gPj4+ICAgICAg
ZGV2aWNlX2NsYXNzX3NldF9wYXJlbnRfcmVhbGl6ZShkYywgc21tdV9yZWFsaXplLA0KPiA+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZjLT5wYXJlbnRfcmVhbGl6ZSk7
DQo+ID4+PiAgICAgIGRldmljZV9jbGFzc19zZXRfcHJvcHMoZGMsIHNtbXV2M19wcm9wZXJ0aWVz
KTsNCj4gPj4+ICsgICAgZGMtPmhvdHBsdWdnYWJsZSA9IGZhbHNlOw0KPiA+Pj4gKyAgICBkYy0+
dXNlcl9jcmVhdGFibGUgPSB0cnVlOw0KPiA+Pj4gIH0NCj4gPj4+DQo+ID4+PiAgc3RhdGljIGlu
dCBzbW11djNfbm90aWZ5X2ZsYWdfY2hhbmdlZChJT01NVU1lbW9yeVJlZ2lvbg0KPiAqaW9tbXUs
DQo+ID4+PiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3ZpcnQuYyBiL2h3L2FybS92aXJ0LmMNCj4gPj4+
IGluZGV4IDA1YTE0ODgxY2YuLjg2NjIxNzNjNDMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9ody9hcm0v
dmlydC5jDQo+ID4+PiArKysgYi9ody9hcm0vdmlydC5jDQo+ID4+PiBAQCAtNTYsNiArNTYsNyBA
QA0KPiA+Pj4gICNpbmNsdWRlICJxZW11L2N1dGlscy5oIg0KPiA+Pj4gICNpbmNsdWRlICJxZW11
L2Vycm9yLXJlcG9ydC5oIg0KPiA+Pj4gICNpbmNsdWRlICJxZW11L21vZHVsZS5oIg0KPiA+Pj4g
KyNpbmNsdWRlICJody9wY2kvcGNpX2J1cy5oIg0KPiA+Pj4gICNpbmNsdWRlICJody9wY2ktaG9z
dC9ncGV4LmgiDQo+ID4+PiAgI2luY2x1ZGUgImh3L3ZpcnRpby92aXJ0aW8tcGNpLmgiDQo+ID4+
PiAgI2luY2x1ZGUgImh3L2NvcmUvc3lzYnVzLWZkdC5oIg0KPiA+Pj4gQEAgLTE0NDAsNiArMTQ0
MSwyOCBAQCBzdGF0aWMgdm9pZA0KPiBjcmVhdGVfc21tdXYzX2R0X2JpbmRpbmdzKGNvbnN0DQo+
ID4+IFZpcnRNYWNoaW5lU3RhdGUgKnZtcywgaHdhZGRyIGJhc2UsDQo+ID4+PiAgICAgIGdfZnJl
ZShub2RlKTsNCj4gPj4+ICB9DQo+ID4+Pg0KPiA+Pj4gK3N0YXRpYyB2b2lkIGNyZWF0ZV9zbW11
djNfZGV2X2R0YihWaXJ0TWFjaGluZVN0YXRlICp2bXMsDQo+ID4+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIERldmljZVN0YXRlICpkZXYsIFBDSUJ1cyAqYnVzKQ0KPiA+Pj4g
K3sNCj4gPj4+ICsgICAgUGxhdGZvcm1CdXNEZXZpY2UgKnBidXMgPSBQTEFURk9STV9CVVNfREVW
SUNFKHZtcy0NCj4gPj4+IHBsYXRmb3JtX2J1c19kZXYpOw0KPiA+Pj4gKyAgICBTeXNCdXNEZXZp
Y2UgKnNiZGV2ID0gU1lTX0JVU19ERVZJQ0UoZGV2KTsNCj4gPj4+ICsgICAgaW50IGlycSA9IHBs
YXRmb3JtX2J1c19nZXRfaXJxbihwYnVzLCBzYmRldiwgMCk7DQo+ID4+PiArICAgIGh3YWRkciBi
YXNlID0gcGxhdGZvcm1fYnVzX2dldF9tbWlvX2FkZHIocGJ1cywgc2JkZXYsIDApOw0KPiA+Pj4g
KyAgICBNYWNoaW5lU3RhdGUgKm1zID0gTUFDSElORSh2bXMpOw0KPiA+Pj4gKw0KPiA+Pj4gKyAg
ICBpZiAoc3RyY21wKCJwY2llLjAiLCBidXMtPnFidXMubmFtZSkpIHsNCj4gPj4+ICsgICAgICAg
IHdhcm5fcmVwb3J0KCJTTU1VdjMgZGV2aWNlIG9ubHkgc3VwcG9ydGVkIHdpdGggcGNpZS4wIGZv
cg0KPiBEVCIpOw0KPiA+PiB3aGlsZSB0ZXN0aW5nIHRoZSBzZXJpZXMgSSBoaXQgdGhlIHdhcm5p
bmcgd2l0aCBhIHJoZWwgZ3Vlc3Qgd2hpY2ggYm9vdHMNCj4gPj4gd2l0aCBBQ1BJLg0KPiA+PiBJ
IHRoaW5rIHdlIHNoYWxsIG1ha2UgdGhlIGNoZWNrIHNtYXJ0ZXIgdG8gYXZvaWQgdGhhdC4NCj4g
Pj4gbWF5YmUgYWxzbyBjaGVjayBmaXJtd2FyZV9sb2FkZWQgYW5kIHZpcnRfaXNfYWNwaV9lbmFi
bGVkKCk/DQo+ID4gVGhhbmtzIGZvciBnaXZpbmcgaXQgYSBzcGluLiBZZXMsIGp1c3QgY29uZmly
bWVkIHRoYXQgdGhlIHdhcm5pbmcgYXBwZWFycy4NCj4gPiBUaGUgYWJvdmUgY2hlY2sgd2lsbCB3
b3JrLCBidXQgY2FuIHdlIG1ha2UgdXNlIG9mIHZtcy0+YWNwaV9kZXYgZm9yDQo+ID4gdGhpcyBj
aGVjayBpbnN0ZWFkPyBJdCBpcyBlc3NlbnRpYWxseSB0aGUgc2FtZSBhbmQgSSB0aGluayB0aGF0
IHdpbGwgd29yay4NCj4gPg0KPiA+ICAgICBpZiAoIXZtcy0+YWNwaV9kZXYgJiYgc3RyY21wKCJw
Y2llLjAiLCBidXMtPnFidXMubmFtZSkpDQo+ID4NCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cuDQo+
IA0KPiB3aXRoIHRoYXQgZml4ZWQsIGZlZWwgZnJlZSB0byBhZGQgbXkNCj4gDQo+ICpUZXN0ZWQt
Ynk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4gSSBoYXZlIHRlc3RlZCBub24N
Cj4gcmVncmVzc2lvbiBvbiBsZWdhY3kgU01NVSwgU01NVSBkZXZpY2UgcHJvdGVjdGluZyBwY2ll
LjAgYW5kIHB4Yg0KPiB0b3BvbG9naWVzLiBMb29rcyBnb29kIHRvIG1lLiBUaGFua3MgRXJpYyAq
DQoNCk9rLiBUaGFua3MuDQoNCkFsc28sIGlmIHlvdSBjYW4gdGFrZSBhIGxvb2sgYXQgdGhlIGxh
c3QgcGF0Y2ggYW5kIGhhcHB5IHdpdGggdGhlIGNoYW5nZXMsDQpjYW4gSSBoYXZlIGEgUi1ieSBm
b3IgdGhhdCwgcGxlYXNlID8NCg0KU2hhbWVlcg0K

