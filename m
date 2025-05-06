Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531F2C3ABBF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 09:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCEH3-0003AR-Lt; Tue, 06 May 2025 05:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCEGt-00038D-IP; Tue, 06 May 2025 05:07:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uCEGq-0001P2-IV; Tue, 06 May 2025 05:07:27 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZsCCF3Jxfz6K5nM;
 Tue,  6 May 2025 17:04:57 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
 by mail.maildlp.com (Postfix) with ESMTPS id DACC314050C;
 Tue,  6 May 2025 17:07:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500005.china.huawei.com (7.182.85.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 May 2025 11:07:20 +0200
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 6 May 2025 11:07:20 +0200
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Donald Dutile
 <ddutile@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P.
 Berrange" <berrange@redhat.com>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Topic: [PATCH v2 1/6] hw/arm/smmuv3: Add support to associate a PCIe RC
Thread-Index: AQHbu1V0fvNxmQCU0kS/eGPfhGB2G7O/hJOAgAQP+QCAAbsnAA==
Date: Tue, 6 May 2025 09:07:20 +0000
Message-ID: <aa895207758d4515986fd6cfe05b5917@huawei.com>
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-2-shameerali.kolothum.thodi@huawei.com>
 <03c31d89-ad24-4470-99d0-a77e693e3ba2@redhat.com>
 <fd3219d3-bab3-4991-afbe-fd80549bbca4@redhat.com>
In-Reply-To: <fd3219d3-bab3-4991-afbe-fd80549bbca4@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiBNb25kYXksIE1heSA1LCAyMDI1IDk6MTkgQU0N
Cj4gVG86IERvbmFsZCBEdXRpbGUgPGRkdXRpbGVAcmVkaGF0LmNvbT47IFNoYW1lZXJhbGkgS29s
b3RodW0gVGhvZGkNCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbT47IHFl
bXUtYXJtQG5vbmdudS5vcmc7DQo+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgTWFya3VzIEFybWJy
dXN0ZXIgPGFybWJydUByZWRoYXQuY29tPjsNCj4gUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVs
bEBsaW5hcm8ub3JnPjsgRGFuaWVsIFAuIEJlcnJhbmdlDQo+IDxiZXJyYW5nZUByZWRoYXQuY29t
PjsgQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiBDYzogamdnQG52aWRp
YS5jb207IG5pY29saW5jQG52aWRpYS5jb207IGJlcnJhbmdlQHJlZGhhdC5jb207DQo+IG5hdGhh
bmNAbnZpZGlhLmNvbTsgbW9jaHNAbnZpZGlhLmNvbTsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgTGlu
dXhhcm0NCj4gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBXYW5nemhvdSAoQikgPHdhbmd6aG91MUBo
aXNpbGljb24uY29tPjsNCj4gamlhbmdrdW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+OyBK
b25hdGhhbiBDYW1lcm9uDQo+IDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyB6aGFuZ2Zl
aS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNl0gaHcvYXJtL3Nt
bXV2MzogQWRkIHN1cHBvcnQgdG8gYXNzb2NpYXRlIGENCj4gUENJZSBSQw0KPiANCj4gSGksDQo+
IE9uIDUvMi8yNSA4OjE2IFBNLCBEb25hbGQgRHV0aWxlIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiBP
biA1LzIvMjUgNjoyNyBBTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPj4gQWx0aG91Z2gg
dGhpcyBjaGFuZ2UgZG9lcyBub3QgYWZmZWN0IGZ1bmN0aW9uYWxpdHkgYXQgcHJlc2VudCwgaXQg
bGF5cw0KPiA+PiB0aGUgZ3JvdW5kd29yayBmb3IgZW5hYmxpbmcgdXNlci1jcmVhdGVkIFNNTVV2
MyBkZXZpY2VzIGluDQo+ID4+IGZ1dHVyZSBwYXRjaGVzDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYt
Ynk6IFNoYW1lZXIgS29sb3RodW0NCj4gPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2Vp
LmNvbT4NCj4gPj4gLS0tDQo+ID4+IMKgIGh3L2FybS9zbW11djMuYyB8IDI2ICsrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4+IMKgIGh3L2FybS92aXJ0LmPCoMKgIHzCoCAzICsrLQ0KPiA+
PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pj4NCj4gPj4gZGlmZiAtLWdpdCBhL2h3L2FybS9zbW11djMuYyBiL2h3L2FybS9zbW11djMuYw0K
PiA+PiBpbmRleCBhYjY3OTcyMzUzLi42MDVkZTliNzIxIDEwMDY0NA0KPiA+PiAtLS0gYS9ody9h
cm0vc21tdXYzLmMNCj4gPj4gKysrIGIvaHcvYXJtL3NtbXV2My5jDQo+ID4+IEBAIC0yNCw2ICsy
NCw3IEBADQo+ID4+IMKgICNpbmNsdWRlICJody9xZGV2LXByb3BlcnRpZXMuaCINCj4gPj4gwqAg
I2luY2x1ZGUgImh3L3FkZXYtY29yZS5oIg0KPiA+PiDCoCAjaW5jbHVkZSAiaHcvcGNpL3BjaS5o
Ig0KPiA+PiArI2luY2x1ZGUgImh3L3BjaS9wY2lfYnJpZGdlLmgiDQo+ID4+IMKgICNpbmNsdWRl
ICJjcHUuaCINCj4gPj4gwqAgI2luY2x1ZGUgImV4ZWMvdGFyZ2V0X3BhZ2UuaCINCj4gPj4gwqAg
I2luY2x1ZGUgInRyYWNlLmgiDQo+ID4+IEBAIC0xODc0LDYgKzE4NzUsMjUgQEAgc3RhdGljIHZv
aWQgc21tdV9yZXNldF9leGl0KE9iamVjdCAqb2JqLA0KPiA+PiBSZXNldFR5cGUgdHlwZSkNCj4g
Pj4gwqDCoMKgwqDCoCBzbW11djNfaW5pdF9yZWdzKHMpOw0KPiA+PiDCoCB9DQo+ID4+IMKgICtz
dGF0aWMgaW50IHNtbXV2M19wY2llX2J1cyhPYmplY3QgKm9iaiwgdm9pZCAqb3BhcXVlKQ0KPiA+
PiArew0KPiA+PiArwqDCoMKgIERldmljZVN0YXRlICpkID0gb3BhcXVlOw0KPiA+PiArwqDCoMKg
IFBDSUJ1cyAqYnVzOw0KPiA+PiArDQo+ID4+ICvCoMKgwqAgaWYgKCFvYmplY3RfZHluYW1pY19j
YXN0KG9iaiwgVFlQRV9QQ0lfSE9TVF9CUklER0UpKSB7DQo+ID4+ICvCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gMDsNCj4gPj4gK8KgwqDCoCB9DQo+ID4+ICsNCj4gPj4gK8KgwqDCoCBidXMgPSBQQ0lf
SE9TVF9CUklER0Uob2JqKS0+YnVzOw0KPiA+PiArwqDCoMKgIGlmIChkLT5wYXJlbnRfYnVzICYm
ICFzdHJjbXAoYnVzLT5xYnVzLm5hbWUsDQo+ID4+IGQtPnBhcmVudF9idXMtPm5hbWUpKSB7DQo+
ID4+ICvCoMKgwqDCoMKgwqDCoCBvYmplY3RfcHJvcGVydHlfc2V0X2xpbmsoT0JKRUNUKGQpLCAi
cHJpbWFyeS1idXMiLCBPQkpFQ1QoYnVzKSwNCj4gPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmVycm9yX2Fib3J0KTsN
Cj4gPj4gK8KgwqDCoMKgwqDCoMKgIC8qIFJldHVybiBub24temVybyBhcyB3ZSBnb3QgdGhlIGJ1
cyBhbmQgZG9uJ3QgbmVlZCBmdXJ0aGVyDQo+ID4+IGl0ZXJhdGlvbi4qLw0KPiA+PiArwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIDE7DQo+ID4+ICvCoMKgwqAgfQ0KPiA+PiArwqDCoMKgIHJldHVybiAw
Ow0KPiA+PiArfQ0KPiA+PiArDQo+ID4+IMKgIHN0YXRpYyB2b2lkIHNtbXVfcmVhbGl6ZShEZXZp
Y2VTdGF0ZSAqZCwgRXJyb3IgKiplcnJwKQ0KPiA+PiDCoCB7DQo+ID4+IMKgwqDCoMKgwqAgU01N
VVN0YXRlICpzeXMgPSBBUk1fU01NVShkKTsNCj4gPj4gQEAgLTE4ODIsNiArMTkwMiwxMCBAQCBz
dGF0aWMgdm9pZCBzbW11X3JlYWxpemUoRGV2aWNlU3RhdGUgKmQsDQo+IEVycm9yDQo+ID4+ICoq
ZXJycCkNCj4gPj4gwqDCoMKgwqDCoCBTeXNCdXNEZXZpY2UgKmRldiA9IFNZU19CVVNfREVWSUNF
KGQpOw0KPiA+PiDCoMKgwqDCoMKgIEVycm9yICpsb2NhbF9lcnIgPSBOVUxMOw0KPiA+PiDCoCAr
wqDCoMKgIGlmICghb2JqZWN0X3Byb3BlcnR5X2dldF9saW5rKE9CSkVDVChkKSwgInByaW1hcnkt
YnVzIiwNCj4gPj4gJmVycm9yX2Fib3J0KSkgew0KPiA+PiArwqDCoMKgwqDCoMKgwqAgb2JqZWN0
X2NoaWxkX2ZvcmVhY2hfcmVjdXJzaXZlKG9iamVjdF9nZXRfcm9vdCgpLA0KPiA+PiBzbW11djNf
cGNpZV9idXMsIGQpOw0KPiA+PiArwqDCoMKgIH0NCj4gPj4gKw0KPiA+PiDCoMKgwqDCoMKgIGMt
PnBhcmVudF9yZWFsaXplKGQsICZsb2NhbF9lcnIpOw0KPiA+PiDCoMKgwqDCoMKgIGlmIChsb2Nh
bF9lcnIpIHsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBs
b2NhbF9lcnIpOw0KPiA+PiBAQCAtMTk5Niw2ICsyMDIwLDggQEAgc3RhdGljIHZvaWQgc21tdXYz
X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MNCj4gPj4gKmtsYXNzLCBjb25zdCB2b2lkICpkYXRhKQ0K
PiA+PiDCoMKgwqDCoMKgIGRldmljZV9jbGFzc19zZXRfcGFyZW50X3JlYWxpemUoZGMsIHNtbXVf
cmVhbGl6ZSwNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmMtPnBhcmVudF9yZWFsaXplKTsNCj4g
Pj4gwqDCoMKgwqDCoCBkZXZpY2VfY2xhc3Nfc2V0X3Byb3BzKGRjLCBzbW11djNfcHJvcGVydGll
cyk7DQo+ID4+ICvCoMKgwqAgZGMtPmhvdHBsdWdnYWJsZSA9IGZhbHNlOw0KPiA+PiArwqDCoMKg
IGRjLT5idXNfdHlwZSA9IFRZUEVfUENJRV9CVVM7DQo+ID4gRG9lcyB0aGlzIGZvcmNlIGxlZ2Fj
eSBTTU1VdjMgdG8gYmUgdGllZCB0byBhIFBDSWUgYnVzIG5vdz8NCj4gPiBpZiBzbywgd2lsbCB0
aGF0IGJyZWFrIHNvbWUgZXhpc3RpbmcgbGVnYWN5IHNtbXV2MyBjb25maWdzPywgaS5lLiwNCj4g
PiB2aXJ0aW8tc2NzaSBhdHRhY2hlZCB0byBhIGxlZ2FjeSBzbW11djMuDQo+IA0KPiBQcmV2aW91
c2x5IHRoZSBTTU1VIHdhcyBhbHJlYWR5IGFsd2F5cyBhdHRhY2hlZCB0byBhIFBDSSBwcmltYXJ5
LWJ1cw0KPiAodm1zLT5idXMgaWUuIHBjaTApLiB2aXJ0aW8tc2NzaS1wY2kgaXMgdGhlIGRldmlj
ZSBiZWluZyBwcm90ZWN0ZWQuIFRoZQ0KPiBTTU1VIGlzIG5vdCBhYmxlIHRvIHByb3RlY3QgcGxh
dGZvcm1zIGRldmljZXMgYXRtLg0KPiANCj4gTXkgb25seSBjb25jZXJuIGlzIHdlIGFyZSBoaWdo
amFja2luZyB0aGUgImJ1cyIgcHJvcCB0byByZWNvcmQgdGhlIGJ1cw0KPiBoaWVyYXJjaHkgdGhl
IFNNTVUgaXMgcHJvdGVjdGluZy4gV2hpbGUgdGhlIFNNTVUgaXMgYSBwbGF0Zm9ybSBkZXZpY2UN
Cj4gYW5kIGRvZXMgbm90IGluaGVyaXQgdGhlIFBDSSBkZXZpY2UgYmFzZSBjbGFzcyBpdHMgYnVz
IHR5cGUgYmVjb21lcw0KPiAiVFlQRV9QQ0lFX0JVUyIuIFNvIGluIHRlcm1zIG9mIHFvbSBoaWVy
YWNoeSBpcyBpcyBzZWVuIGFzIGEgUENJIGRldmljZQ0KPiBub3c/IEkgZG9uJ3Qga25vdyBpZiBp
dCBpcyBhIHByb2JsZW0uIEFuIGFsdGVybmF0aXZlIGNvdWxkIGJlIHRvIGtlZXANCj4gdGhlIGJ1
cyBwb2ludGVyIGFuZCB0eXBlIGFzIGl0IHdhcyBiZWZvcmUgYW5kIGludHJvZHVjZSBhIHByaW1h
cnktYnVzDQo+IHByb3BlcnR5LiBBZGRpbmcgTWFya3VzLCBQZXRlciwgRGFuaWVsIGFuZCBBbGV4
IGluIHRvLg0KDQpZZXMuIFRoZSBTTU1VVjMgaXMgYSBwbGF0Zm9ybSBkZXZpY2UgYW5kIHdlIGFy
ZSBtYWtpbmcgdGhlIGJ1cyB0eXBlDQpoZXJlIGFzIFBDSUUgd2hpY2ggaXMgYSBiaXQgb2RkLiBB
cyByZXBsaWVkIGVsc2V3aGVyZSBpbiB0aGlzIHRocmVhZCwNCmluIHRoZSBpbml0aWFsIFJGQyB3
ZSBoYWQgYSBzcGVjaWZpYyAicGNpLWJ1cyIgcHJvcGVydHkgYXNzb2NpYXRlZCB3aXRoIA0KU01N
VXYzIGRldmljZSwgDQpFZzoNCi1kZXZpY2UgYXJtLXNtbXV2MyxwY2ktYnVzPXBjaWUuMCwuLi4N
Cg0KQnV0IHRoZW4gdGhlcmUgd2VyZSBmZWVkYmFjayB0aGF0LCBpdCBpcyBtb3JlIGludHVpdGl2
ZSBhbmQgZWFzeSBmb3IgbGlidmlydA0KaWYgd2UgY2FuIGp1c3QgdXNlIHRoZSBkZWZhdWx0ICJi
dXMiIHByb3BlcnR5IGFzc29jaWF0ZWQgd2l0aCBhICBRZW11IGRldmljZS4NCkhlbmNlIHRoZSBj
aGFuZ2UuDQoNCj4gDQo+IEF0IHNvbWUgcG9pbnQgaXQgd2FzIGVudmlzaW9ubmVkIHRvIHN1cHBv
cnQgcHJvdGVjdGVkIHBsYXRmb3JtIGRldmljZXMNCj4gKEkgdGhpbmsgdGhpcyB3YXMgbmVlZCBm
b3IgQ0NBKS4gTXkgZmVhciBpcyB0aGF0IGlmIHdlIHR1cm4gdGhlIGJ1cyB0eXBlDQo+IHRvIFBD
SUUgaXQgbWF5IGJlIGRpZmZpY3VsdCB0byBleHRlbmQgdGhlIHN1cHBvcnQgdG8gbm9uIFBDSWUg
cHJvdGVjdGVkDQo+IGRldmljZXMuIFRoZSBTTU1VIHNoYWxsIHJlbWFpbiBhIHBsYXRmb3JtIGRl
dmljZSBiZWluZyBhYmxlIHRvIHByb3RlY3QNCj4gZWl0aGVyIFBDSSBkZXZpY2VzIGFuZCwgaW4g
dGhlIGZ1dHVyZSwgcGxhdGZvcm0gZGV2aWNlcy4NCg0KT2suIFNvIGluIHRoZSBjYXNlIG9mIHBs
YXRmb3JtIGRldmljZSBob3cgZG8gd2UgZW52aXNhZ2UgdG8gc3BlY2lmeSB0aGUgImJ1cyI/DQoN
Ci1kZXZpY2UgYXJtLXNtbXYzLCBwcmltYXJ5LWJ1cz1zeXNidXMNCg0KT3Igc29tZXRoaW5nIGxp
a2UgaGF2aW5nIGEgU01NVXYzIGRldiB3aXRob3V0IGFueSBidXMgYW5kIGVhY2ggcGxhdGZvcm0N
CmRldmljZSBoYXMgdG8gc3BlY2lmeSB0aGUgU01NVXYzPw0KRWc6DQoNCi1kZXZpY2UgYXJtLXNt
bXYzLGlkPXNtbXV2My4zDQotZGV2aWNlIHh4eHgsc21tdXYzPSBzbW11djMuMw0KDQpJZiBsYXRl
ciwgSSB0aGluayB3ZSBjYW4gc3RpY2sgdG8gY3VycmVudCBvbmUuIA0KDQpUaGFua3MsDQpTaGFt
ZWVyDQo=

