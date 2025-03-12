Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE6EC28B2F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsOqe-0002FP-JC; Wed, 12 Mar 2025 12:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsOqb-0002Df-Nj; Wed, 12 Mar 2025 12:22:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tsOqY-00029M-NQ; Wed, 12 Mar 2025 12:22:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZCbQ218ZQz6FGW2;
 Thu, 13 Mar 2025 00:17:46 +0800 (CST)
Received: from frapeml100005.china.huawei.com (unknown [7.182.85.132])
 by mail.maildlp.com (Postfix) with ESMTPS id 305A51404FC;
 Thu, 13 Mar 2025 00:22:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml100005.china.huawei.com (7.182.85.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Mar 2025 17:22:14 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Wed, 12 Mar 2025 17:22:14 +0100
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
Thread-Index: AQHbko9X7BBFIVL5UECoP8opJSgSfrNvkyYAgAAR74D///hiAIAAEm+A
Date: Wed, 12 Mar 2025 16:22:14 +0000
Message-ID: <5d894a546d3f4081ac2cfe98bd2ea612@huawei.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-5-shameerali.kolothum.thodi@huawei.com>
 <547f961e-380c-4ffe-8b8b-3e9d543aa702@redhat.com>
 <58c9c37876c64584b0c7961ec61696a3@huawei.com>
 <5b29ea01-1b86-4b48-a769-14986751a0f1@redhat.com>
In-Reply-To: <5b29ea01-1b86-4b48-a769-14986751a0f1@redhat.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcWVtdS1kZXZlbC0NCj4g
Ym91bmNlcytzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpPWh1YXdlaS5jb21Abm9uZ251Lm9yZyA8
cWVtdS0NCj4gZGV2ZWwtYm91bmNlcytzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpPWh1YXdlaS5j
b21Abm9uZ251Lm9yZz4gT24NCj4gQmVoYWxmIE9mIEVyaWMgQXVnZXINCj4gU2VudDogV2VkbmVz
ZGF5LCBNYXJjaCAxMiwgMjAyNSA0OjEzIFBNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRo
b2RpDQo+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBxZW11LWFybUBu
b25nbnUub3JnOw0KPiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgamdnQG52aWRpYS5jb207IG5pY29saW5jQG52aWRpYS5jb207DQo+IGRkdXRp
bGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VAcmVkaGF0LmNvbTsgbmF0aGFuY0BudmlkaWEuY29tOw0K
PiBtb2Noc0BudmlkaWEuY29tOyBzbW9zdGFmYUBnb29nbGUuY29tOyBMaW51eGFybQ0KPiA8bGlu
dXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+
Ow0KPiBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVy
b24NCj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5hcm8u
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYyIDA0LzIwXSBody9hcm0vdmlydDogQWRk
IHN1cHBvcnQgZm9yIHNtbXV2My0NCj4gYWNjZWwNCj4gDQo+IEhpIFNoYW1lZXIsDQo+IA0KPiAN
Cj4gT24gMy8xMi8yNSA0OjQ2IFBNLCBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIHdyb3RlOg0K
PiA+IEhpIEVyaWMsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4g
RnJvbTogcWVtdS1kZXZlbC0NCj4gPj4gYm91bmNlcytzaGFtZWVyYWxpLmtvbG90aHVtLnRob2Rp
PWh1YXdlaS5jb21Abm9uZ251Lm9yZyA8cWVtdS0NCj4gPj4gZGV2ZWwtYm91bmNlcytzaGFtZWVy
YWxpLmtvbG90aHVtLnRob2RpPWh1YXdlaS5jb21Abm9uZ251Lm9yZz4NCj4gT24NCj4gPj4gQmVo
YWxmIE9mIEVyaWMgQXVnZXINCj4gPj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxMiwgMjAyNSAz
OjM2IFBNDQo+ID4+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpDQo+ID4+IDxzaGFtZWVy
YWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+OyBxZW11LWFybUBub25nbnUub3JnOw0KPiA+
PiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPj4gQ2M6IHBldGVyLm1heWRlbGxAbGluYXJvLm9y
ZzsgamdnQG52aWRpYS5jb207IG5pY29saW5jQG52aWRpYS5jb207DQo+ID4+IGRkdXRpbGVAcmVk
aGF0LmNvbTsgYmVycmFuZ2VAcmVkaGF0LmNvbTsgbmF0aGFuY0BudmlkaWEuY29tOw0KPiA+PiBt
b2Noc0BudmlkaWEuY29tOyBzbW9zdGFmYUBnb29nbGUuY29tOyBMaW51eGFybQ0KPiA+PiA8bGlu
dXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKSA8d2FuZ3pob3UxQGhpc2lsaWNvbi5jb20+
Ow0KPiA+PiBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENh
bWVyb24NCj4gPj4gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IHpoYW5nZmVpLmdhb0Bs
aW5hcm8ub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHYyIDA0LzIwXSBody9hcm0v
dmlydDogQWRkIHN1cHBvcnQgZm9yDQo+ID4+IHNtbXV2My0gYWNjZWwNCj4gPj4NCj4gPj4gSGkg
U2hhbWVlciwNCj4gPj4NCj4gPj4NCj4gPj4gT24gMy8xMS8yNSAzOjEwIFBNLCBTaGFtZWVyIEtv
bG90aHVtIHdyb3RlOg0KPiA+Pj4gQWxsb3cgY29sZC1wbHVnIHNtbXV2My1hY2NlbCB0byB2aXJ0
IElmIHRoZSBtYWNoaW5lIHdpZGUgc21tdXYzIGlzDQo+ID4+PiBub3Qgc3BlY2lmaWVkLg0KPiA+
Pj4NCj4gPj4+IE5vIEZEVCBzdXBwb3J0IGlzIGFkZGVkIGZvciBub3cuDQo+ID4+Pg0KPiA+Pj4g
U2lnbmVkLW9mZi1ieTogU2hhbWVlciBLb2xvdGh1bQ0KPiA+PiA8c2hhbWVlcmFsaS5rb2xvdGh1
bS50aG9kaUBodWF3ZWkuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgaHcvYXJtL3ZpcnQuYyAgICAg
ICAgIHwgMTIgKysrKysrKysrKysrDQo+ID4+PiAgaHcvY29yZS9zeXNidXMtZmR0LmMgIHwgIDEg
Kw0KPiA+Pj4gIGluY2x1ZGUvaHcvYXJtL3ZpcnQuaCB8ICAxICsNCj4gPj4+ICAzIGZpbGVzIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvaHcvYXJt
L3ZpcnQuYyBiL2h3L2FybS92aXJ0LmMgaW5kZXgNCj4gPj4+IDRhNWE5NjY2ZTkuLjg0YTMyM2Rh
NTUgMTAwNjQ0DQo+ID4+PiAtLS0gYS9ody9hcm0vdmlydC5jDQo+ID4+PiArKysgYi9ody9hcm0v
dmlydC5jDQo+ID4+PiBAQCAtNzMsNiArNzMsNyBAQA0KPiA+Pj4gICNpbmNsdWRlICJxb2JqZWN0
L3FsaXN0LmgiDQo+ID4+PiAgI2luY2x1ZGUgInN0YW5kYXJkLWhlYWRlcnMvbGludXgvaW5wdXQu
aCINCj4gPj4+ICAjaW5jbHVkZSAiaHcvYXJtL3NtbXV2My5oIg0KPiA+Pj4gKyNpbmNsdWRlICJo
dy9hcm0vc21tdXYzLWFjY2VsLmgiDQo+ID4+PiAgI2luY2x1ZGUgImh3L2FjcGkvYWNwaS5oIg0K
PiA+Pj4gICNpbmNsdWRlICJ0YXJnZXQvYXJtL2NwdS1xb20uaCINCj4gPj4+ICAjaW5jbHVkZSAi
dGFyZ2V0L2FybS9pbnRlcm5hbHMuaCINCj4gPj4+IEBAIC0yOTExLDYgKzI5MTIsMTYgQEAgc3Rh
dGljIHZvaWQNCj4gPj4gdmlydF9tYWNoaW5lX2RldmljZV9wbHVnX2NiKEhvdHBsdWdIYW5kbGVy
ICpob3RwbHVnX2RldiwNCj4gPj4+ICAgICAgICAgICAgICBwbGF0Zm9ybV9idXNfbGlua19kZXZp
Y2UoUExBVEZPUk1fQlVTX0RFVklDRSh2bXMtDQo+ID4+PiBwbGF0Zm9ybV9idXNfZGV2KSwNCj4g
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU1lTX0JVU19ERVZJQ0Uo
ZGV2KSk7DQo+ID4+PiAgICAgICAgICB9DQo+ID4+PiArICAgICAgICBpZiAob2JqZWN0X2R5bmFt
aWNfY2FzdChPQkpFQ1QoZGV2KSwNCj4gPj4+ICsgVFlQRV9BUk1fU01NVVYzX0FDQ0VMKSkNCj4g
Pj4gew0KPiA+Pj4gKyAgICAgICAgICAgIGlmICh2bXMtPmlvbW11ID09IFZJUlRfSU9NTVVfU01N
VVYzKSB7DQo+ID4+IG1heWJlIGp1c3QgY2hlY2sgd2hldGhlciBpdCBpcyAhPSBWSVJUX0lPTU1V
X05PTkU/DQo+ID4+PiArICAgICAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwNCj4gPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAiaW9tbXU9c21tdXYzIGlzIGFscmVhZHkgc3BlY2lm
aWVkLg0KPiA+Pj4gKyBjYW4ndCBjcmVhdGUNCj4gPj4gc21tdXYzLWFjY2VsIGRldiIpOw0KPiA+
PiBJIHdvdWxkIGNsZWFybHkgc3RhdGUgImlvbW11PXNtbXV2MyB2aXJ0IG1hY2hpbmUgb3B0aW9u
IGlzIGFscmVhZHQgc2V0Ig0KPiA+PiBhbmQgdXNlIGFuIGVycm9yIGhpbnQgdG8gc2F5IGJvdGgg
YXJlIG5vdCBjb21wYXRpYmxlLg0KPiA+Pj4gKyAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4+
PiArICAgICAgICAgICAgfQ0KPiA+Pj4gKyAgICAgICAgICAgIGlmICh2bXMtPmlvbW11ICE9IFZJ
UlRfSU9NTVVfU01NVVYzX0FDQ0VMKSB7DQo+ID4+PiArICAgICAgICAgICAgICAgIHZtcy0+aW9t
bXUgPSBWSVJUX0lPTU1VX1NNTVVWM19BQ0NFTDsNCj4gPj4gSSBrbm93IHRoZXJlIHdlcmUgcXVp
dGUgYSBsb3Qgb2YgZGljdXNzaW9ucyBvbiB0aGUgMXN0IG11bHRpDQo+ID4+IGluc3RhbnRpYXRp
b24gc2VyaWVzIHJlbGF0ZWQgdG8gdGhlIHdheSB3ZSBpbnN0YW5hdGlhdGUgdGhhdCBkZXZpY2UN
Cj4gPj4gYW5kIG1heWJlIEkgbWlzc2VkIHNvbWUgYmxvY2tlcnMgYnV0IHdoeSB3b3VsZG4ndCB3
ZSBhbGxvdyB0aGUNCj4gPj4gaW5zdGFudGlhdGlvbiBvZiB0aGUgbGVnYWN5IHNtbXUgZGV2aWNl
IHdpdGggLWRldmljZSB0b28uIEkgdGhpbmsNCj4gPj4gdGhpcyB3b3VsZCBiZSBzaW1wbGVyIGZv
ciBsaWJ2aXJ0IGFuZCB3ZSB3b3VsZCBzb21laG93IGRlcHJlY2F0ZSB0aGUNCj4gPj4gbWFjaGlu
ZSBvcHRpb24gbWV0aG9kPyB3b3VsZCB0aGF0IG1ha2UgYSBwcm9ibGVtIGlmIHlvdSB3ZXJlIHRv
IHVzZQ0KPiA+PiAtZGV2aWNlIHNtbXUsYWNjZWwgb3Igc29tZXRoaW5nIGFsaWtlPw0KPiA+IFRo
YW5rcyBmb3IgdGFraW5nIGEgbG9vay4gSSBhbSBqdXN0IGp1bXBpbmcgb24gdGhpcyBvbmUgZm9y
IG5vdy4gIFllcywNCj4gPiB0aGVyZSB3ZXJlIGRpc2N1c3Npb25zIGFyb3VuZCB0aGF0LiBCdXQg
SSB3YXMgbm90IHN1cmUgd2UgY29uY2x1ZGVkIG9uDQo+ID4gZGVwcmVjYXRpbmcgdGhlIG1hY2hp
bmUgb3B0aW9uLiBTbyBpZiBJIGdldCB5b3UgY29ycmVjdGx5IHRoZSBpZGVhIGlzLA0KPiA+DQo+
ID4gaWYgd2UgaGF2ZSwNCj4gPiAtZGV2aWNlIHNtbXV2MyBpdCB3aWxsIGluc3RhbnRpYXRlIHRo
ZSBjdXJyZW50IG1hY2hpbmUgd2lkZSBzbW11djMgYW5kDQo+ID4gZm9yIC1kZXZpY2Ugc21tdXYz
LGFjY2VsIHRoaXMgZGV2aWNlPw0KPiB5ZXMgdGhhdCB3b3VsZCBiZSBteSBwcmVmZXJlbmNlLg0K
DQpPay4gSSB3aWxsIGxvb2sgaW50byB0aGF0IGluIG15IG5leHQgcmVzcGluLiBBIHF1aWNrIHF1
ZXN0aW9uLiBEb2VzIHFlbXUNCkRFVklDRSBtb2RlbCBzdXBwb3J0IHRoZSBkaWZmZXJlbnRpYXRp
b24gbGlrZSBhYm92ZSBlYXNpbHk/IE9yIHdlIGhhdmUNCnRvIG1hbmFnZSBpdCB3aXRoIHByb3Bl
cnRpZXM/DQoNCkFueSBleGFtcGxlIGRldmljZSBpbXBsZW1lbnRhdGlvbiBsaWtlIGFib3ZlIGFs
cmVhZHkgdGhlcmU/DQpQbGVhc2UgbGV0IG1lIGtub3cuDQoNClRoYW5rcywNClNoYW1lZXINCg0K
DQogDQoNCg==

