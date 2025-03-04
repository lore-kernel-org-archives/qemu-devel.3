Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E39DAC282D3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 09:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpOcG-00079w-GN; Tue, 04 Mar 2025 04:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tpOcA-00078X-AN; Tue, 04 Mar 2025 04:31:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1tpOc6-0003EG-95; Tue, 04 Mar 2025 04:31:02 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6Vjf4JXgz6D91G;
 Tue,  4 Mar 2025 17:28:38 +0800 (CST)
Received: from frapeml500006.china.huawei.com (unknown [7.182.85.219])
 by mail.maildlp.com (Postfix) with ESMTPS id 6874E140A79;
 Tue,  4 Mar 2025 17:30:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (7.182.85.71) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Mar 2025 10:30:50 +0100
Received: from frapeml500008.china.huawei.com ([7.182.85.71]) by
 frapeml500008.china.huawei.com ([7.182.85.71]) with mapi id 15.01.2507.039;
 Tue, 4 Mar 2025 10:30:50 +0100
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rLkOMCAgAAM2QCAAAz2gIAEhqeggCVVAYCAI176AIAE12cAgAGBGYCAAGn5AIACTjRQgAB/1ACAJxm5oIAAEMeAgAEfbGA=
Date: Tue, 4 Mar 2025 09:30:49 +0000
Message-ID: <db59c28747834acf9c1a5cc80d30df81@huawei.com>
References: <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <f4e64a3a-5c1d-49f2-ac72-b84ecd353c9d@redhat.com>
 <Z6EQENkHJy7TrkYy@Asurada-Nvidia>
 <77f736f6-9ef9-462b-916e-c8cfff279044@redhat.com>
 <Z6KsAE9wnjWU0xMs@Asurada-Nvidia>
 <8224c38797344d1a9c0f453774925db3@huawei.com>
 <Z6UGVP3olKvakHUh@Asurada-Nvidia>
 <48e3ac70f9fb4867a9ef835c22d4fda8@huawei.com>
 <Z8XhKyxHwsZo2eBK@Asurada-Nvidia>
In-Reply-To: <Z8XhKyxHwsZo2eBK@Asurada-Nvidia>
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
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDMsIDIwMjUgNTowNSBQ
TQ0KPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50
aG9kaUBodWF3ZWkuY29tPg0KPiBDYzogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29t
PjsgZGR1dGlsZUByZWRoYXQuY29tOyBQZXRlcg0KPiBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxp
bmFyby5vcmc+OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsNCj4gRGFuaWVsIFAu
IEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBX
YW5nemhvdQ0KPiAoQikgPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsgamlhbmdrdW5rdW4gPGpp
YW5na3Vua3VuQGh1YXdlaS5jb20+Ow0KPiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1l
cm9uQGh1YXdlaS5jb20+Ow0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1JGQyBQQVRDSCAwLzVdIGh3L2FybS92aXJ0OiBBZGQgc3VwcG9ydCBmb3IgdXNlci1jcmVh
dGFibGUNCj4gbmVzdGVkIFNNTVV2Mw0KPiANCj4gT24gTW9uLCBNYXIgMDMsIDIwMjUgYXQgMDM6
MjE6NTdQTSArMDAwMCwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaQ0KPiB3cm90ZToNCj4gPiBJ
IGFtIHdvcmtpbmcgb24gdGhlIGFib3ZlIG5vdyBhbmQgaGF2ZSBxdWljayBxdWVzdGlvbiB0byB5
b3Xwn5iKLg0KPiA+DQo+ID4gTG9va2luZyBhdCB0aGUgc21tdV9kZXZfYXR0YWNoX3Zpb21tdSgp
IGZuIGhlcmVbMF0sDQo+ID4gaXQgYXBwZWFycyB0byBkbyB0aGUgZm9sbG93aW5nOg0KPiA+DQo+
ID4gMS4gQWxsb2MgYSBzMl9od3B0IGlmIG5vdCBhbGxvY2F0ZWQgYWxyZWFkeSBhbmQgYXR0YWNo
IGl0Lg0KPiA+IDIuIEFsbG9jYXRlIGFib3J0IGFuZCBieXBhc3MgaHdwdA0KPiA+IDMuIEF0dGFj
aCBieXBhc3MgaHdwdC4NCj4gPg0KPiA+IEkgZGlkbid0IGdldCB3aHkgd2UgYXJlIGRvaW5nIHRo
ZSBzdGVwIDMgaGVyZS4gVG8gbWUgaXQgbG9va3MgbGlrZSwNCj4gPiB3aGVuIHdlIGF0dGFjaCB0
aGUgczJfaHdwdChpZSwgdGhlIG5lc3RlZCBwYXJlbnQgZG9tYWluIGF0dGFjaCksDQo+ID4gdGhl
IGtlcm5lbCB3aWxsIGRvLA0KPiA+DQo+ID4gYXJtX3NtbXVfYXR0YWNoX2RldigpDQo+ID4gICBh
cm1fc21tdV9tYWtlX3MyX2RvbWFpbl9zdGUoKQ0KPiA+DQo+ID4gSXQgYXBwZWFycyB0aHJvdWdo
IHN0ZXAgMywgd2UgYWNoaWV2ZSB0aGUgc2FtZSB0aGluZyBhZ2Fpbi4NCj4gPg0KPiA+IE9yIGl0
IGlzIHBvc3NpYmxlIEkgbWlzc2VkIHNvbWV0aGluZyBvYnZpb3VzIGhlcmUuDQo+IA0KPiBCZWNh
dXNlIGEgZGV2aWNlIGNhbm5vdCBhdHRhY2ggdG8gYSB2SU9NTVUgb2JqZWN0IGRpcmVjdGx5LCBi
dXQNCj4gb25seSB2aWEgYSBwcm94eSBod3B0X25lc3RlZC4gU28sIHRoaXMgYnlwYXNzIGh3cHQg
Z2l2ZXMgdXMgdGhlDQo+IHBvcnQgdG8gYXNzb2NpYXRlIHRoZSBkZXZpY2UgdG8gdGhlIHZJT01N
VSwgYmVmb3JlIGEgdkRFVklDRSBvcg0KPiBhICJ0cmFuc2xhdGUiIGh3cHRfbmVzdGVkIGlzIGFs
bG9jYXRlZC4NCj4gDQo+IEN1cnJlbnRseSBpdCdzIHRoZSBzYW1lIGJlY2F1c2UgYW4gUzIgcGFy
ZW50IGh3cHQgaG9sZHMgYSBWTUlELA0KPiBzbyB3ZSBjb3VsZCBqdXN0IGF0dGFjaCB0aGUgZGV2
aWNlIHRvIHRoZSBTMiBod3B0IGZvciB0aGUgc2FtZQ0KPiBTVEUgY29uZmlndXJhdGlvbiBhcyBh
dHRhY2hpbmcgdGhlIGRldmljZSB0byB0aGUgcHJveHkgYnlwYXNzDQo+IGh3cHQuIFlldCwgdGhp
cyB3aWxsIGNoYW5nZSBpbiB0aGUgZnV0dXJlIGFmdGVyIGxldHRpbmcgdklPTU1VDQo+IG9iamVj
dHMgaG9sZCB0aGVpciBvd24gVk1JRHMgdG8gc2hhcmUgYSBjb21tb24gUzIgcGFyZW50IGh3cHQN
Cj4gdGhhdCB3b24ndCBoYXZlIGEgVk1JRCwgaS5lLiBhcm1fc21tdV9tYWtlX3MyX2RvbWFpbl9z
dGUoKSB3aWxsDQo+IG5lZWQgdGhlIHZJT01NVSBvYmplY3QgdG8gZ2V0IHRoZSBWTUlEIGZvciBT
VEUuDQo+IA0KPiBJIHNob3VsZCBoYXZlIGFkZGVkIGEgZmV3IGxpbmVzIG9mIGNvbW1lbnRzIHRo
ZXJlIDopDQoNCk9rLiBUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4gSSB3aWxsIGtlZXAgaXQg
dGhlbiBhbmQgYWRkIGZldyBjb21tZW50cw0KdG8gbWFrZSBpdCBjbGVhci4NCg0KRG8geW91IGhh
dmUgYW4gaW5pdGlhbCBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgYWJvdmUgd2l0aCB2SU9NTVUgb2Jq
ZWN0DQpob2xkaW5nIHRoZSBWTUlEcyB0byBzaGFyZT8gQWN0dWFsbHkgSSBkbyBoYXZlIGEgZGVw
ZW5kZW5jeSBvbiB0aGF0IGZvcg0KbXkgS1ZNIHBpbm5lZCBWTUlEIHNlcmllc1swXSB3aGVyZSBp
dCB3YXMgc3VnZ2VzdGVkIHRoYXQgdGhlIFZNSUQNCnNob3VsZCBhc3NvY2lhdGVkIHdpdGggYSB2
SU9NTVUgb2JqZWN0IHJhdGhlciB0aGFuIHRoZSBJT01NVUZEDQpjb250ZXh0IEkgdXNlZCBpbiB0
aGVyZS4NCg0KQW5kIEphc29uIG1lbnRpb25lZCBhYm91dCB0aGUgd29yayBpbnZvbHZlZCB0byBk
byB0aGF0IGhlcmVbMV0uIEFwcHJlY2lhdGUNCmlmIHlvdSBjb3VsZCBzaGFyZSBpZiBhbnkgcHJv
Z3Jlc3MgaXMgbWFkZSBvbiB0aGF0IHNvIHRoYXQgSSBjYW4gdHJ5IHRvIHJlYmFzZQ0KdGhhdCBL
Vk0gIFBpbm5lZCBzZXJpZXMgb24gdG9wIG9mIHRoYXQgYW5kIGdpdmUgaXQgYSB0cnkuDQoNClRo
YW5rcywNClNoYW1lZXINClswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21tdS8y
MDI0MDIwODE1MTgzNy4zNTA2OC0xLXNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNv
bS8NClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsLzIwMjQxMTI5
MTUwNjI4LkdHMTI1MzM4OEBudmlkaWEuY29tLw0KDQoNCg0KDQoNCg==

